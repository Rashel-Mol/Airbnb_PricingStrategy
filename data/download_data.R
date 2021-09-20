# Download the data

# --- Libraries --- #

library(googledrive)
library(readr)

# --- Download Data --- #

data_id <- "https://drive.google.com/file/d/1t6M7rsIsB8G7_DsM47HY-EMMyAo2ep-f/view?usp=sharing"
listings <- "data/listings.csv"
drive_download(
  as_id(data_id),
  overwrite = TRUE)

listings <- read_csv("listings.csv")

data_id <- "https://drive.google.com/file/d/12-HJRBW1INHGQiOxaMLH64Y0woTC70Bn/view?usp=sharing"
reviews <- "data/reviews.csv"
drive_download(
  as_id(data_id),
  overwrite = TRUE)

reviews <- read_csv("reviews.csv")
