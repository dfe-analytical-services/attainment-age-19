

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
into #working
from  [MatchedAdminSQL].[dbo].[L2_3attainment_LA]
where sen_major = 'ALL'
order by cohort_19_in


--This one creates the data needed for the value boxes
drop table #working2
select * 
into #working2
from #working where la_code_3 <> 'ALL'
and gender = 'ALL' and cohort_19_in = '2021'

select cohort_19_in, number_in_ss_cohort, region, la_code_9, la_code_3, la_name, fsm, sen,
'l2' as category,
l2_by19_rate as value
from #working2
union all
select cohort_19_in, number_in_ss_cohort, region, la_code_9, la_code_3, la_name, fsm, sen,
'l3' as category,
l3_by19_rate as value
from #working2
union all 
select cohort_19_in, number_in_ss_cohort, region, la_code_9, la_code_3, la_name, fsm, sen,
'l2em' as category,
l2_with_em_by19_rate as value
from #working2

