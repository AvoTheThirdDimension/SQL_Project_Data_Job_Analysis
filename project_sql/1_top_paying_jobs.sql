/* 1st Iteration */
SELECT 
   job_title,
   job_location,
   job_schedule_type,
   job_work_from_home,
   COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) AS salary_annual
FROM    
    job_postings_fact 
WHERE job_title_short = 'Data Analyst' 
AND job_work_from_home = True AND COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) IS NOT NULL
ORDER BY salary_annual DESC
LIMIT 10
 
/* 2nd Iteration */

SELECT 
   job_postings.job_title,
   job_postings.job_location,
   cdim.name AS company_name,
   job_postings.job_schedule_type,
   job_postings.job_work_from_home,
   COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) AS salary_annual
FROM    
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS cdim ON job_postings.company_id = cdim.company_id
WHERE job_title_short = 'Data Analyst' 
AND job_work_from_home = True AND COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) IS NOT NULL
ORDER BY salary_annual DESC
LIMIT 10

/*
*Question: What are the highest paying data analyst jobs?
-Identify the top 10 highest paying Data Analyst roles that are available remotely.
-Focuses on job postings with specified
*/