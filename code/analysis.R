#####################
#####################
### TEXT ANALYSIS ###
#####################
#####################

# --- Library's --- #
library(readr)
library(textstem)
library(vader)
library(yardstick)
library(stm)
library(ggplot2)
library(ggraph)

# --- VADER Sentiment lexicon --- # 

# Create an unique id to each row of the data
airbnb <- airbnb %>%
    rownames_to_column("unique_id")

# Only keep necessary rows
airbnb_sentiment <- 
    airbnb %>%
    select(unique_id, comments)

# Using VADER to classify multiple review's sentiment in one go, note: VADER does not need any cleaning
vader_sent <-
    vader_df(airbnb_sentiment$comments)

# The main column of interest is 'compound', which computes the sentiment of a text as a number ranging between -1 (most negative) and +1 (most positive)
vader_sent2 <-
    vader_sent %>%
    # create a row number to merge it back into the original data
    rowid_to_column("unique_id") %>%
    # remove any errors
    filter(word_scores != 'ERROR') %>%
    # classify as positive or negative
    mutate(vader_class = case_when(
        compound < -0.05 - "negative",
        compound > 0.05 - "positive",
        # the final case must always be written as TRUE - something
        TRUE - "neutral")) %>%
    select(unique_id, vader_class)

# Merge the sentiment classification back into the airbnb_sentiment data
airbnb_sentiment <-
    airbnb_sentiment %>%
    mutate(unique_id = as.integer(unique_id)) %>%
    inner_join(vader_sent2, by = "unique_id")

# Plot the results
vader_sent3 %>%
    ggplot(aes(x = vader_class)) +
    geom_bar()

ggsave("output/plot_vader_sent.pdf")

# --- Topic models --- # 

# We pick a sample of the dataset to increase efficiency 
set.seed(1234567890)
seed_users <- 
    airbnb_sentiment %>%
    sample(250)

# Clean the data
tidy_reviews <-
    airbnb_sentiment %>%
    unnest_tokens(word, comments) %>%
    # every word on one row
    mutate(word = lemmatize_words(word))

nums <- tidy_reviews %>% 
    filter(str_detect(word, "^[0-9]")) %>%
    # filter out numerics 
    select(word) %>%
    unique()
    # only keep unique words for every unique id 

# delete words that are frequent but provide little information for analysis
my_stop_words <- tibble(
    word = c(
        "#LOOK", "#FOR", "#WORDS"
    ),
    lexicon = "one of the words"
)

tidy_reviews <-
    tidy_reviews %>%
    anti_join(stop_words) %>%
    anti_join(my_stop_words) %>%
    anti_join(nums, by = "word") %>%
    select()-#the word we put in lexicon, -source

word_counts <- 
    tidy_reviews %>%
    group_by(word) %>%
    count(sort = TRUE) %>%
    filter(n > 5)

tidy_reviews <-
    tidy_reviews %>%
    filter(word %in% word_counts$word)

write_csv(tidy_reviews, 'data/tidy_reviews.csv')


# For each review count the number of times a word occurs in it
word_counts <-
    airbnb %>%
    count(id, comments) %>%
    ungroup()