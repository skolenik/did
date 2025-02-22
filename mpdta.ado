cap prog drop mpdta
prog def mpdta
	
	syntax [anything], [clear]
	
	quietly{
	
	if "`clear'" == "clear" {
		clear
	}
	
	if _N > 0 | c(k) > 0 {
		display as error "Tried to load new data with old data already in there, without the clear option."
		exit 4
	}
	clear
	set obs 2500
	
	rcall: data(mpdta, package = 'did'); write.csv(mpdta, 'temp_mpdta_transfer.csv')
	
	import delimited temp_mpdta_transfer.csv, clear
	erase temp_mpdta_transfer.csv
	
	drop v1
	
	label var year "The year of observation"
	label var countyreal "A  unique identifier for a particular county"
	label var lpop "The log of 1000s of population for the county"
	label var lemp "The log of teen employment in the county"
	label var firsttreat "The year that the state where the county is located raised its minimum wage, it is set equal to 0 for counties that have minimum wages equal to the federal minimum wage over the entire period."
	label var treat "Whether or not a particular county is treated in that year"
	
	}
end
