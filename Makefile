clear_no_coords:
	awk -F, '$$9 != "" && $$40 != "NONKINETIC" {print}' thor_data_vietnam_datefix.csv > thor_filtered.csv

test:
	Rscript process.r thor_test_example.csv thor_test_results_actual.csv;

build:
	Rscript process.r thor_filtered.csv thor_grouped.csv;

