***2008
**==========================================================================
* Phieu_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Phieu_1_Agg.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

*Calculate p14q12, p14q13 & p14q14 for each HH
*thay đổi
collapse (sum) p14q12 p14q13 p14q14, by (id tinh_2008 quan_2008 xa_2008 ma_h0_2008)
duplicates list id 

label variable p14q12 "Number of tree&bushes planted since July 2010"
label variable p14q13 "What was the total cash spending by your household on investment in trees and bushes since 1 July 2010?"
label variable p14q14 "How many days of labour did your household spend on investment in trees and bushes since 1 July 2010?"

* Household investment on plots since 1 July 2010
rename p14q12 num_trees
rename p14q13 spent_trees
rename p14q14 labour_trees
*thay đổi
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p0.dta", replace

*** Respondents
**======================================================================
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Phieu_1_Agg.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 ntlp2 
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_res.dta", replace

**======================================================================
* Q1_New_08.dta
**Section 1A
***HH_size (Number of family members)
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q1a_New.dta", clear

* Create HH_ID
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Create age variables
gen age=2008- p2q4_
gen under6=0
replace under6=1 if age<6
gen under16=0
replace under16=1 if age<16
gen over60=0
replace over60=1 if age>60

* Count number of members, members<6,14 (MUST use egen NOT gen)
bysort id: gen HH_size=_N
bysort id: egen num_under6=sum( under6 )
bysort id: egen num_over60=sum( over60 )
bysort id: egen num_under14=sum( under16 )

* Rename variables
rename p2stt_ member_code
rename p2q2_ rel_hh_head
rename p2q3_ gender
rename p2q4_ year_born
rename p3q8_ material_status
rename p3q13_ attending_school
rename p3q14_ edu
rename p3q16_ highest_diploma
keep if rel_hh_head== 1

mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
*Merge with Respondents
*thay đổi
merge 1:1 id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_res.dta", nogen
*Keep data for only respondent

duplicates list id 
*Confirm no HHs has >1 respondent


* Save data: only for head
keep if rel_hh_head==1
duplicates list id

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 ntlp2 member_code rel_hh_head gender year_born age material_status HH_size num_under6 num_over60 num_under14 attending_school edu highest_diploma
order id, first
foreach stud in age gender year_born edu material_status {
	rename `stud' head_`stud'
	}
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p1.dta", replace

**==========================================================================
* Phieu_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Phieu_1_Agg.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

*Housing
rename ma_dan_toc ethnicity
rename p4q1_1 head_hh
rename p4q2_1 time_lived
rename p4q3_1 house_size
rename p4q7_1 house_owned
rename p4q8_1 house_rent
rename p4q9_1 hh_poor
rename p4q10_1 hh_electricity
rename p4q13_1 distance_wood
rename p4q14_1 time_wood
rename p4q17_1 source_water_hh
rename p4q20b distance_road

*Land use
rename p5q2_1 hh_p_use
rename p5q2_2 hh_p_rent
rename p5q2_3 hh_plots_rentout


* When the government confiscates a plot of land, and there is no other land available for compensation, what compensation is the land user entitled to?
rename p16q4 hh_percept_confiscate


* Livestock, aquaculture, agricultural services, access to markets
rename p21q1 hh_aquaculture

* Access to markets for Agricultural Inputs and Outputs
rename p26q2 where_riceseed
rename p26q3 distance_riceseed
rename p26q4 difficulties_input

* Occuption, time use, and other sources of income
rename p30 hh_non_economic

* Transfers and Remittances
**How much did your household receive from this source in the last 12 months? (1000 VND)

 

* Total income of household in last 12 months
**During the last 12 months, approximately how much was your household's net income from the following sources - including cash and in-kind payments?(1000 VND)
rename p34q1 wage_salary
rename p34q2 agr_income
rename p34q3 common_res_income
rename p34q4 non_economic_income
gen rental_income = p34q5a + p34q5b
rename p34q5a land_real_estate
rename p34q5b other_assets
rename p34q6 sales_assets
rename p34q7 hh_private_trans
rename p34q8 hh_public_trans
rename p34q9 other_income
rename p34q10 total_income

** Share off-farm income (%)
gen off_farm_income = non_economic_income/total_income

* Access to Extension services
rename p38q1 hh_agr_extension
rename p38q2a frequency_extension
**Did your household obtain assistance or information on the following topics in the last 12 months?


* Credit (Formal and Informal)
rename p44q22 rejected_loan

* Risk response


* Formal Insurance
rename p45q6 wtp_insurance_crop

