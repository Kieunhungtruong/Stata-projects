***2014
**==========================================================================
* Phieu_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Phieu_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

*Calculate p13q12, p13q13 & p13q14 for each HH
collapse (sum) p13q12 p13q13 p13q14, by (id id tinh_2014 quan_2014 xa_2014 ma_h0_2014)
duplicates list id 

label variable p13q12 "Number of tree&bushes planted since July 2012"
label variable p13q13 "What was the total cash spending by your household on investment in trees and bushes since 1 July 2012?"
label variable p13q14 "How many days of labour did your household spend on investment in trees and bushes since 1 July 2012?"

* Household investment on plots since 1 July 2012
rename p13q12 num_trees
rename p13q13 spent_trees
rename p13q14 labour_trees
*thay đổi
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p0.dta", replace

*** Respondents
**======================================================================
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Phieu_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

keep id tinh_2014 quan_2014 xa_2014 ma_h0_2014 ntlp1
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_res.dta", replace

**======================================================================
* Q1_New_14.dta
**Section 1A
***HH_size (Number of family members)
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q1_New_14.dta", clear

* Create HH_ID
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Create age variables
gen age=2014- p1q4_
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
rename p1stt_ member_code
rename p1q2_ rel_hh_head
rename p1q3_ gender
rename p1q4_ year_born
rename p2q8_ material_status
rename p2q9_ attending_school
rename p2q10_ edu
rename p2q12_ highest_diploma

keep if rel_hh_head==1
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
*Merge with Respondents
merge 1:1 id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_res.dta", nogen

*Keep data for only respondent

duplicates list id 
*Confirm no HHs has >1 respondent

* Save data: only for head

duplicates list id

keep id tinh_2014 quan_2014 xa_2014 ma_h0_2014 ntlp1 member_code rel_hh_head gender year_born age material_status HH_size num_under6 num_over60 num_under14 attending_school edu highest_diploma
order id, first
foreach stud in age gender year_born edu material_status {
	rename `stud' head_`stud'
	}
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p1.dta", replace

**==========================================================================
* Phieu_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Phieu_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

*Housing
rename ma_dan_toc ethnicity
rename p3q1 head_hh
rename p3q2 time_lived
rename p3q3 house_size
rename p3q7 house_owned
rename p3q8 house_rent
rename p3q9 hh_poor
rename p3q10 hh_electricity
rename p3q13 distance_wood
rename p3q14 time_wood
rename p3q17 source_water_hh
rename p3q20b distance_road

*Land use
rename p4q2_1 hh_p_use
rename p4q2_2 hh_p_rent
rename p4q2_3 hh_plots_rentout
rename dat_a hh_plots_use
rename dat_b hh_plots_rent
rename dat_c hh_plots_rent_out
rename dat_d hh_plots_departed
rename dau_tu hh_invested

* When the government confiscates a plot of land, and there is no other land available for compensation, what compensation is the land user entitled to?
rename p14q3 duration_agr_land
rename p14q4 hh_percept_confiscate

* Livestock, aquaculture, agricultural services, access to markets
rename p20q1 hh_aquaculture
rename p24q1 aquaculture_not_hh

* Access to markets for Agricultural Inputs and Outputs
rename p25q2 where_riceseed
rename p25q3 distance_riceseed
rename p25q4 difficulties_input
rename p25q6a distance_output

* Occuption, time use, and other sources of income
rename p29a hh_non_economic

* Transfers and Remittances
**How much did your household receive from this source in the last 12 months? (1000 VND)
rename p34q5_01 social_insurance
rename p34q7 amount_given 

* Total income of household in last 12 months
**During the last 12 months, approximately how much was your household's net income from the following sources - including cash and in-kind payments?(1000 VND)
rename p35q1 wage_salary
rename p35q2 agr_income
rename p35q3 common_res_income
rename p35q4 non_economic_income
rename p35q5 rental_income
rename p35q5a land_real_estate
rename p35q5b other_assets
rename p35q6 sales_assets
rename p35q7 hh_private_trans
rename p35q8 hh_public_trans
rename p35q9 other_income
rename p35q10 total_income

** Share off-farm income (%)
gen off_farm_income = non_economic_income/total_income

