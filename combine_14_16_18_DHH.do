*Combine panel dataset (2014-2016-2018)
*2014
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_data_clean.dta", clear
sort id
rename tinh_2014 province
gen year=2014

duplicates list id year
duplicates drop id year, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2014_data_combine.dta", replace

*2016
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2016\2016_data_clean.dta", clear
sort id
rename tinh_2016 province
gen year=2016

duplicates list id year
duplicates drop id year, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2016_data_combine.dta", replace

*2018
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2018\2018_data_clean.dta", clear
sort id
rename tinh_2018 province
gen year=2018

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2018_data_combine.dta", replace

* Append datasets (2014_2016_2018)
clear
append using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2014_data_combine.dta" "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2018_data_combine.dta" "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2016_data_combine.dta"
order id province year, first
sort id
tab id
rename khu_vuc hh_classified
label variable province "Province"
label variable year "Year"
drop ntlp52 ntlp53 ntlp54 ntlp55 ntlp56 n_nhap

*Check missing value
mdesc province
drop if province ==.
mdesc province
drop member_code
replace rel_hh_head = 1 if rel_hh_head==.
sum HH_size
replace HH_size = 4 if HH_size==.
sum hh_percept_confiscate
replace hh_percept_confiscate=5 if hh_percept_confiscate==.
sum type_plot
replace type_plot=3 if type_plot==.
sum redbook
replace redbook=1 if redbook==.
sum loan
replace loan=1 if loan ==.
sum house_size
replace house_size=87 if house_size==.
sum acquire_plot
replace acquire_plot=3 if acquire_plot==.
sum product_plot
replace product_plot=1 if product_plot==. & num_trees>1
replace product_plot=2 if product_plot==. & num_trees==0
tab investment_trees
replace investment_trees=1 if investment_trees==. & num_trees>1
replace investment_trees=2 if investment_trees==. & num_trees==0
sum livestock
replace livestock=23 if livestock==.
*Transfers unit
replace Totallivesold = Totallivesold/1000
sum Totallivesold
replace Totallivesold =201 if Totallivesold==.
mdesc hh_percept_confiscate num_trees labour_trees investment_trees total_income spent_trees agr_income type_plot redbook loan acquire_plot di_cu house_size hh_forest_product product_plot forest Totallivesold livestock
tab total_income if total_income <0
replace total_income=0 if total_income<0
tab agr_income if agr_income<0
replace agr_income=0 if agr_income<0
replace non_economic_income=0 if non_economic_income<0
replace off_farm_income=0 if off_farm_income<0
gen lntotal_income =ln(total_income + 0.25)


*Poverty status
*According to the Vietnamese government regulations, the poverty for 2011-2015 is VND 4.8 million per year.
*According to the Vietnamese government regulations, the poverty for 2016-2020 is VND 8.4 million per year.

*rural
gen inc_yearly = total_income/HH_size
gen dumpoor1=.
replace dumpoor1 =0 if inc_yearly <=4800 & hh_classified ==1 & year ==2014
replace dumpoor1 =1 if inc_yearly >4800 & inc_yearly <6240 & hh_classified ==1 & year ==2014
replace dumpoor1 =2 if inc_yearly >6240 & inc_yearly <17950.6 & hh_classified ==1 & year ==2014
replace dumpoor1 =3 if inc_yearly >=17950.6 & hh_classified ==1 & year ==2014
tab dumpoor1
replace dumpoor1 =0 if inc_yearly <=8400 & hh_classified ==1 & year ==2016
replace dumpoor1 =1 if inc_yearly >8400 & inc_yearly <12000 & hh_classified ==1 & year ==2016
replace dumpoor1 =2 if inc_yearly >12000 & inc_yearly <18000 & hh_classified ==1 & year ==2016
replace dumpoor1 =3 if inc_yearly >=18000 & hh_classified ==1 & year ==2016
tab dumpoor1
replace dumpoor1 =0 if inc_yearly <=8400 & hh_classified ==1 & year ==2018
replace dumpoor1 =1 if inc_yearly >8400 & inc_yearly <12000 & hh_classified ==1 & year ==2018
replace dumpoor1 =2 if inc_yearly >12000 & inc_yearly <18000 & hh_classified ==1 & year ==2018
replace dumpoor1 =3 if inc_yearly >=18000 & hh_classified ==1 & year ==2018
tab dumpoor1

*urban
gen dumpoor2=.
replace dumpoor2 =0 if inc_yearly <=6000 & hh_classified ==2 & year ==2014
replace dumpoor2 =1 if inc_yearly >6000 & inc_yearly <7800 & hh_classified ==2 & year ==2014
replace dumpoor2 =2 if inc_yearly >7800 & inc_yearly <17950.6 & hh_classified ==2 & year ==2014
replace dumpoor2 =3 if inc_yearly >=17950.6 & hh_classified ==2 & year ==2014
tab dumpoor2
replace dumpoor2 =0 if inc_yearly <=10800 & hh_classified ==2 & year ==2016
replace dumpoor2 =1 if inc_yearly >10800 & inc_yearly <15600 & hh_classified ==2 & year ==2016
replace dumpoor2 =2 if inc_yearly >15600 & inc_yearly <23400 & hh_classified ==2 & year ==2016
replace dumpoor2 =3 if inc_yearly >=23400 & hh_classified ==2 & year ==2016
tab dumpoor2
replace dumpoor2 =0 if inc_yearly <=10800 & hh_classified ==2 & year ==2018
replace dumpoor2 =1 if inc_yearly >10800 & inc_yearly <15600 & hh_classified ==2 & year ==2018
replace dumpoor2 =2 if inc_yearly >15600 & inc_yearly <23400 & hh_classified ==2 & year ==2018
replace dumpoor2 =3 if inc_yearly >=23400 & hh_classified ==2 & year ==2018
tab dumpoor2
sum dumpoor1 dumpoor2
tab hh_classified

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\VARHS_data_clean141618.dta", replace

**======================================================================
*Balanced / Unbalanced test
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\VARHS_data_clean141618.dta", clear

sort id
by id: gen count=_N
tab count
drop if count<3 // 1 household_id corresponding 1 year(2014/2016/2018)

xtset id
xtset year
xtset id year
xtset year id
tsset id year
tsset year id

xtsum spent_trees
xtsum num_trees

* Replace variables
replace forest_income=0 if type_plot !=3
replace y_annual_crop = 0 if type_plot !=1
replace y_perennial_crop = 0 if type_plot !=2
replace y_forest = 0 if type_plot !=3
replace y_fish_shrimp = 0 if type_plot !=4
replace Totallivesold=0 if Totallivesold==.

*Example with Regression
reg spent_trees agr_income hh_percept_confiscate
vif
hettest
imtest, white
sktest spent_trees agr_income hh_percept_confiscate type_plot
reg spent_trees agr_income hh_percept_confiscate coffee_plot tea_plot timber_plot conservation_plot
testparm coffee_plot tea_plot timber_plot conservation_plot

xtreg spent_trees agr_income hh_percept_confiscate type_plot coffee_plot, re
estimates store random
xtreg spent_trees agr_income hh_percept_confiscate type_plot coffee_plot, re robust
xttest0
xtreg lntotal_income head_age head_gender ethnicity num_trees distance_road distance_plot livestock Totallivesold spent_trees agr_income hh_percept_confiscate type_plot, re

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\VARHS_data_balanced141618.dta", replace
