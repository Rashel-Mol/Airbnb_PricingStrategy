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
library(tidytext)
library(stringr)

# --- Sampling --- #

# Because of the big dataset, we make use of a prototype which exist of a sample of 500 observations
# Set seed so that everyone gets the same sample after running.
set.seed(1234567890)


# We did make a sample of 500 observations. 
sample_airbnb <- airbnb[sample.int(nrow(airbnb),500),]

# --- VADER Sentiment lexicon --- # 

# Only keep necessary rows.
airbnb_sentiment <- 
    sample_airbnb %>%
    select(comments)

# Using VADER to classify multiple review's sentiment in one go, note: VADER does not need any cleaning.
vader_sent <-
    vader_df(airbnb_sentiment$comments)

# The main column of interest is 'compound', which computes the sentiment of a text as a number ranging between -1 (most negative) and +1 (most positive).
vader_sent2 <-
    vader_sent %>%
    # create a row number to merge it back into the original data
    # rowid_to_column("unique_id") %>%
    # remove any errors
    filter(word_scores != 'ERROR') %>%
    # classify as positive or negative
    mutate(vader_class = case_when(
        compound < -0.05 ~ "negative",
        compound > 0.05 ~ "positive",
        # the final case must always be written as TRUE - something
        TRUE ~ "neutral")) %>%
    select(vader_class, text)

# Merge the sentiment classification back into the sample_airbnb data.
sample_airbnb <-
    sample_airbnb %>%
    inner_join(vader_sent2, by = c("comments" = "text"))

# Select the variables compound and text. 
vader_sent3 <- 
    vader_sent %>%
    select(compound, text)

# Merge the compound back into the sample_airbnb data.
sample_airbnb <-
    sample_airbnb %>%
    inner_join(vader_sent3, by = c("comments" = "text"))

# Remove duplicates
# There are two similar comments for two different id's, namely: Perfect. 
# The innerjoin funtion therefore copied these comments, so we now have 2 extra observations in the dataset
# We remove these, so we have a sample of 500 unique observations again, by removing the duplicates
# Note that this cannot be done for all analysis; other ways to do this are creating unique ID's on forehand. 
sample_airbnb <- 
    sample_airbnb %>% 
    filter(!duplicated(sample_airbnb))

# Plot the results.
sample_airbnb %>%
    ggplot(aes(x = vader_class)) +
    geom_bar()

ggsave("gen/output/plot_vader_sent.pdf")

# --- Prepare Data for Topic Models --- # 

# We pick a sample of the dataset to increase efficiency. 
set.seed(1234567890)
airbnb_sentiment <- airbnb[sample.int(nrow(airbnb_sentiment),250),]

# Clean the data.
tidy_reviews <-
    airbnb_sentiment %>%
    unnest_tokens(word, comments) %>%
    # every word on one row
    mutate(word = lemmatize_words(word))

#Select words that include numeric values. 
nums <- tidy_reviews %>% 
    filter(str_detect(word, "^[0-9]")) %>%
    # filter out numerics 
    select(word) %>%
    # only keep the column with unnested words
    unique()
    # only keep unique words for every unique id 

# Search for most frequently used words. 
freq_words <- 
    tidy_reviews %>% count(word)

# Select words that are frequent but provide little information for analysis,
# but are not in the stop_word package. 
my_stop_words <- tibble(
    word = c(
        "stay", "stayed"))

# Remove observations with general stop words, self-selected stop words and numbers. 
tidy_reviews <-
    tidy_reviews %>%
    anti_join(stop_words) %>%
    anti_join(my_stop_words) %>%
    anti_join(nums, by = "word")

# Count how often words occur and only include the words that occur more than 5 times. 
word_counts <- 
    tidy_reviews %>%
    group_by(word) %>%
    count(sort = TRUE) %>%
    filter(n > 5)

# Keep in tidy_reviews only the words that appear in word_counts (so occur more than 5 times).
tidy_reviews <-
    tidy_reviews %>%
    filter(word %in% word_counts$word)

# Create new csv. 
write_csv(tidy_reviews, 'gen/temp/tidy_reviews.csv')

# For each review count the number of times a word occurs in it.
doc_word_counts <-
    tidy_reviews %>%
    count(id, word) %>%
    ungroup()

# Transform the word counts into a document term matrix, using the stm package. 
reviews_dtm <-
    doc_word_counts %>%
    cast_sparse(id, word, n)

# --- Estimate Topic Model --- #

reviews_lda <-
    stm(reviews_dtm,
        K = 5,
        seed = 123456789)

# Print out the top words associated with each topic. 
labelTopics(reviews_lda)

# Find the topic that each review is most likely to belong to. 
reviews_gamma <- 
    tidy(reviews_lda,
         matrix = "gamma",
         document_names = rownames(reviews_dtm)
    ) %>%
    rename(id = document) %>%
    group_by(id) %>%
    slice_max(gamma) %>%
    select(-gamma)

# Convert the variable id in the dataset airbnb_sentiment to the same class \n (character) as the variable id in the dataset reviews_gamma. 
airbnb_sentiment$id <- as.character(airbnb_sentiment$id)

# Merge reviews_gamma with airbnb_sentiment. 
airbnb_sentiment <-
    airbnb_sentiment %>%
    inner_join(reviews_gamma, by = "id")

# We identified 5 themes in the topics. These themes are used as topic labels. 
airbnb_sentiment <-
    airbnb_sentiment %>%
    mutate(topic = case_when(
        topic == 1 ~ "Amenity",
        topic == 2 ~ "Host",
        topic == 3 ~ "Activity",
        topic == 4 ~ "Location",
        TRUE ~ "Distance"
    ))

# Create a plot that visualizes how each topic varies with the overall sentiment of the text. 
airbnb_sentiment %>%
    ggplot(aes(x = topic)) +
    geom_bar()

#Save the plot. 
ggsave("gen/output/sentiment_topics.pdf")
