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

# Run the regression 
regr <- lm(compound ~ price, data = sample_airbnb)


# Make a summary of the results, includes p-value
sum <- glance(regr)
# Save it to outputs
write_csv(sum, 'gen/output/modelsummary.csv')

# Summary in table 
msummary(regr)

# Plot price against compound to visually check the correlation 
plot_regr <- 
  ggplot(data = sample_airbnb, aes(x = price, y = compound)) +
  geom_point(alpha = 0.3)

# Add title 
plot_regr + labs(title = "Effect of price on sentiment (compound)")

# Save it to output
ggsave("gen/output/plot_regression.pdf")



# --- Collinearity --- # 

airbnb_cor <- rcorr(as.matrix(sample_airbnb[,8, 10])) #8 is price, compound?
round(airbnb_cor$P, 3) #to see whether correlations are significant
corrplot(cor(sample_airbnb[,8, 10]), method="number") #8 is price, compound?