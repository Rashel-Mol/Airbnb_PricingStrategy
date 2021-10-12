###########################
###########################
### REGRESSION ANALYSIS ###
###########################
###########################

# --- Libraries --- #

library(broom)
library(modelsummary)
library(Hmisc)
library(corrplot)

# --- Linear Regression --- # 

# We want to investigate the effect price has on the sentiment of reviews.
# E.g., does a higher price lead to more negative reviews? 
# Since price is a numeric variable and vader_class (sentiment) a character, we use the logistic reggresion. 

regr <- lm(compound ~ price, data = sample_airbnb)

sum <- glance(regr)
write_csv(sum, 'gen/output/modelsummary.csv')

msummary(regr)

# --- Collinearity --- # 

airbnb_cor <- rcorr(as.matrix(sample_airbnb[,8, 10])) #8 is price, compound?
round(airbnb_cor$P, 3) #to see whether correlations are significant
corrplot(cor(sample_airbnb[,8, 10]), method="number") #8 is price, compound?