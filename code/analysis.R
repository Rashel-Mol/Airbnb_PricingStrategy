#####################
#####################
### TEXT ANALYSIS ###
#####################
#####################

# VADER Sentiment lexicon is used to perform sentiment analysis, i.e. classifying text as positive, negative to neutral tone.

# Library's 
library(readr)
library(dplyr)
library(tibble)
library(tidyr)
library(tidytext)
library(ggplot2)
library(textstem)
library(vader)
library(yardstick)
library(stm)

# Create an unique id to each row of the data
## airbnb_reviews <-
    ## rownames_to_columns("id")

# Only keep necessary rows
## airbnb_sentiment <-
    ## airbnb_reviews %>%
    ## select(id, reviews)

# Using VADER to classify multiple review's sentiment in one go, note: VADER does not need any cleaning
## vader_sent <-
    ## vader_df(airbnb_sentiment$TEXTCOLUMN)

# The main column of interest is 'compound', which computes the sentiment of a text as a number ranging between -1 (most negative) and +1 (most positive)
## vader_sent2 <-
    ## vader_sent %>%
    # create a row number to merge it back into the original data
    ## rowid_to_column("id") %>%
    # remove any errors
    ## filter(word_scores != 'ERROR') %>%
    # classify as positive or negative
    ## mutate(vader_class = case_when(
        ## compound < -0.05 - "negative",
        ## compound > 0.05 - "positive",
        # the final case must always be written as TRUE - something
        ## TRUE - "neutral")) %>%
    ## select(id, vader_class)

# Merge the sentiment classification back into the airbnb_sentiment data
## airbnb_sentiment <-
    ## airbnb_sentiment %>%
    ## mutate(id = as.integer(id)) %>%
    ## inner_join(vader_sent2, by = "id")

# Plot the results
## vader_sent3 %>%
    ## ggplot(aes(x = vader_class)) +
    ## geom_bar()

# Topic models? 
# We can use this to learn the topics airbnb reviewers are discussing. 
# We can plot how the topics mentioned in a review differ across either 1) positive/negative reviews, or 2) fake and truthfull reviews 