* Access to Extension services
rename p36q1 hh_agr_extension
rename p36q2 frequency_extension
**Did your household obtain assistance or information on the following topics in the last 12 months?
rename p36q4a new_seeds
rename p36q4b fertilizer
rename p36q4c irrigation
rename p36q4d hh_pest_blight 
rename p36q4e livestock_disease
rename p36q4f infor_market
rename p36q4g loan
rename p36q4h climate_change 
rename p36q5 affect_crop
rename p36q6 affect_livestock
rename p36q7 affect_aquaculture
rename p36q8 affect_sell
rename p36q9 climate_affect_agr

* Credit (Formal and Informal)
rename p42q21 rejected_loan

* Risk response
rename p44q8a weather_agr_1y
rename p44q8b weather_agr_3y

* Political connections
rename p54q1 hh_trust_positions
rename p54q4 hh_out_trust_positions
rename p54q7 friends_trust_positions

* Sources of information
rename p55q2 hh_internet
rename p55q3b_01 relatives
rename p55q3b_02 community_bulletin
rename p55q3b_04 local_market
rename p55q3b_08 extension_agents
rename p55q3b_09 other_groups
rename p55q3b_10 work_associates
rename p55q3b_11 internet

* Social Activity
rename p56q8 spend_tet
rename p56q9a hh_passedaway

* Formal Insurance
rename p43q6 wtp_insurance_crop

* Risk respone
rename p44q1 suffer_unexpected

* Social Capital - Networks
rename p47q13 num_support

drop p*****
drop quan_2014 xa_2014 ma_h0_2014 tinh_2012 quan_2012 xa_2012 ma_h0_2012 thay_cho_o thay_doi_chu_ho tieng_viet tieng_chinh
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p2.dta", replace

**==========================================================================
* Phieu1_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Phieu1_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Livestock, aquaculture, agricultural services, access to markets
rename p24ls hh_forest_product

keep id hh_forest_product
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p3.dta", replace


**==========================================================================
* Q2_New_14.dta: 
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

*1. Information about Plots
rename p5ma_ plot_code
rename p5q1_ distance_plot
rename p5q3a_ area_plot
rename p5q3b_ diff_plot_12
rename p5q4_ acquire_plot
rename p5q5_ time_acquire_plot
rename p5q6_ value_plot
rename p5q7_ type_plot
rename p6q8_ slope_plot
rename p6q9_ problem_plot
rename p6q10_ quality_plot
rename p6q10b_ change_quality_plot
rename p6q11_ irrigated_plot
rename p7q15a_ infrast_soil
rename p7q18_ convert_plot
rename p7q19_ restrictions_crop
rename p7q20_ restrictions_cropA
rename p7q21a_ product_plot
rename p7q21b_ coffee_plot
rename p7q21c_ tea_plot
rename p7q21d_ timber_plot
rename p7q21e_ conservation_plot
rename p7q21f_ other_plot

* Ownership status of forestland (=1 if HH has LURC)
tab type_plot
gen owner_forest= 3.type_plot
tab owner_forest
 
* Number of year using forestland (years)
gen use_land = 2014 - time_acquire_plot
gen use_forestland = use_land if type_plot==3
 
keep id plot_code distance_plot area_plot diff_plot_12 acquire_plot time_acquire_plot value_plot type_plot slope_plot problem_plot quality_plot change_quality_plot irrigated_plot infrast_soil convert_plot restrictions_crop restrictions_cropA product_plot product_plot coffee_plot tea_plot timber_plot conservation_plot other_plot owner_forest use_land use_forestland
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp1.dta", replace


**==========================================================================
* Q2A_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2A_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Plots owned and operated
rename p8ma_ plot_code
rename p8q2a_ redbook
rename p8q2b_ not_redbook
rename p8q4_ year_redbook
rename p8q8_ mortgage
rename p8q9_ use_mortgage
rename p8q10_ time_fallow

keep id plot_code redbook not_redbook year_redbook mortgage use_mortgage time_fallow
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp2.dta", replace


**==========================================================================
* Q2B_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2B_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Plots rented in or borrowed
rename p9ma_ plot_code
rename p9q1_ time_rent_plot
rename p9q2_ responsible_plot
rename p9q3_ owner_plot
rename p9q4_ paid_plot
rename p9q5_ agreement_plot
rename p9q6_ duration_rent
rename p9q8_ time_fallow_plot

keep id plot_code time_rent_plot responsible_plot owner_plot paid_plot agreement_plot duration_rent duration_rent time_fallow_plot
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp3.dta", replace

