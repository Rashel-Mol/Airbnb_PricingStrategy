all: analysis data-preparation 

data-preparation: 
		make -C code/Data_prep
		
analysis: data-preparation
		make -C code/Analysis
		
clean: 
		-rm -r data
		-rm -r gen