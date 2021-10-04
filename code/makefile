DATA = ../data
TEMP = ../gen/temp

## Main build rule

all: $(DATA)/reviews.csv $(DATA)/listings.csv $(TEMP)/airbnb.csv

## Sub-builds
$(DATA)/listings.csv: download_data.R
		R --vanilla < download_data.R
		
$(DATA)/reviews.csv: download_data.R
		R --vanilla < download_data.R
		
$(TEMP)/airbnb.csv: data_cleaning.R reviews.csv listings.csv
		mkdir -p ../gen/temp
		R --vanilla < data_cleaning.R
