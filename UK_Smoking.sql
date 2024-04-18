--- Q.How does smoking behavior vary between genders in the dataset?

select 
      smoker.gender, 
      smoker.smokers,
      non_smoker.non_smokers
from
      (select gender, count(smoke) as smokers
      from smoking
      where smoke like 'yes'
      group by gender) as smoker
join
      (select gender, count(smoke) as non_smokers
      from smoking
      where smoke like 'no'
      group by gender) as non_smoker
on smoker.gender = non_smoker.gender;

------------------------------------------------------------------------
--- Q. Is there a correlation between marital status and smoking habits? 

select 
     marital_status,
     sum(case when smoke = 'yes' then 1 else 0 end ) as smoker,
     sum(case when smoke = 'no' then 1 else 0 end) as non_smoker
from 
     smoking
group by marital_status;

----------------------------------------------------------------------------
--- Q.Does the highest level of qualification influence smoking habits? 
/* The COALESCE function in SQL is a standard SQL function 
used to return the first non-null value in a list of arguments*/

select 
    coalesce(smoker.highest_qualification) as highest_qualification,
    coalesce(smoker.smokers) as smokers,
    coalesce(non_smoker.non_smokers) as non_smokers
from
	 (select highest_qualification,count(smoke) as smokers
	 from smoking
	 where smoke like 'yes'
     group by highest_qualification) as smoker
join
    (select highest_qualification, count(smoke) as non_smokers
    from smoking
    where smoke = 'no'
    group by highest_qualification) as non_smoker
on smoker.highest_qualification = non_smoker.highest_qualification;

-------------------------------------------------------------------------------------
--- Q.What are the different types of smoking products used among the participants? 
--- Q.For the subset of data where amount smoked on weekends and weekdays is recorded

select 
     type, 
     smoke,count(amt_weekdays) as amt_weekdays,
     count(amt_weekdays) as amt_weekends
from 
     smoking
where smoke = 'yes'
group by type;

----------------------------------------------------------------------------------
/*Q.How does income level affect smoking habits? Is there a trend in smoking frequency
 based on whether someone earns more or less money?*/
 
select
     gross_income, 
     sum(case when smoke = 'yes' then 1 else 0 end) as smoker,
     sum(case when smoke = 'no' then 1 else 0 end) as non_smoker
from 
     smoking
group by gross_income;

----------------------------------------------------------------------------
--- Q.Are there any trends in smoking habits among different nationalities ?

select 
      smoker.nationality, 
      smoker.smokers, 
      non_smoker.non_smokers
from
      (select nationality, count(smoke) as smokers
      from smoking
      where smoke like 'yes'
      group by nationality) as smoker
left join       
      (select nationality, count(smoke) as non_smokers
      from smoking
      where smoke like 'no'
      group by nationality) as non_smoker
on smoker.nationality = non_smoker.nationality;

----------------------------------------------------------------------------
--- Q.Does the region of residence influence smoking habits?

select 
    coalesce(smokers.region) as region,
    coalesce(smokers.smoker) as smoker,
    coalesce(non_smokers.non_smoker) as non_smoker
from 
    (select region , count(smoke) as smoker
    from smoking
	where smoke like 'yes'
    group by region) as smokers
join
    (select region, count(smoke) as non_smoker
    from smoking
    where smoke like 'no'
    group by region) as non_smokers
on smokers.region = non_smokers.region;

------------------------------------------------------------------------------
--- Q.Is there a significant difference in smoking habits across different age groups?

SELECT
    CASE 
        WHEN age BETWEEN 0 AND 14 THEN 'Children (00-14 years)'
        WHEN age BETWEEN 15 AND 24 THEN 'Youth (15-24 years)'
        WHEN age BETWEEN 25 AND 64 THEN 'Adults (25-64 years)'
        WHEN age >= 65 THEN 'Seniors (65 years and over)'
        ELSE 'Unknown Age Group'
    END AS age_group,
    SUM(CASE WHEN smoke = 'yes' THEN 1 ELSE 0 END) AS smoker,
    SUM(CASE WHEN smoke = 'no' THEN 1 ELSE 0 END) AS non_smoker
FROM smoking
GROUP BY age_group;

----------------------------------------------------------------------------------