**==========================================================================
* Q2C_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2C_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Plots rented out or lent out
rename p10ma_ plot_code
rename p10q1_ who_rentout
rename p10q2a_ redbook_rentout
rename p10q2b_ not_redbook_rentout
rename p10q4_ year_redbook_rentout
rename p10q8_ mortgage_rentout
rename p10q9_ use_mortgage_rentout
rename p10q10_ cash_rentout
rename p10q11_ time_rentout
rename p10q12_ duration_rentout

keep id plot_code who_rentout redbook_rentout not_redbook_rentout mortgage_rentout use_mortgage_rentout cash_rentout time_rentout duration_rentout
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp4.dta", replace

**==========================================================================
* Q2D_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2D_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014

* Land sold, taken, given away or permanently exchanged since 1 July 2012
rename p11ma_ plot_code
rename p11q1_ time_plot_sold
rename p11q2a_ redbook_sold
rename p11q2b_ not_redbook_sold
rename p11q4_ area_plot_sold
rename p11q5_ distance_plot_sold
rename p11q6_ part_plot
rename p11q7_ area_received_sold
rename p11q8_ who_purchased
rename p11q9_ reason_plot_sold
rename p11q10_ cash_plot_sold

keep id plot_code time_plot_sold redbook_sold not_redbook_sold area_plot_sold distance_plot_sold part_plot area_received_sold who_purchased reason_plot_sold reason_plot_sold cash_plot_sold
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp5.dta", replace

**==========================================================================
* Q2E_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2E_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id


* Household investment on plots since 1 July 2012
rename p12ma_ plot_code
rename p13q11_ investment_trees

keep id plot_code investment_trees
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp6.dta", replace


**==========================================================================
*MERGING WITH PLOT_CODE
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp1.dta", clear

*Merging data sheets
	forval num = 2/6{
	merge 1:1 id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_pp`num'", nogen
	}

*Creating a unique ID 
sort id
egen plot_id = group(plot_code)

duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p04.dta", replace

**==========================================================================
* Colllapse Plots by IDs
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p04.dta", clear

collapse (sum) plot_id, by (id)
tab plot_id

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p041.dta", replace

**==========================================================================
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p041.dta", clear

*Merging data sheets
merge 1:1 id plot_id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p04.dta", nogen

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p4.dta", replace


***=======================================
* Q2_New_14.dta:Landing
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2_New_14.dta", clear
*1.Create HH_ID
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014

*2. Gen new variables (m2) for each land type
forval n = 1(1)8 {
 gen land`n' = p5q3a_ if p5q7_ == `n'
}

*3. Calculate land area for each land type
collapse (sum) land*, by (id)
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
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
*4.save data
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p5.dta", replace


***=======================================
* Q2_New_14.dta:Year_obtained_type_landing
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q2_New_14.dta", clear
*1.Create HH_ID
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014

*2. Gen new variables (year) for each land type
forval n = 1(1)8 {
 gen land`n' = p5q5_ if p5q7_ == `n'
}

* rename variables
rename land1 y_annual_crop
rename land2 y_perennial_crop
rename land3 y_forest
rename land4 y_fish_shrimp

drop land*
keep id y_annual_crop y_perennial_crop y_forest y_fish_shrimp
order id, first
*thay đổi
mdesc
drop if id ==.
duplicates report id
duplicates drop id, force
*4.save data
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p6.dta", replace


**==========================================================================
* Agriculture
* Q3A_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q3A_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Agriculture production for last 12 months by plot
rename p15ma1_ plot_code

** Most recent completed season
rename p15q1_ purpose_comp
rename p15q2_ area_comp
rename p15q3a_ quantity_comp
rename p15q3b_ unit_comp
rename p15q4_ reason_crop


** Second most recent season
rename p15q5_ purpose_second
rename p15q6_ area_second
rename p15q7a_ quantity_second
rename p15q7b_ unit_second


** Third most recent season
rename p15q8_ purpose_third
rename p15q9_ area_third
rename p15q10a_ quantity_third
rename p15q10b_ unit_third

keep id plot_code purpose_comp area_comp quantity_comp unit_comp reason_crop purpose_second area_second quantity_second unit_second purpose_third area_third quantity_third unit_third
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p07.dta", replace

**==========================================================================
*MERGING WITH PLOT_CODE
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p4.dta", clear

*Merging data sheets
merge 1:1 id plot_code using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p07", nogen

duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p7.dta", replace

