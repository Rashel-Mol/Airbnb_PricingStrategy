DATA = ../../data
TEMP = ../../gen/temp

## Main build rule

all: $(DATA)/reviews.csv $(DATA)/listings.csv $(TEMP)/boxplot_outliers.pdf $(TEMP)/airbnb.csv 

## Sub-builds
$(DATA)/reviews.csv: download_data.R
		R --vanilla < download_data.R

$(DATA)/listings.csv: download_data.R
		R --vanilla < download_data.R
		
$(TEMP)/boxplot_outliers.pdf: data_cleaning.R $(DATA)/reviews.csv $(DATA)/listings.csv
		mkdir -p ../../gen/temp
		R --vanilla < data_cleaning.R
		
$(TEMP)/airbnb.csv: data_cleaning.R $(DATA)/reviews.csv $(DATA)/listings.csv
		R --vanilla < data_cleaning.R
		

