*Combine panel dataset (2008-2010-2012)
*2008
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_data_clean.dta", clear
sort id
gen year=2008
duplicates list id year
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2008_data_combine.dta", replace

*2010
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2010\2010_data_clean.dta", clear
sort id
gen year=2010
rename tinh_2010 province
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2010_data_combine.dta", replace

*2012
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2012\2012_data_clean.dta", clear
sort id
rename tinh_2012 province
gen year=2012
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2012_data_combine.dta", replace

*2014
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_data_clean.dta", clear
sort id
rename tinh_2014 province
gen year=2014
duplicates drop id, force
save  "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2014_data_combine.dta", replace

*2016
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2016\2016_data_clean.dta", clear
sort id
rename tinh_2016 province
gen year=2016
duplicates drop id, force
save  "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2016_data_combine.dta", replace

*2018
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2018\2018_data_clean.dta", clear
sort id
rename tinh_2018 province
gen year=2018
duplicates drop id, force
save  "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2018_data_combine.dta", replace
* Append datasets (2008_2010_2012_2014_2016_2018)
clear
append using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2008_data_combine.dta" "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2010_data_combine.dta" "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2012_data_combine.dta" "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2014_data_combine.dta" "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2016_data_combine.dta" "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\2018_data_combine.dta"

drop _merge_goc chi_ttrot com_05 com_99 d_t_vien dat_d ea_psu ea_psu_99 duration_agr_land g_s_vien gio_11 gio_12 gio_21 gio_22 loai_h0 ma_h0_2006_new ma_h0_2010 ma_h0_2012 ma_h0_2014 ma_h0_2016 ma_h0_2018 ma_ho_2002 ma_ho_2004 ma_ho_2006 ma_ho_2008 ma_ho_2009 manh_1 manh_2 manh_3 manh_4 manh_5 

drop misshh08 n_nhap ngay_1 ngay_2 ntlp10 ntlp11 ntlp12 ntlp13 ntlp14 ntlp15 ntlp16 ntlp17 ntlp18 ntlp19 ntlp20 ntlp21 ntlp22 ntlp23 ntlp24 ntlp25 ntlp26 ntlp27 ntlp28 ntlp29 ntlp30 ntlp32 ntlp33 ntlp34 ntlp35 ntlp36 ntlp37 ntlp38 ntlp38b ntlp39 ntlp4 ntlp40 ntlp41 ntlp42 ntlp43 ntlp44 ntlp45 ntlp46 ntlp47 

drop ntlp48 ntlp49 ntlp5 ntlp50 ntlp51 ntlp52 ntlp53 ntlp54 ntlp55 ntlp56 ntlp57 ntlp59 ntlp8 ntlp9 quan_2002 quan_2004 quan_2006 quan_2006_new quan_2008 quan_2009 quan_2010 quan_2012 quan_2014 quan_2016 quan_2018 quan rac rac_ma_ho_2006 rac_ma_thon_2006 rac_quan_2006 rac_tinh_2006 rac_xa_2006 rur_prov_05 

drop rur_prov_99 samp02 samp0204 samp04 samp0406 samp06 samp0608 samp08 samp0810 samp10 samp_report samp_report08 samp_report10 samp_report10_2 sttp3 sttp4_1 sttp4_2 t_thue tel ten_chu_ho thang_1 thang_2 thay_doi_chu_ho thon tien_sx1 tien_sx2 tien_sx3 tien_sx4 tien_sx5 tien_ttrot tinh tinh_2002 tinh_2004 

