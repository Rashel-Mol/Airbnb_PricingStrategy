DATA = ../../data
TEMP = ../../gen/temp
OUTPUT = ../../gen/output

all: $(TEMP)/sample_airbnb.csv $(OUTPUT)/plot_sentiment.pdf $(OUTPUT)/sentiment_topics.pdf $(OUTPUT)/modelsummary.csv

$(TEMP)/sample_airbnb.csv $(OUTPUT)/plot_sentiment.pdf $(TEMP)/tidy_reviews.csv $(OUTPUT)/sentiment_topics.pdf:$(TEMP)/airbnb.csv text_analysis.R
		mkdir -p ../../gen/output
		R --vanilla < text_analysis.R

$(OUTPUT)/modelsummary.csv: regression_analysis.R $(TEMP)/sample_airbnb.csv
		R --vanilla < regression_analysis.R