* Risk respone
rename p46q1 suffer_unexpected


drop p*****
drop thay_cho_o tieng_viet tieng_chinh
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p2.dta", replace


**==========================================================================
* Phieu_2_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Phieu_2_New_OneFile.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Political connections
rename p52q1 hh_trust_positions
rename p52q4 hh_out_trust_positions
rename p52q7 friends_trust_positions

* Sources of information
rename p53q5 hh_internet

* Social Activity
rename p54q8 spend_tet

* Social Capital - Networks
rename p50q13 num_support


drop p*****
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p3.dta", replace


**==========================================================================
* Q2_New_08.dta: 
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\q2_New_updated.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

*1. Information about Plots
rename p6ma_ plot_code
rename p6q1_ distance_plot
rename p6q3_ area_plot
rename p6q4_ acquire_plot
rename p6q5_ time_acquire_plot
rename p6q6_ value_plot
rename p6q7_ type_plot
rename p7q9_ slope_plot
rename p7q10_ problem_plot
rename p7q11_ quality_plot
rename p7q12_ irrigated_plot
rename p8q18_ infrast_soil
rename p8q19_ convert_plot
rename p8q20_ restrictions_crop
rename p8q21_ restrictions_cropA
rename p8q22a_ product_plot
rename p8q22b_ coffee_plot
rename p8q22c_ tea_plot
rename p8q22d_ timber_plot
rename p8q22e_ conservation_plot
rename p8q22f_ other_plot

* Ownership status of forestland (=1 if HH has LURC)
tab type_plot
gen owner_forest= 3.type_plot
tab owner_forest
 
* Number of year using forestland (years)
gen use_land = 2008 - time_acquire_plot
gen use_forestland = use_land if type_plot==3
 
keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 plot_code distance_plot area_plot acquire_plot time_acquire_plot value_plot type_plot slope_plot problem_plot quality_plot irrigated_plot infrast_soil convert_plot restrictions_crop restrictions_cropA product_plot product_plot coffee_plot tea_plot timber_plot conservation_plot other_plot owner_forest use_land use_forestland
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp1.dta", replace


**==========================================================================
* Q2A_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q2a_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Plots owned and operated
rename p9ma_ plot_code
rename p9q2_ redbook
rename p9q4_ year_redbook
rename p9q8_ mortgage
rename p9q9_ use_mortgage
rename p9q11_ time_fallow

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 plot_code redbook year_redbook mortgage use_mortgage time_fallow
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
order id, first
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp2.dta", replace


**==========================================================================
* Q2B_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q2b_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Plots rented in or borrowed
rename p10ma_ plot_code
rename p10q1_ time_rent_plot
rename p10q2_ responsible_plot
rename p10q3_ owner_plot
rename p10q4_ paid_plot
rename p10q5_ agreement_plot
rename p10q6_ duration_rent
rename p10q8_ time_fallow_plot

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 plot_code time_rent_plot responsible_plot owner_plot paid_plot agreement_plot duration_rent duration_rent time_fallow_plot
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp3.dta", replace

**==========================================================================
* Q2C_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q2c_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Plots rented out or lent out
rename p11ma_ plot_code
rename p11q1_ who_rentout
rename p11q2_ redbook_rentout
rename p11q4_ year_redbook_rentout
rename p11q8_ mortgage_rentout
rename p11q9_ use_mortgage_rentout
rename p11q11_ cash_rentout
rename p11q12_ time_rentout
rename p11q13_ duration_rentout

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 plot_code who_rentout redbook_rentout mortgage_rentout use_mortgage_rentout cash_rentout time_rentout duration_rentout
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp4.dta", replace

**==========================================================================
* Q2D_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q2d_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008

* Land sold, taken, given away or permanently exchanged since 1 July 2008
rename p12ma_ plot_code
rename p12q1_ time_plot_sold
rename p12q2_ redbook_sold
rename p12q4_ area_plot_sold
rename p12q5_ distance_plot_sold
rename p12q6_ part_plot
rename p12q7_ area_received_sold
rename p12q8_ who_purchased
rename p12q9_ reason_plot_sold
rename p12q10_ cash_plot_sold

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 plot_code time_plot_sold redbook_sold area_plot_sold distance_plot_sold part_plot area_received_sold who_purchased reason_plot_sold reason_plot_sold cash_plot_sold
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp5.dta", replace

**==========================================================================
* Q2E_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q2e_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id