drop tinh_2006 tinh_2008 tinh_2009 village_05 village_99 weight weight99 xa xa_2002 xa_2004 xa_2006 xa_2006_new xa_2008 xa_2009 xa_2010 xa_2012 xa_2014 xa_2016 xa_2018 
label variable aquaculture_not_hh "In the last 12 months, did household catch aquatic products from the sea, rivers"
label variable climate_affect_agr "Compared to last 3 years have you noticed changes to quality of plot?"
label variable climate_affect_agr "How much has this information on climate change affected decisions on agricultur"
label variable climate_change "Did HH obtain assistance or information on cliamte change impacts"
label variable community_bulletin "For information, how trustworthy are - COMMUNITY BOARD"
label variable di_cu "is migration relevant to the HH"
label variable difficulties_input "Distance in KM to nearest buyer of first most important crop"
label variable distance_output "Distance in KM to nearest buyer of first most important crop"
label variable extension_agents "For information, how trustworthy are - EXTENSION AGENTS"
label variable have_savings "Household has savings in any of the forms listed"
label variable internet "For information, how trustworthy are - INTERNET"
label variable other_groups "For information, how trustworthy are - OTHER GROUPS/MASS ORGANISATION"
label variable local_market "For information, how trustworthy are - LOCAL MARKET"
label variable relatives "For information, how trustworthy are - RELATIVES"
label variable unit_third "HH has plots which were hit by natural disaster(s) since 1 July 2006"
label variable weather_agr_1y "Has the weather in general been favourable for agriculture - during last 12 mont"
label variable weather_agr_3y "During the last three years the weather has been in general?"
label variable work_associates "For information, how trustworthy are - BUSINESS/WORK ASSOCIATES"
order id province year, first
sort id
tab id
rename khu_vuc hh_classified
label variable province "Province"
label variable year "Year"
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
*According to the Vietnamese government regulations, the poverty for 2010-2020 is VND 8.4 million per year.

*rural
gen inc_yearly = total_income/HH_size
gen dumpoor1=.
replace dumpoor1 =0 if inc_yearly <=4800 & hh_classified ==1 & year ==2008
replace dumpoor1 =1 if inc_yearly >4800 & inc_yearly <6240 & hh_classified ==1 & year ==2008
replace dumpoor1 =2 if inc_yearly >6240 & inc_yearly <17950.6 & hh_classified ==1 & year ==2008
replace dumpoor1 =3 if inc_yearly >=17950.6 & hh_classified ==1 & year ==2008
tab dumpoor1
replace dumpoor1 =0 if inc_yearly <=8400 & hh_classified ==1 & year ==2010
replace dumpoor1 =1 if inc_yearly >8400 & inc_yearly <12000 & hh_classified ==1 & year ==2010
replace dumpoor1 =2 if inc_yearly >12000 & inc_yearly <18000 & hh_classified ==1 & year ==2010
replace dumpoor1 =3 if inc_yearly >=18000 & hh_classified ==1 & year ==2010
tab dumpoor1
replace dumpoor1 =0 if inc_yearly <=8400 & hh_classified ==1 & year ==2012
replace dumpoor1 =1 if inc_yearly >8400 & inc_yearly <12000 & hh_classified ==1 & year ==2012
replace dumpoor1 =2 if inc_yearly >12000 & inc_yearly <18000 & hh_classified ==1 & year ==2012
replace dumpoor1 =3 if inc_yearly >=18000 & hh_classified ==1 & year ==2012
tab dumpoor1
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
replace dumpoor2 =0 if inc_yearly <=6000 & hh_classified ==2 & year ==2008
replace dumpoor2 =1 if inc_yearly >6000 & inc_yearly <7800 & hh_classified ==2 & year ==2008
replace dumpoor2 =2 if inc_yearly >7800 & inc_yearly <17950.6 & hh_classified ==2 & year ==2008
replace dumpoor2 =3 if inc_yearly >=17950.6 & hh_classified ==2 & year ==2008
tab dumpoor2
replace dumpoor2 =0 if inc_yearly <=10800 & hh_classified ==2 & year ==2010
replace dumpoor2 =1 if inc_yearly >10800 & inc_yearly <15600 & hh_classified ==2 & year ==2010
replace dumpoor2 =2 if inc_yearly >15600 & inc_yearly <23400 & hh_classified ==2 & year ==2010
replace dumpoor2 =3 if inc_yearly >=23400 & hh_classified ==2 & year ==2010
tab dumpoor2
replace dumpoor2 =0 if inc_yearly <=10800 & hh_classified ==2 & year ==2012
replace dumpoor2 =1 if inc_yearly >10800 & inc_yearly <15600 & hh_classified ==2 & year ==2012
replace dumpoor2 =2 if inc_yearly >15600 & inc_yearly <23400 & hh_classified ==2 & year ==2012
replace dumpoor2 =3 if inc_yearly >=23400 & hh_classified ==2 & year ==2012
tab dumpoor2

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

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\VARHS_data_clean081012.dta", replace

**======================================================================
*Balanced / Unbalanced test
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\VARHS_data_clean081012.dta", clear

sort id 
by id: gen count=_N
tab count
drop if count<3 
// 1 household_id corresponding 1 year(2008/2010/2012)

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

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\append\VARHS_data_unbalanced081012141618.dta", replace
