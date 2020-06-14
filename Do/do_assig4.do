clear all
use "C:\Users\Jorge Guerra\Desktop\CI\RDD\Data\hansen_dwi.dta"
*ssc install asdoc, replace
*ssc install estout, replace
*net install rddensity, from(https://sites.google.com/site/rdpackages/rddensity/stata) replace
*net install lpdensity, from(https://sites.google.com/site/nppackages/lpdensity/stata) replace

*3
gen dui=0
replace dui=1 if bac1>=0.08
gen duibac1=bac1*dui
gen bac1q=bac1*bac1
gen duibac1q=bac1q*dui


*4
*Figure 1 - Density BAC
histogram bac1, width(0.0001) fcolor(gs12) lcolor(gs12) ytitle(Frequency) xtitle(BAC) xline(0.08, lcolor(black)) title(BAC Histogram) 
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\BAC_Histogram.png", as(png) name("Graph") replace
*McCrary Density Test
rddensity bac1, all c(0.08) plot

*5
cd "C:\Users\Jorge Guerra\Desktop\CI\RDD\Tables"


reg male dui bac1 duibac1
outreg2 using table1.doc, title("Regression Discontinuity Estimates for the Effect of Exceeding BAC Thresholds on Predetermined Characteristics")replace addtext(Mean, 0.789, Controls, NO) nor2

reg white dui bac1 duibac1
outreg2 using table1.doc, append addtext(Mean, 0.861, Controls, NO) nor2

reg aged dui bac1 duibac1
outreg2 using table1.doc, append addtext(Mean, 34.957, Controls, NO) nor2

reg acc dui bac1 duibac1
outreg2 using table1.doc, append addtext(Mean, 0.354, Controls, NO) nor2

*6
*cmogram recidivism bac1 , cut(0.08) scatter line(0.08) qfitci
*cmogram recidivism bac1 , cut(0.08) scatter line(0.08) lfit

cmogram white bac1, cut(0.08) scatter line(0.08) qfitci title("White")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_white_q.png", as(png) name("_graph0") replace
cmogram white bac1, cut(0.08) scatter line(0.08) lfitci  title("White")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_white_l.png", as(png) name("_graph0") replace

cmogram acc bac1, cut(0.08) scatter line(0.08) qfitci title("Acc")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_acc_q.png", as(png) name("_graph0") replace
cmogram acc bac1, cut(0.08) scatter line(0.08) lfitci title("Acc")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_acc_l.png", as(png) name("_graph0") replace

cmogram male bac1, cut(0.08) scatter line(0.08) qfitci title("Male")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_male_q.png", as(png) name("_graph0") replace
cmogram male bac1, cut(0.08) scatter line(0.08) lfitci title("Male")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_male_l.png", as(png) name("_graph0") replace

cmogram aged bac1, cut(0.08) scatter line(0.08) qfitci title("Age")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_aged_q.png", as(png) name("_graph0") replace
cmogram aged bac1, cut(0.08) scatter line(0.08) lfitci title("Age")
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_aged_l.png", as(png) name("_graph0") replace

*7


cd "C:\Users\Jorge Guerra\Desktop\CI\RDD\Tables"
reg recidivism dui bac1  male white acc aged if bac1>0.03 & bac1<0.13, robust
outreg2 using table3a.doc, replace title("Regression Discontinuity Estimates for the Effect of Exceeding the 0.08 BAC Threshold on Recidivism") ctitle(PANEL A (1)) addtext(Mean, 0.0984, Controls, YES) keep(bac1 dui) nor2

reg recidivism dui bac1  duibac1 male white acc aged if bac1>0.03 & bac1<0.13, robust
outreg2 using table3a.doc, append ctitle(PANEL A (2)) addtext(Mean, 0.0984, Controls, YES) keep(bac1 dui duibac1) nor2

reg recidivism dui bac1 duibac1 duibac1q male white acc aged if bac1>0.03 & bac1<0.13, robust
outreg2 using table3a.doc, append ctitle(PANEL A (3)) addtext(Mean, 0.0984, Controls, YES) keep(bac1 bac1q dui duibac1 duibac1q) nor2


reg recidivism dui bac1  male white acc aged if bac1>0.055 & bac1<0.105, robust
outreg2 using table3b.doc, replace ctitle(PANEL B (1)) addtext(Mean, 0.0863, Controls, YES) keep(bac1 dui) nor2

reg recidivism dui bac1 duibac1 male white acc aged if bac1>0.055 & bac1<0.105, robust
outreg2 using table3b.doc, append ctitle(PANEL B (2)) addtext(Mean, 0.0863, Controls, YES) keep(bac1 dui duibac1) nor2

reg recidivism dui bac1 duibac1 duibac1q male white acc aged if bac1>0.055 & bac1<0.105, robust
outreg2 using table3b.doc, append ctitle(PANEL B (3)) addtext(Mean, 0.0863, Controls, YES) keep(bac1 bac1q dui duibac1 duibac1q) nor2

*8
cd "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures"
cmogram recidivism bac1 if bac1<=0.15, cut(0.08) scatter line(0.08) qfitci
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_recidivism_q.png", as(png) name("_graph0") replace
cmogram recidivism bac1 if bac1<=0.15, cut(0.08) scatter line(0.08) lfitci
graph export "C:\Users\Jorge Guerra\Desktop\CI\RDD\Figures\cmogram_recidivism_l.png", as(png) name("_graph0") replace