* Household investment on plots since 1 July 2008
rename p13ma_ plot_code
rename p14q11_ investment_trees

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 plot_code investment_trees
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp6.dta", replace


**==========================================================================
*MERGING WITH PLOT_CODE
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp1.dta", clear

*Merging data sheets
	forval num = 2/6{
	merge 1:1 id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_pp`num'", nogen
	}

*Creating a unique ID 
sort id
egen plot_id = group(plot_code)

duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p04.dta", replace

**==========================================================================
* Colllapse Plots by IDs
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p04.dta", clear
*change
collapse (sum) plot_id, by (id tinh_2008 quan_2008 xa_2008 ma_h0_2008)
tab plot_id

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p041.dta", replace

**==========================================================================
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p041.dta", clear

*Merging data sheets
merge 1:1 id plot_id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p04.dta", nogen

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p4.dta", replace


***=======================================
* Q2_New_08.dta:Landing
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\q2_New_updated.dta", clear
*1.Create HH_ID
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008

*2. Gen new variables (m2) for each land type
forval n = 1(1)8 {
 gen land`n' = p6q3_ if p6q7_ == `n'
}

*3. Calculate land area for each land type
collapse (sum) land*, by (id tinh_2008 quan_2008 xa_2008 ma_h0_2008)
* sum total land area (m2)
egen tot_land=rowtotal(land*)
gen agri_land=land1+land2+land3+land4
gen crop_land=land1+land2
* rename variables
rename land1 annual_crop
rename land2 perennial_crop
rename land3 forest
rename land4 fish_shrimp
rename land5 grass_land
rename land6 house_garden
rename land7 residental_land

drop land*
keep id tot_land agri_land crop_land annual_crop perennial_crop forest fish_shrimp grass_land house_garden residental_land
order id, first
*4.save data
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p5.dta", replace


***=======================================
* Q2_New_08.dta:Year_obtained_type_landing
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\q2_New_updated.dta", clear
*1.Create HH_ID
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008

*2. Gen new variables (year) for each land type
forval n = 1(1)8 {
 gen land`n' = p6q5_ if p6q7_ == `n'
}

* rename variables
rename land1 y_annual_crop
rename land2 y_perennial_crop
rename land3 y_forest
rename land4 y_fish_shrimp

drop land*
keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 y_annual_crop y_perennial_crop y_forest y_fish_shrimp
order id, first
*4.save data
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p6.dta", replace


**==========================================================================
* Agriculture
* Q3A_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q3a_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Agriculture production for last 12 months by plot
rename p17ma1_ plot_code

** Most recent completed season
rename p17q1_ purpose_comp
rename p17q2_ area_comp
rename p17q3_ quantity_comp
rename p17q4_ unit_comp
rename p17q5_ reason_crop


** Second most recent season
rename p17q6_ purpose_second
rename p17q7_ area_second
rename p17q8_ quantity_second
rename p17q9_ unit_second


** Third most recent season
rename p17q10_ purpose_third
rename p17q11_ area_third
rename p17q12_ quantity_third
rename p17q13_ unit_third

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 plot_code purpose_comp area_comp quantity_comp unit_comp reason_crop purpose_second area_second quantity_second unit_second purpose_third area_third quantity_third unit_third
order id, first
duplicates list id
duplicates drop id, force
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p07.dta", replace

**==========================================================================
*MERGING WITH PLOT_CODE
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p4.dta", clear

*Merging data sheets
merge 1:1 id plot_code using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p07", nogen

duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p7.dta", replace
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
**==========================================================================
* Agriculture
* Q3B_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q3b_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Crop production of the household in the last 12 months
rename p18ma_ crop
rename p18q1_ output_quantity
rename p18q2_ value_output
rename p18q3_ loss_harvest
rename p18q4_ sold_quantity
rename p18q6_ cash_sold
rename p18q10_ contract_crop
rename p18q11_ area_crop

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 crop output_quantity value_output loss_harvest sold_quantity cash_sold contract_crop area_crop
order id, first
duplicates list id
duplicates drop id, force
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p8.dta", replace

**==========================================================================
* Agriculture
* Q3C_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q3c_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id


* Cost of cultivation of crops 
**(including rice, fruits and vegetables, but NOT forestry and fishery)
rename p19ma_ input_crop
rename p19q1_ cash_input

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 input_crop cash_input
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p9.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4A_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q4a_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

