clear all
use "C:\Users\Jorge Guerra\Desktop\CI\RDD\Data\hansen_dwi.dta"
*ssc install asdoc, replace
*ssc install estout, replace
*net install rddensity, from(https://sites.google.com/site/rdpackages/rddensity/stata) replace
*net install lpdensity, from(https://sites.google.com/site/nppackages/lpdensity/stata) replace

*3
gen dui=0
replace dui=1 if bac1>=0.08

*4
*Figure 1 - Density BAC
histogram bac1, width(0.0001) fcolor(gs12) lcolor(gs12) ytitle(Frequency) xtitle(BAC) xline(0.08, lcolor(black)) title(BAC Histogram)
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\BAC_Histogram.png", as(png) name("Graph") replac
*McCrary Density Test
rddensity bac1, all c(0.08) plot

*5
gen duibac1=bac1*dui
reg male bac1 dui duibac1

reg male bac1 if bac1>=0.08