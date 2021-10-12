DATA = ../../data
TEMP = ../../gen/temp
OUTPUT = ../../gen/output

all: $(TEMP)/plot_vader_sent.pdf $(TEMP)/sentiment_topics.pdf

$(TEMP)/plot_vader_sent.pdf: $(TEMP)/airbnb.csv text_analysis.R
		R --vanilla < text_analysis.R
		
$(TEMP)/sentiment_topics.pdf: $(TEMP)/airbnb.csv text_analysis.R
		R --vanilla < text_analysis.R
		