rename p21q4_ Totalnumlive
rename p21q5_ Totallivesold
collapse (sum) Totalnumlive Totallivesold, by (id)
keep id Totalnumlive Totallivesold
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p10.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4B_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q4b_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Produce
rename p23ma_ live_aqua_product
rename p23q2_ value_live_aqua
rename p23q4_ sold_live_aqua
rename p23q5_ barter_live_aqua
rename p23q6_ bartered_live_aqua

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 live_aqua_product value_live_aqua sold_live_aqua barter_live_aqua bartered_live_aqua
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p11.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4B1_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q4b_1_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Produce_Input
gen input_livestock = p24q6_

gen input_aquaculture = p24q7_

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 input_livestock input_aquaculture
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p12.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4c&d_New.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q4c&d_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Aquaculture products from common property resources
rename p25ma_ forest_product
rename p25q3_ value_aquaculture
rename p25q7_ bartered_aquaculture

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 value_aquaculture bartered_aquaculture
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p13.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q5_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id


* Employment status
rename p27q1a_ work_out
rename p27q1b_ agr_forest_aqua
rename p27q1c_ self_employed
rename p27q1d_ income_prop_resources
rename p27q1e_ housework 
rename p27q2_ not_worked

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 work_out agr_forest_aqua self_employed income_prop_resources housework not_worked
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p14.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5A_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q5a_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id


* Wage/salary employment
rename p28_stt_ list_jobs
rename p28q1_ occupation_code
rename p28q2_ work_industry
rename p28q8_ avg_hours_work
rename p28q9_ labour_contract
rename p28q10a_ payment_code
rename p28q10b_ payment_value

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 list_jobs occupation_code work_industry avg_hours_work labour_contract payment_code payment_value
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p15.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5B_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q5b_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id


* Working in Agriculture, Aquaculture and/or Forestry
** (Own household production excluding common property resource work)
** For how many days or day equivalents, in the last 12 months was [NAME] involved in the following activities?
rename p29q1a_ rice_cultivation
rename p29q1b_ maize_cultivation
rename p29q1c_ other_crops
rename p29q1d_ livestock
rename p29q1e_ aquaculture
rename p29q1f_ forestry

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 rice_cultivation maize_cultivation other_crops livestock aquaculture forestry
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p16.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5C1_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q5c1_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Non-farm, Non-wage economic activities
gen revenue = p31q13_
gen labour_cost = p31q14_
gen value_exchanged = p31q19_
gen per_income = p31q25_

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 revenue labour_cost value_exchanged per_income
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p17.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5C2_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q5c2_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Working on Non-farm, Non-wage activities
**For how many days, or day equivalents, in the past 12 months was [NAME] involved in the following non-farm - non-wage economic activities?
rename p32q1d_ other_enterprises

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 other_enterprises
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p18.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5F_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q5f_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Transfers and Remittances
rename p35q1_ received_transfers
rename p35q2_ amount_received

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 received_transfers amount_received
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p19.dta", replace

**==========================================================================
* Expenditures, savings, and assets
* Q7A_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q7a_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Food expenditures (in the last 4 weeks)
rename p39q4_ value_food

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 value_food
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p20.dta", replace

**==========================================================================
* Expenditures, savings, and assets
* Q7C_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q7c_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Savings
rename p41q1_ have_savings
rename p41q2_ savings
rename p41q3_ savings_08ago
rename p41q4_ contribute_savings
rename p41q5a_ reason_savings

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 have_savings savings savings_08ago contribute_savings reason_savings
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p21.dta", replace

**==========================================================================
* Expenditures, savings, and assets
* Q7D_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q7d_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Household durable goods
rename p42ma_ type_goods
rename p42q1_ num_hh_goods
rename p42q3_ value_goods

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 type_goods num_hh_goods value_goods
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p22.dta", replace

**==========================================================================
* Credit (Formal and Informal)
* Q8_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q8_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Credit
rename p43q2a_ hh_year_loan
rename p43q6a_ value_interest_rate
rename p43q7_ today_owed
rename p43q8_ duration_loan
rename p43q9_ individual_loan
rename p43q11_ purpose_loan

* Loans? How much?
gen loan_owed = today_owed/1000

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 hh_year_loan value_interest_rate today_owed duration_loan individual_loan purpose_loan purpose_loan
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p23.dta", replace

**==========================================================================
* Shocks and Risk coping
* Q9A_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q9a_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Formal Insurance
rename p45q2_ kind_insurance
rename p45q4a_ pay_insurance
rename p45q5_ received_insurance

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 kind_insurance pay_insurance received_insurance
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p24.dta", replace

