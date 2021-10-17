DATA = ../../data
TEMP = ../../gen/temp
OUTPUT = ../../gen/output

## Main build rule

all: $(DATA)/reviews.csv $(DATA)/listings.csv $(OUTPUT)/boxplot_outliers.pdf $(TEMP)/airbnb.csv

## Sub-builds
$(DATA)/reviews.csv $(DATA)/listings.csv: download_data.R
		mkdir -p ../../data
		R --vanilla < download_data.R
		
$(OUTPUT)/boxplot_outliers.pdf $(TEMP)/airbnb.csv: data_cleaning.R $(DATA)/reviews.csv $(DATA)/listings.csv
		mkdir -p ../../gen/output
		mkdir -p ../../gen/temp
		R --vanilla < data_cleaning.R
		