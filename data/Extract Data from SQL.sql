

--Code to extract the indicators we need for dashboard

select 
cohort_19_in
,number_in_ss_cohort
,region
,la_code_9
,la_code_3
,CASE WHEN la_name = 'Herefordshire, County of' THEN 'Herefordshire' ELSE la_name end as la_name
,gender
,fsm
,sen
,l2_by19
,l2_with_em_by19
,l3_by19
,l2_em_by16
,l2_em_by19_belowat16
,(cast ([l2_by19] as decimal (10,3)) / NULLIF (cast ([Number_in_ss_cohort] as decimal (10,3)),0)*100) as l2_by19_rate
,(cast ([l2_with_em_by19] as decimal (10,3)) / NULLIF (cast ([Number_in_ss_cohort] as decimal (10,3)),0)*100) as l2_with_em_by19_rate
,(cast ([l3_by19] as decimal (10,3)) / NULLIF (cast ([Number_in_ss_cohort] as decimal (10,3)),0)*100) as l3_by19_rate
,(cast ([em_gcseac_othL2_by19_belowat16] as decimal (10,3)) / (NULLIF (cast ([Number_in_ss_cohort] - [em_gcseac_othL2_by16] as decimal (10,3)),0))*100)  as l2_em_by19_belowat16_rate
from  [MatchedAdminSQL].[dbo].[L2_3attainment_LA]
where sen_major = 'ALL'
order by cohort_19_in