**==========================================================================
* Shocks and Risk coping
* Q9B_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q9b_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Risk respone
rename p46q3_ lost_shock
rename p46q4a_ cope_shock
rename p46q5_ recovered_shock

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 lost_shock cope_shock recovered_shock
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p25.dta", replace

**==========================================================================
* Social Capital
* Q10A_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q10a_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Group membership
rename p47q1_ hh_id_org
rename p47q2_ kind_org
rename p47q3_ time_member_org
rename p47q5_ frequency_meet
rename p47q6_ participate_meet
rename p47q7a_ fee_member

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 hh_id_org kind_org time_member_org frequency_meet participate_meet fee_member
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p26.dta", replace

**==========================================================================
* Social Capital
* Q10A1_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q10a1_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Group membership
rename p48q14a_ org_help

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 org_help
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p27.dta", replace

**==========================================================================
* Social Capital
* Q10C_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q10c_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Social Capital - Networks
rename p50q2_ relationship
rename p50q9_ relationship_support
rename p50q12_ support_relationship

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 relationship relationship_support support_relationship
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p28.dta", replace

**==========================================================================
* Sources of Information
* Q12C_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q10f_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Sources of Information
rename p53q1a_ sources_1
rename p53q1b_ sources_2
rename p53q1c_ sources_3

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 sources_1 sources_2 sources_3
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p29.dta", replace

**==========================================================================
* Social Activity
* Q10g_New_08.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2008Data\Q10g_New.dta", clear
gen id = 0
recast double id
replace id= tinh_2008*1000000 + quan_2008*10000 + xa_2008*100 + ma_h0_2008
duplicates list id

* Social Activity
rename p54q1_ hh_event

keep id tinh_2008 quan_2008 xa_2008 ma_h0_2008 hh_event
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p30.dta", replace



**==========================================================================
*MERGING
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p0.dta", clear