**==========================================================================
* Agriculture
* Q3B_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q3B_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Crop production of the household in the last 12 months
rename p16ma_ crop
rename p16q1_ output_quantity
rename p16q2_ value_output
rename p16q3_ loss_harvest
rename p16q4a_ sold_quantity
rename p16q4b_ bartered_quantity
rename p16q5a_ cash_sold
rename p16q5b_ cash_bartered
rename p16q9c_ contract_crop
rename p16q9d_ contract_price
rename p16q10_ area_crop

keep id crop output_quantity value_output loss_harvest sold_quantity bartered_quantity cash_sold cash_bartered contract_crop contract_price area_crop
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p8.dta", replace

**==========================================================================
* Agriculture
* Q3C_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q3C_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id


* Cost of cultivation of crops 
**(including rice, fruits and vegetables, but NOT forestry and fishery)
rename p17ma_ input_crop
rename p17q1_ cash_input

keep id input_crop cash_input
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p9.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4A_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q4A_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
rename p20q4_ Totalnumlive
rename p20q5_ Totallivesold
collapse (sum) Totalnumlive Totallivesold, by (id)
keep id Totalnumlive Totallivesold
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p10.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4B_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q4B_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Produce
rename p22ma_ live_aqua_product
rename p22q2_ value_live_aqua
rename p22q4_ sold_live_aqua
rename p22q5_ barter_live_aqua
rename p22q6_ bartered_live_aqua

keep id live_aqua_product value_live_aqua sold_live_aqua barter_live_aqua bartered_live_aqua
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p11.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4B1_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q4B1_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Produce_Input
rename p23q7_ input_livestock
rename p23q8_ input_aquaculture

keep id input_livestock input_aquaculture
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p12.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4C1_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q4C1_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Aquaculture products from common property resources
rename p24q3_ value_aquaculture
rename p24q7_ bartered_aquaculture

keep id value_aquaculture bartered_aquaculture
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p13.dta", replace

**==========================================================================
* Livestock, aquaculture, agricultural services, access to markets
* Q4C2_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q4C2_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Forestry products from common property resources
rename p24maa_ forest_product
rename p24q2aa_ collect_material
rename p24q2ab_ process_material
rename p24q2ac_ purpose_product
rename p24q2ad_ hh_consume_product 
rename p24q3a_ output_forest_product
rename p24q4a_ sold_forest_product
rename p24q5a_ cash_forest_product
rename p24q6a_ barter_forest_product
rename p24q7a_ bartered_forest
rename p24q8aa_ org_regulates
rename p24q8ab_ type_org_regulates
rename p24q9a_ reduce_product

keep id forest_product collect_material process_material purpose_product hh_consume_product output_forest_product sold_forest_product cash_forest_product barter_forest_product bartered_forest org_regulates type_org_regulates reduce_product
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p14.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q5_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id


* Employment status
rename p26q1a_ work_out
rename p26q1b_ agr_forest_aqua
rename p26q1c_ self_employed
rename p26q1d_ income_prop_resources
rename p26q1e_ housework 
rename p26q2_ not_worked

keep id work_out agr_forest_aqua self_employed income_prop_resources housework not_worked
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p15.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5A_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q5A_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id


* Wage/salary employment
rename p27_stt_ list_jobs
rename p27q1_ occupation_code
rename p27q2_ work_industry
rename p27q8_ avg_hours_work
rename p27q9_ labour_contract
rename p27q10a_ payment_code
rename p27q10b_ payment_value

keep id list_jobs occupation_code work_industry avg_hours_work labour_contract payment_code payment_value
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p16.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5B_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q5B_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id


* Working in Agriculture, Aquaculture and/or Forestry
** (Own household production excluding common property resource work)
** For how many days or day equivalents, in the last 12 months was [NAME] involved in the following activities?
rename p28q1a_ rice_cultivation
rename p28q1b_ maize_cultivation
rename p28q1c_ other_crops
rename p28q1d_ livestock
rename p28q1e_ aquaculture
rename p28q1f_ forestry

keep id rice_cultivation maize_cultivation other_crops livestock aquaculture forestry
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p17.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5C1_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q5C1_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Non-farm, Non-wage economic activities
rename p30q13_ revenue
rename p30q14_ labour_cost
rename p30q19_ value_exchanged
rename p30q25_ per_income

keep id revenue labour_cost value_exchanged per_income
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p18.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5C2_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q5C2_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Working on Non-farm, Non-wage activities
**For how many days, or day equivalents, in the past 12 months was [NAME] involved in the following non-farm - non-wage economic activities?
rename p31q1d_ other_enterprises

