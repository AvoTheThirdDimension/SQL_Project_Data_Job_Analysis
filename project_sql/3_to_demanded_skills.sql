WITH top_demand_skills AS (
    SELECT  
        skill_id,
        COUNT(*) AS skills_count
    FROM 
        job_postings_fact AS job_postings
    JOIN
        skills_job_dim AS sdim ON sdim.job_id = job_postings.job_id
    WHERE 
        job_postings.job_title_short = 'Data Analyst' 
        AND job_postings.job_work_from_home = TRUE
    GROUP BY 
        skill_id
)

SELECT 
    skills.skill_id,
    skills.skills,
    top_demand_skills.skills_count
FROM
    top_demand_skills
JOIN
    skills_dim AS skills ON skills.skill_id = top_demand_skills.skill_id
ORDER BY 
    skills_count DESC
LIMIT 5;


/*Shortening current top_demand_skills sql query*/

SELECT 
    skills,
    COUNT(sdim.job_id) AS demand_count
FROM    
    job_postings_fact AS job_postings
JOIN skills_job_dim AS sdim ON job_postings.job_id = sdim.job_id
JOIN skills_dim ON sdim.skill_id = skills_dim.skill_id
WHERE job_postings.job_title_short = 'Data Analyst' AND job_work_from_home IS TRUE
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5



