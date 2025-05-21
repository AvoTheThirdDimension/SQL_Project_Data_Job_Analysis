/*QUERY QUESTION #4 What are the top paying skills */

SELECT 
    skills,
    AVG(COALESCE(jp.salary_year_avg, jp.salary_hour_avg * 40 * 52) AS avg_salary
FROM    
    job_postings_fact AS jp
JOIN skills_job_dim AS sdim ON jp.job_id = sdim.job_id
JOIN skills_dim AS sd ON sdim.skill_id = sd.skill_id
WHERE 
    jp.job_title_short = 'Data Analyst' 
GROUP BY 
    skills
ORDER BY
    avg_salary 
LIMIT 25;

/*CHATGPT Inference with the written query above and improvement*/

 SELECT 
    skills,
    ROUND(AVG(COALESCE(jp.salary_year_avg, jp.salary_hour_avg * 40 * 52)),0) AS avg_salary
FROM    
    job_postings_fact AS jp
JOIN skills_job_dim AS sdim ON jp.job_id = sdim.job_id
JOIN skills_dim AS sd ON sdim.skill_id = sd.skill_id
WHERE 
    jp.job_title_short = 'Data Analyst' 
    AND (jp.salary_year_avg IS NOT NULL OR jp.salary_hour_avg IS NOT NULL)
    AND job_work_from_home IS TRUE
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