keep id other_enterprises
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p19.dta", replace

**==========================================================================
* Occuption, time use, and other sources of income
* Q5F_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q5F_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Transfers and Remittances
rename p34q1_ received_transfers
rename p34q2_ amount_received

keep id received_transfers amount_received
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p20.dta", replace

**==========================================================================
* Expenditures, savings, and assets
* Q7A_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q7A_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Food expenditures (in the last 4 weeks)
rename p37q4_ value_food

keep id value_food
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p21.dta", replace

**==========================================================================
* Expenditures, savings, and assets
* Q7C_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q7C_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Savings
rename p39q1_ have_savings
rename p39q2_ savings
rename p39q3_ savings_12ago
rename p39q4_ contribute_savings
rename p39q5a_ reason_savings

keep id have_savings savings savings_12ago contribute_savings reason_savings
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p22.dta", replace

**==========================================================================
* Expenditures, savings, and assets
* Q7D_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q7D_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Household durable goods
rename p40ma_ type_goods
rename p40q1_ num_hh_goods
rename p40q3_ value_goods

keep id type_goods num_hh_goods value_goods
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p23.dta", replace

**==========================================================================
* Credit (Formal and Informal)
* Q8_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q8_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Credit
rename p41q2b_ hh_year_loan
rename p41q6a_ value_interest_rate
rename p41q7_ today_owed
rename p41q8_ duration_loan
rename p41q9_ individual_loan
rename p41q11_ purpose_loan
rename p41q13_ collateral_loan
rename p41q14_ kind_collateral_loan
rename p41q15_ value_collateral

* Loans? How much?
gen loan_owed = today_owed/1000

keep id hh_year_loan value_interest_rate today_owed duration_loan individual_loan purpose_loan purpose_loan collateral_loan kind_collateral_loan value_collateral
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p24.dta", replace

**==========================================================================
* Shocks and Risk coping
* Q9A_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q9A_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Formal Insurance
rename p43q2_ kind_insurance
rename p43q4a_ pay_insurance
rename p43q5_ received_insurance

keep id kind_insurance pay_insurance received_insurance
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p25.dta", replace

**==========================================================================
* Shocks and Risk coping
* Q9B_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q9B_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Risk respone
rename p44q3_ lost_shock
rename p44q4a_ cope_shock
rename p44q5_ recovered_shock

keep id lost_shock cope_shock recovered_shock
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p26.dta", replace

**==========================================================================
* Social Capital
* Q10A_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q10A_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Group membership
rename p45q1_ hh_id_org
rename p45q2_ kind_org
rename p45q3_ time_member_org
rename p45q5_ frequency_meet
rename p45q6_ participate_meet
rename p45q7a_ fee_member

keep id hh_id_org kind_org time_member_org frequency_meet participate_meet fee_member
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p27.dta", replace

**==========================================================================
* Social Capital
* Q10A1_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q10A1_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Group membership
rename p46q14a_ org_help

keep id org_help
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p28.dta", replace

**==========================================================================
* Social Capital
* Q10C_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q10C_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Social Capital - Networks
rename p47q2_ relationship
rename p47q9_ relationship_support
rename p47q12_ support_relationship

keep id relationship relationship_support support_relationship
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p29.dta", replace

**==========================================================================
* Sources of Information
* Q12C_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q12C_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Sources of Information
rename p55q1a_ sources_1
rename p55q1b_ sources_2
rename p55q1c_ sources_3

keep id sources_1 sources_2 sources_3
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p30.dta", replace

**==========================================================================
* Social Activity
* Q12D_New_14.dta
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\VARHS2014Data\Q12D_New_14.dta", clear
gen id = 0
recast double id
replace id= tinh_2014*1000000 + quan_2014*10000 + xa_2014*100 + ma_h0_2014
duplicates list id

* Social Activity
rename p56q1_ hh_event

keep id hh_event
order id, first
duplicates list id
duplicates drop id, force
save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p31.dta", replace



**==========================================================================
*MERGING
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p0.dta", clear

*Merging data sheets
	forval num = 1/31{
	merge 1:1 id using "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_p`num'", nogen
	}

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_data.dta", replace


**==========================================================================
**==========================================================================
use "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_data.dta", clear

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

save "C:\Users\NHUNG\Dropbox\HAPRI team\8 Dataraw\VARHS\(3d)VARHS\Impact treeplanting\Panel\2014\2014_data_clean.dta", replace
