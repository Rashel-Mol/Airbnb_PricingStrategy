DATA = ../../data
TEMP = ../../gen/temp
OUTPUT = ../../gen/output

all: $(TEMP)/sample_airbnb.csv $(OUTPUT)/plot_vader_sent.pdf $(OUTPUT)/sentiment_topics.pdf $(OUTPUT)/modelsummary.csv

$(TEMP)/sample_airbnb.csv:$(TEMP)/airbnb.csv text_analysis.R
		R --vanilla < text_analysis.R

$(OUTPUT)/plot_vader_sent.pdf: $(TEMP)/airbnb.csv text_analysis.R
		mkdir -p ../../gen/output
		R --vanilla < text_analysis.R
		
$(TEMP)/tidy_reviews.csv: $(TEMP)/airbnb.csv text_analysis.R
		R --vanilla < text_analysis.R

$(OUTPUT)/sentiment_topics.pdf: $(TEMP)/airbnb.csv text_analysis.R
		R --vanilla < text_analysis.R

$(OUTPUT)/modelsummary.csv: regression_analysis.R $(TEMP)/sample_airbnb.csv
		R --vanilla < regression_analysis.R
