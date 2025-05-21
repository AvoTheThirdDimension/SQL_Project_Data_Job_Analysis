/* Continuing on form the final iteration of query 1 we want the top 
job skills found within the jobs for the highest paying job postings */

WITH top_paying_jobs AS (
    SELECT 
    job_postings.job_title,
    cdim.name AS company_name,
    COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) AS salary_annual
    FROM    
        job_postings_fact AS job_postings
    LEFT JOIN company_dim AS cdim ON job_postings.company_id = cdim.company_id
    WHERE job_title_short = 'Data Analyst' 
    AND job_work_from_home = True AND COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) IS NOT NULL
    ORDER BY salary_annual DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills,
    COUNT(*) AS total_skill_count
FROM    
    job_postings_fact AS job_postings
JOIN skills_job_dim AS sdim ON job_postings.job_id = sdim.job_id
JOIN skills_dim ON sdim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
AND job_work_from_home = True AND COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) IS NOT NULL
GROUP BY skills_dim.skills 
ORDER BY total_skill_count DESC
LIMIT 10;

/* Ideation of the query */

WITH top_paying_jobs AS (
    SELECT 
    job_postings.job_title,
    job_postings.job_id,
    job_postings.job_work_from_home,
    job_postings.salary_hour_avg,
    job_postings.salary_year_avg,
    cdim.name AS company_name,
    COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) AS salary_annual
    FROM    
        job_postings_fact AS job_postings
    LEFT JOIN company_dim AS cdim ON job_postings.company_id = cdim.company_id
    WHERE job_title_short = 'Data Analyst' 
    AND job_work_from_home = True AND COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) IS NOT NULL
    ORDER BY salary_annual DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills,
    COUNT(*) AS total_skill_count
FROM    
    top_paying_jobs
JOIN skills_job_dim AS sdim ON top_paying_jobs.job_id = sdim.job_id
JOIN skills_dim ON sdim.skill_id = skills_dim.skill_id
WHERE top_paying_jobs.job_title_short = 'Data Analyst' 
AND top_paying_jobs.job_work_from_home = True AND COALESCE(top_paying_jobs.salary_year_avg, top_paying_jobs.salary_hour_avg * 40 * 52) IS NOT NULL
GROUP BY skills_dim.skills 
ORDER BY total_skill_count DESC
LIMIT 10;
