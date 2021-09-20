# Download the data

# --- Libraries --- #

library(readr)
library(tidygraph)
library(dplyr)
library(tidyr)
library(googledrive)


# --- Download Data --- #

data_id <- "URL"
originaldata_nl <- "data/listings.csv"
drive_download(
  as_id(data_id),
  path = listings,
  overwrite = TRUE)

data_id <- "URL"
originaldata_nl <- "data/reviews.csv"
drive_download(
  as_id(data_id),
  path = reviews,
  overwrite = TRUE)