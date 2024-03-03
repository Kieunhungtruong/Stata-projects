drop if khu_vuc==2
(drop urban households)

gen age=2016- p1q4b_
rename p2q10_ edu
rename p1q3_ sexhh
rename p47q5_ sex
rename p2q8_ marriedstatus
rename p3q1 dum_local
rename p20q5_ livestock 
(total livestock value)


 rename p20q4_ numb_livestock
 rename p7q21d_ dum_timber
 rename p7q21a_ dum_fruit
 rename p13q12 numberoftrees
 rename p13q13 invest_cash
 rename p13q14 invest_laborday
 rename p28a non_farmwageinc
 rename p34q4 non_farmwageinc2
 rename p34q1 wage_inc

rename p3q14 time_colfuelwood
rename p6q10_ soil_qual
 rename p10q8_ morgtaged
 
 (category 13: Never went to school/did not finish 1st )


*/* LAND
rename p14q4 land_tenureR
 rename p4q2_2 numplot_rent
 rename p4q2_1 numplot_own
 rename p4q2_3 lease
 rename p5q3a_ plotsize
 rename p5q4_ landorigin
 rename p5q5_ yrobtained
 rename p5q6_ land_ land_currsalevalue
rename p5q7_ land_category
rename p6q8_ land_slope
rename p7q18_ convertbygov
(gov allow to convert to agricultural land)
rename p10q2a_ dum_LURC
(rename  p8q2a_ ownstat)

rename p10q2b_ reason_nLURC
 rename p10q10_ land_currrlentval
rename p10q12_ land_duracontr
 rename p11q1_ land_yrpasson
  rename p11q4_ plot_area

rename p11q5_ dist_home
rename p3q20b dist_road
rename p11q9_ land_sellingreason
 rename p11q10_ land_compamount

rename p27q1f_ labor_forestry



rename p35q2 numb_visextension

*/*
VARHS: 2016
-	Bỏ p3q11 -p320h, chỉ giữ lại p3q20b
-	Bỏ toàn bộ q18
-	Bỏ toàn bộ q24
-	Bỏ toàn bộ p33
-	Bỏ toàn bộ p35 (chỉ giữ lại p35q1)
-	Bỏ toàn bộ p37
-	Bỏ toàn bộ p41
-	Bỏ toàn bộ p57 (chỉ giữ lại p57q1)
-	Bỏ toàn bộ p58
-	Bỏ toàn bộ p59
-	Bỏ toàn bộ p20 (chỉ giữ lại p20q5_)
-	Bỏ toàn bộ p21


 drop p35q3 p35q4a p35q4b p35q4c p35q4d p35q4e p35q4f p35q4g p35q4h p35q5 p35q6 p35q7 p35q8 p35q9 p37q1_01 p37q1_02 p37q1_03 p37q1_04 p37q1_05 p37q1_06 p37q1_07 p37q1_08 p37q1_09 p37q1_10 p37q1_11 p37q2 p37q3a p37q3b p40q1 p41q21 p41q22a p41q22b p41q22c p42q1 p42q6 p43q1 p43q8a p43q8b p46q13 p57q2a p57q2b p57q3a p57q3b p57q5a p57q5b p57q6a p57q6b p57q7 p57q8a p57q8b p58q2 p58q3b_01 p58q3b_02 p58q3b_03 p58q3b_04 p58q3b_05 p58q3b_06 p58q3b_07 p58q3b_08 p58q3b_09 p58q3b_10 p58q3b_11 p59q8 p59q9a p59q9b p59q9c p59q9d p1q5_ p1q6a_ p1q6b_ p1q7_ p20q3_ p20q2_ p17q3_ p17q2_ p20q6_ p20q7_ p20q8_ p20q9_ p20q10_ p20q11_ p20q12a_ p20q12b_ p21q13_ p21q14_ p21q15_ p22ma_ p22q1_ p22q2_ p22q3_ p22q4_ p22q5_ p22q6_ p22q7_ p22q8_ p23ma_ p23q2_ p23q3_ p23q4_ p23q5_ p23q6_ p23q7_ p23q8a_