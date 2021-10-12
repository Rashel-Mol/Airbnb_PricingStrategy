DATA = ../data
TEMP = ../gen/temp

## Main build rule

all: $(DATA)/reviews.csv $(DATA)/listings.csv $(TEMP)/airbnb.csv

## Sub-builds
$(DATA)/reviews.csv: download_data.R
		R --vanilla < download_data.R

$(DATA)/listings.csv: download_data.R
		R --vanilla < download_data.R
		
$(TEMP)/airbnb.csv: data_cleaning.R $(DATA)/reviews.csv $(DATA)/listings.csv
		mkdir -p ../gen/temp
		R --vanilla < data_cleaning.R
