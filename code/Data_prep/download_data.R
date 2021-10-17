#####################
#####################
### DOWNLOAD DATA ###
#####################
#####################

# --- Libraries --- #

library(googledrive)
library(readr)

# --- Download Data --- #

files = list(c('listings.csv', "https://drive.google.com/file/d/1t6M7rsIsB8G7_DsM47HY-EMMyAo2ep-f/view?usp=sharing"),
             c('reviews.csv', "https://drive.google.com/file/d/12-HJRBW1INHGQiOxaMLH64Y0woTC70Bn/view?usp=sharing"))

for (f in files) {
  cat(paste0('Downloading file: ', f, '...\n'))
  
  drive_deauth()
  drive_download(
    file = f[2],
    path = paste0('../../data/', f[1]),
    overwrite = TRUE)

}

