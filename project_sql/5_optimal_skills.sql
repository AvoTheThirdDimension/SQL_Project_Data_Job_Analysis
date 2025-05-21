/*QUERY QUESTION #5 What is the optimal skills to learn for highest paying skill */

WITH skills_demand AS (
    SELECT 
        sd.skill_id,
        sd.skills,
        COUNT(sdim.job_id) AS demand_count
    FROM    
        job_postings_fact AS jp
    JOIN skills_job_dim AS sdim ON jp.job_id = sdim.job_id
    JOIN skills_dim AS sd ON sdim.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst' 
        AND jp.job_work_from_home = TRUE
        AND (jp.salary_year_avg IS NOT NULL OR jp.salary_hour_avg IS NOT NULL)
    GROUP BY 
        sd.skill_id, sd.skills
),
average_salary AS (
    SELECT 
        sd.skill_id,
        ROUND(AVG(COALESCE(jp.salary_year_avg, jp.salary_hour_avg * 40 * 52)), 0) AS avg_salary
    FROM    
        job_postings_fact AS jp
    JOIN skills_job_dim AS sdim ON jp.job_id = sdim.job_id
    JOIN skills_dim AS sd ON sdim.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst' 
        AND jp.job_work_from_home = TRUE
        AND (jp.salary_year_avg IS NOT NULL OR jp.salary_hour_avg IS NOT NULL)
    GROUP BY 
        sd.skill_id
)

SELECT 
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    asal.avg_salary
FROM 
    skills_demand AS sd
JOIN average_salary AS asal ON sd.skill_id = asal.skill_id
WHERE demand_count >= 10
ORDER BY 
    avg_salary DESC,
    sd.demand_count DESC

