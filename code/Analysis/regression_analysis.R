###########################
###########################
### REGRESSION ANALYSIS ###
###########################
###########################

# --- Libraries --- #

library(readr)
library(broom)
library(modelsummary)
library(Hmisc)
library(corrplot)

# --- Read in data --- #

sample_airbnb <- read_csv("../../gen/temp/sample_airbnb.csv")

# --- Linear Regression --- # 

# We want to investigate the effect price has on the sentiment of reviews.
# E.g., does a higher price lead to more negative reviews? 
# Since price is a numeric variable and vader_class (sentiment) a character, we use the logistic reggresion. 

regr <- lm(compound ~ price, data = sample_airbnb)

sum <- glance(regr)

write_csv(sum, '../../gen/output/modelsummary.csv')

msummary(regr)