#####################
#####################
### CLEANING DATA ###
#####################
#####################

# --- Create a useable dataset --- #

# Load the libraries 
library(tidyverse)
library(dplyr)
library(lubridate)
library(gtsummary)
library(readr)
library(ggplot2)

# Read in the files 

listings <- read_csv("../../data/listings.csv")
reviews <- read_csv("../../data/reviews.csv")

# Only keep necessary columns from listings 
listings_clean <- select(listings, c(id, name, neighbourhood_cleansed, price, room_type, accommodates))

# Only keep necessary columns from reviews 
reviews_clean <- select(reviews, c(listing_id, comments, date)) %>%
  filter(date > "2018-01-01")
  # filter out too historical reviews 

# Merge files into one dataset 
airbnb <- inner_join(listings_clean, reviews_clean, by = c("id" = "listing_id"))

# --- Price --- #

airbnb$price_numeric <- 
  # Rreate a new column with price as numeric 
  airbnb$price %>%
  str_remove(fixed("$")) %>% 
  str_remove(",") %>%
  # Remove the dollar sign and comma 
  as.numeric(airbnb$price_numeric)

# Remove the price as character column 
airbnb <- subset(airbnb, select = -price)

# Rename the column price_numeric to price
airbnb <- rename(airbnb, price = price_numeric)

# Make NA's of the 0 
airbnb$price[airbnb$price == 0] <- NA

# --- Date --- #

# Remove month and day 
airbnb$date <- lubridate:::year(as.Date(airbnb$date))

# Rename the column 
airbnb <- rename(airbnb, year = date)

# --- Comments --- #

# This column involves the text analysis, which is the next step of our project

# --- Accommodates --- #

# Make NA's of the 0 
airbnb$accommodates[airbnb$accommodates == 0] <- NA

# --- Room Type --- #

# Create vector for column room type 
airbnb$room_type <- as.factor(airbnb$room_type)

# --- Neighbourhood --- #

# create vector for column neighbourhood 
airbnb$neighbourhood_cleansed <- as.factor(airbnb$neighbourhood_cleansed)

# Rename the column 
airbnb <- rename(airbnb, neighbourhood = neighbourhood_cleansed)

# --- Check for outliers --- #
ggplot(airbnb) +
  aes(x = "listings", y = price) +
  geom_boxplot(fill = "#0c4c8a") +
  theme_minimal()
# the boxplot shows 1 extreme value of approximately 8000
# this value has been manually verified on the Airbnb website

ggsave("../../gen/output/boxplot_outliers.pdf")

# --- Check for duplicates and NA's --- # 

# Remove duplicates
airbnb <- airbnb %>% 
  filter(!duplicated(airbnb))

# Remove NA's 
airbnb <- 
  na.omit(airbnb)
  # At the beginning we checked for NA's, which did not exist in the dataset 
  # We made NA's of the 0 values in the columns price and accommodates
  # In this step we remove those jointly

# Save airbnb as .csv
write.csv(airbnb, "../../gen/temp/airbnb.csv", row.names = FALSE)

# --- Descriptive Summary Statistics --- #

summary(airbnb)
