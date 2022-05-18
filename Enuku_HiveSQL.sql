-- Databricks notebook source
drop table clinicaltrial

-- COMMAND ----------

select*
from clinicaltrial

-- COMMAND ----------

-- DBTITLE 1,1. Number of Studies
select count(*) as Number_of_trials
from ClinicalTrial

-- COMMAND ----------

-- DBTITLE 1,2. Types of Studies
select Type, count(type) as Frequency
from ClinicalTrial
group by Type
order by FREQUENCY desc

-- COMMAND ----------

-- DBTITLE 1,3. Top 5 Conditions
SELECT Highestcond, count(*) as Amount
FROM (select  conditions,explode(split(conditions,","))as HighestCond from clinicaltrial
where conditions is not null)
group by Highestcond
order by Amount desc
limit 5

-- COMMAND ----------

-- DBTITLE 1,4. 5 most frequent roots
Select roots, count(*) as Amount
From (select * From(Select term,substring(tree,1,3)as roots From mesh))a
join (select test From(select conditions,explode(split(conditions,","))as test
From clinicaltrial))b on (a.term=b.test)
group by roots
order by 2 desc
limit 5

-- COMMAND ----------

-- DBTITLE 1,5. 10 most popular sponsors who are not Pharmaceutical companies.
select c.sponsor,count(*) as Amount from clinicaltrial c left anti join pharma p
on (c.sponsor=p.parent_company) group by c.sponsor order by Amount desc limit 10

-- COMMAND ----------

-- DBTITLE 1,Number of completed studies each month in 2021
select Submission,count(*) as Amount
from clinicaltrial where status like 'Completed' and submission like '%2021'
group by submission order By
  case when submission like 'Jan%' then 1
      when submission like 'Feb%' then 2
      when submission like 'Mar%' then 3
      when submission like 'Apr%' then 4
      when submission like 'May%' then 5
      when submission like 'Jun%' then 6
      when submission like 'Jul%' then 7
      when submission like 'Aug%' then 8
      when submission like 'Sep%' then 9
      when submission like 'Oct%' then 10
      when submission like 'Nov%' then 11
      when submission like 'Dec%' then 12 End asc

-- COMMAND ----------