*Merging data sheets
	forval num = 1/30{
	merge 1:1 id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p`num'", nogen
	}

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_data.dta", replace
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_p0.dta"

**==========================================================================
**==========================================================================
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_data.dta", clear

*___________________________________________________________________________
* Value of annual land (mil. VND, ln)
gen value_annual_crop = value_plot/1000 if type_plot==1

* Value of perennial land (mil. VND, ln)
gen value_perennial_crop = value_plot/1000 if type_plot==2

* Value of forest land (mil. VND, ln)
gen value_forest = value_plot/1000 if type_plot==3

* Value of fish_shrimp land (mil. VND, ln)
gen value_fish_shrimp = value_plot/1000 if type_plot==4

* Value of grass land (mil. VND, ln)
gen value_grass_land = value_plot/1000 if type_plot==5

* Value of house with garden land (mil. VND, ln)
gen value_house_garden = value_plot/1000 if type_plot==6

* Value of residental land (mil. VND, ln)
gen value_residental_land = value_plot/1000 if type_plot==7

* Value of agricultural land (mil. VND, ln)
gen value_agr_land = value_annual_crop + value_perennial_crop + value_forest + value_fish_shrimp

*___________________________________________________________________________
* Morgated? If yes, what Land Use Right? Residential land, Agri land, Forestland?
* Residential land
gen residential_morgated = 7.type_plot if mortgage==1
tab residential_morgated

* Forestland
gen forest_morgated = 3.type_plot if mortgage==1
tab forest_morgated

* Bio-physical factors
** Basaltic soil (yes = 1)
** Sandy soil (yes = 1)
** Grey soil (yes = 1)

** Soilslope
tab slope_plot
gen flat_slope = 1.slope_plot
gen slight_slope = 2.slope_plot
gen moderate_slope = 3.slope_plot
gen steep_slope = 4.slope_plot

* Average distance from home to plots (km)
gen distance_plot_km = distance_plot/1000

* Forestry income (mil. VND)
gen forest_income = total_income/1000 if work_industry ==2

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2008\2008_data_clean.dta", replace
rename num_under14 num_under16
gen under14=0
replace under14=1 if head_age<14
bysort id: egen num_under14=sum( under14 )
drop under14
drop quan_2008 ma_h0_2008 xa_2008
label variable tinh_2008 "Province"
rename tinh_2008 province
label variable num_trees "Number of tree&bushes planted since July 2006"
label variable member_code "HH member code - individual id"
label variable rel_hh_head "Relationship with the household head"
label variable head_gender "What is the gender of [NAME]?"
label variable head_gender "Gender of HH member"
label variable head_year_born "Year born"
label variable head_material_status "Material status"
label variable attending_school "Currently attending school?"
label variable head_edu "What grade did HH member finish"
label variable highest_diploma "What is the highest diploma HH member has obtained?"
label variable ethnicity "Ethnicity of the HH"
label variable head_hh "Head of the household or the spouse born in this commune"
label variable time_lived "How long has the household lived in this commune? (years)"
label variable house_size "Square meters occupied by the household, including bedrooms, dining rooms, livin"
label variable house_owned "Does the household own this dwelling"
label variable house_rent "How much is paid in rent for this house per month? (000VND)"
label variable hh_poor "Household qualified as poor by the authorities (MOLISA)?"
label variable hh_electricity "Does the household have electricity?"
label variable distance_wood "Average distance to the place where fuel wood is collected(meters)"
label variable time_wood "Average time to collect fuel wood(minutes)"
label variable source_water_hh "Main source of cooking/drinking water of your household?"
label variable distance_road "Distance to the nearest All weather road (km)"
label variable hh_p_use "Nr. of plots that your household has/had use rights to and operates"
label variable hh_p_rent "Nr. of plots that your household is/was renting in or borrowing"
label variable hh_plots_rentout "Nr. of plots that your household has/had use rights to but is renting or lending"
label variable where_riceseed "Where rice seed normally bought"
label variable distance_riceseed "Distance to place where rice seed normally bought(km)"
label variable difficulties_input "HH experienced any of the following difficulties in getting access to current in"
label variable hh_non_economic "During the last 12 months, has HH pursued non-farm, non-wage, non-forestry, non-"
label variable wage_salary "Net income from wage/salary (000VND)"
label variable agr_income "Net income from agricultural activities (000VND)"
label variable common_res_income "Net income from common property resources (000VND)"
label variable non_economic_income "Net income from non-farm non wage economic activities (000VND)"
label variable land_real_estate "Net rental income from LAND/REAL ESTATE (000VND)"
label variable other_assets "Net rental income from OTHER ASSETS (000VND)"
label variable sales_assets "Net income from sales of assets (000VND)"
label variable hh_private_trans "Net income from private transfers (000VND)"
label variable hh_public_trans "Net income from public transfers (000VND)"
label variable other_income "Net income from other sources (000VND)"
label variable total_income "Net income TOTAL (000VND)"
label variable hh_agr_extension "Over the last 12 months, has anyone in HH visited agricultural extension agent o"
label variable frequency_extension "In the last 12 months, how many times did members of HH go to agricultural exten"
label variable rejected_loan "How many times since 1 July 2006 have you had a loan rejected?"
label variable wtp_insurance_crop "If insurance against loss or damage of crop were available, how much would respo"
label variable acquire_plot "How was this land acquired"
label variable agr_forest_aqua "Participating in household production related to agriculture, forestry and aquac"
label variable agreement_plot "What type of agreement was made with owner"
label variable amount_received "Total amount/money equivalent household received-last 12 months"
label variable aquaculture "Number of days/day equivalents in the last 12 months involved in AQUACULTURE"
label variable area_comp "Area used for this purpose-main crop"
label variable area_crop "Estimated are in hectares of 3 most important crops in the last 12 months"
label variable area_plot "Total area of the plot (sqm)"
label variable area_plot_sold "Area of the plot (sqm)"
label variable area_received_sold "Area of the land received in return for this plot (sqm)"
label variable area_second "Area used for this purpose-main crop"
label variable area_third "Area used for this purpose-main crop"
label variable avg_hours_work "On average how many hours usually worked per day"
label variable barter_live_aqua "Amount bartered during the last 12 months (kg)"
label variable bartered_aquaculture "Value of the output bartered (000VND)"
label variable bartered_live_aqua "Value of output bartered (000VND)"
label variable cash_input "In TOTAL production of all crops, amount used of this input during the last 12 m"
label variable cash_plot_sold "Amount received as payment or compensation for this plot (000VND)"
label variable cash_rentout "How much did you receive in rent for this plot in the last 12 months, in cash an"
label variable cash_sold "Total amount received from sales (000VND)"
label variable cash_sold "Does plot have any of the following trees and bushes? COFFEE"
label variable cash_sold "Total amount received from sales (000VND)"
label variable coffee_plot "Does plot have any of the following trees and bushes? COFFEE"
label variable conservation_plot "Does plot have any of the following trees and bushes? SOIL FERTILITY CONSERVATIO"
label variable contract_crop "Contract with main buyer in advance of harvest"
label variable contribute_savings "Contribution to these savings/assets over the past 12 months (000VND)"
label variable convert_plot "Would the authorities allow to convert the plot into non-agricultural use"
label variable cope_shock "Cope with the shock-two most important-1"
label variable difficulties_input "HH experienced any of the following difficulties in getting access to current in"
label variable distance_plot "Distance of this plot from the family home (meters)"
label variable distance_plot_sold "Distance between the house and the plot (meters)"
label variable duration_loan "Duration of the loan from inception (months)"
label variable duration_rent "How long is the duration of the contract"
label variable duration_rentout "How long is the duration of the current contract?"
label variable fee_member "For information, how trustworthy are - EXTENSION AGENTS"
label variable fee_member "Membership fee -amount(000VND)"
label variable forestry "Forestry products from common resources"
label variable frequency_meet "Frequency of meeting with group"
label variable friends_trust_positions "Any personal friends holding office or other trusted positions in the Commune, o"
label variable hh_aquaculture "Has HH had any livestock or aquaculture production in the last 12 months"
label variable hh_event "Household hosted or attended event-last 12 months"
label variable hh_id_org "HH member ID if a member of any groups, organizations, or associations"
label variable hh_internet "Access to internet services, if yes where mainly?"
label variable hh_out_trust_positions "Any relatives outside HH holding office or other trusted positions in the Commun"
label variable hh_trust_positions "Any HH member holding office or other positions of public responsibility in the "
label variable hh_year_loan "Year&month household obtained the loan- YEAR"
label variable housework "Doing housework or chores (cleaning, collecting firewood, washing clothes, e"
label variable income_prop_resources "Using common property resources to generate income for the household (huntin"
label variable individual_loan "Institution/individual loan was obtained from"
label variable infrast_soil "Soil and water conservation on plot- 1st"
label variable input_aquaculture "Value of input in aquaculture production (000VND)"
label variable input_crop "Input"
label variable input_livestock "Value of input in livestock production (000VND)"
label variable investment_trees "Any investments on trees&bushes since July 2006"
label variable irrigated_plot "Plot is irrigated"
label variable kind_insurance "Kind of insurance"
label variable kind_org "Kind of organisation member of"
label variable labour_contract "Working on a labour contract"
label variable labour_cost "Expenditure on raw materials and small non-durable tools-past 12 months (000VND)"
label variable list_jobs "Job number"
label variable livestock "Number of days/day equivalents in the last 12 months involved in LIVESTOCK"
label variable loss_harvest "Estimated post-harvest loss, in percent of total harvest"
label variable lost_shock "Amount lost due to this event (000VND)"
label variable maize_cultivation "Number of days/day equivalents in the last 12 months involved in MAIZE CULTIVATI"
label variable mortgage "Plot ever used to obtain a mortgage"
label variable mortgage_rentout "Plot ever used to obtain a mortgage"
label variable not_worked "Why has [NAME] not worked in the last 12 months"
label variable num_hh_goods "Number hold by household"
label variable num_support "Number of people known whom could be asked for help with [this]"
label variable occupation_code "Occupation code of work during the last 12 months"
label variable org_help "Group helps to get access to any of the following services- FIRST service"
label variable other_crops "Number of days/day equivalents in the last 12 months involved in TOTAL ALL OTHER"
label variable other_enterprises "Number of days/day equivalents involved in all other enterprises"
label variable other_plot "Does plot have any of the following trees and bushes? OTHER"
label variable output_quantity "Total quantity of output produced (kg)"
label variable owner_plot "From whom was plot rented or borrowed"
label variable paid_plot "What have you paid in rent for this plot in the last 12 months, in cash and i"
label variable part_plot "How did you part with this plot of land?"
label variable participate_meet "Participation in meetings"
label variable pay_insurance "Amount paid per time unit (000 VND)"
label variable payment_code "Amount received for this work, per unit of time-TIME UNIT CODE"
label variable payment_value "Amount received for this work, per unit of time? VALUE (000VND)"
label variable per_income "Percentage of income from this business received by household (%)"
label variable plot_id "group(plot_code)"
label variable problem_plot "Experiencing problems with any of a list of conditions"
label variable product_plot "Does plot have any of the following trees and bushes? FRUIT"
label variable purpose_comp "Plot use-main crop-most recent season"
label variable purpose_loan "Stated purpose of the loan"
label variable purpose_second "Plot use-main crop-2nd most recent season"
label variable purpose_third "Plot use-main crop-3rd recent season"
label variable quality_plot "Quality of this plot compared to avg land fertility in village"
label variable quantity_comp "Total quantity produced-number"
label variable quantity_second "Total quantity produced-number"
label variable quantity_third "Total quantity produced-number"
label variable reason_crop "Reason for growing this crop?"
label variable reason_plot_sold "Why was plot departed with"
label variable reason_savings "Main reasons for saving through [type] - 1"
label variable received_insurance "Amount claimed since July 2006"
label variable received_transfers "Received any money or goods from persons who are not members of household"
label variable recovered_shock "Extent of recovery from the shock"
label variable redbook "Red book for this land"
label variable redbook_rentout "Red book for this land"
label variable redbook_sold "Red book for this land at the time when HH departed with it"
label variable relationship "Relationship with network member"
label variable relationship_support "Would you ask this network member for advice/support in other matters as well"
label variable rental_income "Net rental income (000VND)"
label variable rephh08 "=1 if HH is a new HH introduced to replace a 2006 household"
rename rephh08 replacementhousehold
label variable responsible_plot "Who is mainly responsible for operating this plot?"
label variable restrictions_crop "Any formal restrictions on household's choice of crops/"
label variable restrictions_cropA "Which restrictions apply to your choice of crops? // [Choose one]"
label variable revenue "Total revenue for the months the business was under operation-past 12 months (00"
label variable rice_cultivation "Number of days/day equivalents in the last 12 months involved in RICE CULTIVATIO"
label variable savings "Money value of this saving/asset today (000VND)"
label variable savings_08ago "Money value of this saving/asset 12 months ago (000VND)"
label variable self_employed "Doing trading, services, transportation, or other business (self employed) for t"
label variable slope_plot "Slope of plot"
label variable sold_live_aqua "Value received for output sold (000VND)"
label variable sold_quantity "Total quantity sold (kg)"
label variable sources_1 "Which sources of information are important for you, regarding the following "
label variable sources_2 "Which sources of information are important for you, regarding the following "
label variable sources_3 "Which sources of information are important for you, regarding the following "
label variable spend_tet "How much did you spend during the Tet holidays?"
label variable suffer_unexpected "Since 1 July 2006, did the household suffer from an unexpected loss from any "
label variable support_relationship "Would this network member come to you for advice on any of these matters as well"
label variable tea_plot "Does plot have any of the following trees and bushes? TEA"
label variable timber_plot "Does plot have any of the following trees and bushes? TIMBER"
label variable time_acquire_plot "When was this land acquired"
label variable time_fallow "Number of months plot been left fallow during the last 5 years"
label variable time_fallow_plot "How many months has this plot been left fallow during last 5 years"
label variable time_member_org "Year when you became a member of this group"
label variable time_plot_sold "Year plot was departed with"
label variable time_rent_plot "Since which year has HH rented or borrowed this land"
label variable time_rentout "When did you start to rent/lend out this plot?"
label variable today_owed "Amount owed today (000VND)"
label variable today_owed "Net income TOTAL (000VND)"
label variable today_owed "Amount owed today (000VND)"
label variable type_plot "Type of land"
label variable unit_comp "Total quantity produced-unit"
label variable unit_second "Total quantity produced-unit"
label variable unit_third "Total quantity produced-unit"
label variable unit_third "Could plot be used for mortgage"
label variable use_mortgage "Could plot be used for mortgage"
label variable use_mortgage_rentout "Could plot be used for mortgage"
label variable value_aquaculture "Value of output consumed (000VND)"
label variable value_exchanged "Value of exchanged goods and services-past 12 months (000VND)"
label variable value_food "Total monetary value consumed in the past 4 weeks (000VND)"
label variable value_goods "If one of items sold today, how much money could one get for it (000VND)"
label variable value_interest_rate "Interest rate- Amount(000 VND)"
label variable value_live_aqua "Value of output consumed (000VND)"
label variable value_output "Total value of output produced (000VND)"
label variable value_plot "Sales value of plot if sold today (000VND)"
label variable who_purchased "Who purchased, received or took this land?"
label variable who_rentout "To whom is this plot rented or lent out?"
label variable work_industry "Industry/branch"
label variable work_out "Working for a wage/salary outside the household"
label variable year_redbook "Year red book was acquired"
label define TINH_2008 105 "Ha Tay" 205 "Lao Cai" 217 "Phu Tho" 301 "Lai Chau" 302 "Dien Bien" 403 "Nghe An" 503 "Quang Nam" 511 "Khanh Hoa" 605 "Dak Lak" 606 "Dak Nong" 607 "Lam Dong" 801 "Long An", replace
rename savings_08ago savings_12ago