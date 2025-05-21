WITH company_job_count AS (
    SELECT 
            company_id,
            COUNT(*) AS total_jobs
    FROM 
            job_postings_fact
    GROUP BY
            company_id
)
SELECT company_dim.name As company_name,
company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id


SELECT 
    c.name AS name_of_company,
    posting_counts.job_postings_count,

    CASE
        WHEN posting_counts.job_postings_count >= 50 THEN 'High'
        WHEN posting_counts.job_postings_count >= 10 THEN 'Medium'
        Else 'Low'
    END AS posting_volume 

FROM (
        SELECT company_id,
               COUNT(*) AS job_postings_count
        FROM job_postings_fact
        GROUP BY company_id
) AS posting_counts

LEFT JOIN company_dim AS c ON posting_counts.company_id = c.company_id
ORDER BY job_postings_count DESC;

-- Classify companies based on number of job postings
SELECT 
    cd.name AS company_name,
    posting_counts.job_posting_count,
    
    -- Classify posting volume
    CASE 
        WHEN posting_counts.job_posting_count >= 50 THEN 'High'
        WHEN posting_counts.job_posting_count >= 10 THEN 'Medium'
        ELSE 'Low'
    END AS posting_volume

FROM (
    -- Subquery: Count job postings per company
    SELECT company_id, COUNT(*) AS job_posting_count
    FROM job_postings_fact
    GROUP BY company_id
) AS posting_counts

-- Join with company_dim to get company names
JOIN company_dim AS cd ON posting_counts.company_id = cd.company_id
ORDER BY job_posting_count DESC

WITH company_posting_volume AS (
    -- Your full query with CASE
    SELECT 
        c.name AS company_name,
        posting_counts.job_postings_count,
        CASE 
            WHEN posting_counts.job_postings_count >= 50 THEN 'High'
            WHEN posting_counts.job_postings_count >= 10 THEN 'Medium'
            ELSE 'Low'
        END AS posting_volume
    FROM (
        SELECT company_id, COUNT(*) AS job_postings_count
        FROM job_postings_fact
        GROUP BY company_id
    ) AS posting_counts
    LEFT JOIN company_dim AS c ON posting_counts.company_id = c.company_id
)

-- Now you can filter using WHERE!
SELECT *
FROM company_posting_volume
WHERE posting_volume = 'High'
ORDER BY job_postings_count DESC;

WITH remote_job_skills AS(
SELECT 
    skills_to_job.skill_id,
    COUNT(*) AS skills_count
FROM
    skills_job_dim AS skills_to_job 
JOIN job_postings_fact AS job_posting ON job_posting.job_id = skills_to_job.job_id

WHERE job_posting.job_work_from_home = 'True' AND
      job_title_short = 'Data Analyst'
GROUP BY skills_to_job.skill_id
)

SELECT 
    remote_job_skills.skill_id,
    skills_count,
    skills.skills AS skill_name
FROM remote_job_skills
JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skills_count DESC
LIMIT 5;

/*SQL COURSE - Learning Unions */

SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_2023_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
FROM february_2023_jobs

UNION ALL

 SELECT 
    job_title_short,
    company_id,
    job_location
FROm march_2023_jobs

/* get the corresponding skill and skill type for each job posting in Q1
Include those without any skills
Salary Limit Cap is $70,000 */

SELECT 
    job_title_short,
    sdim.skills,
    cdim.name,
    job_postings.salary_hour_avg * 40 * 52,
    COALESCE(job_postings.salary_year_avg, job_postings.salary_hour_avg * 40 * 52) AS annual_salary,
    EXTRACT(MONTH FROM job_postings.job_posted_date) BETWEEN 1 AND 3 AS extracted_month 
FROM 
    job_postings_fact AS job_postings
LEFT JOIN 
    skills_job_dim AS sjb ON job_postings.job_id = sjb.job_id
LEFT JOIN 
    skills_dim AS sdim ON sjb.skill_id = sdim.skill_id
JOIN 
    company_dim AS cdim ON job_postings.company_id = cdim.company_id
WHERE
    EXTRACT(MONTH FROM job_posted_date) BETWEEN 1 AND 3
    AND COALESCE(job_postings.salary_year_avg, job_postings.salary_hour_avg * 40 * 52) > 70000
ORDER BY
    extracted_month
/*CHATGPT Solution for Practice Problem */

SELECT 
    job_postings.job_title_short,
    sdim.skills,
    sdim.skill_id,
    cdim.name AS company_name,
    COALESCE(job_postings.salary_year_avg, job_postings.salary_hour_avg * 40 * 52) AS annual_salary,
    EXTRACT(MONTH FROM job_postings.job_posted_date) AS extracted_month
FROM 
    job_postings_fact AS job_postings
LEFT JOIN 
    skills_job_dim AS sjb ON job_postings.job_id = sjb.job_id
LEFT JOIN 
    skills_dim AS sdim ON sjb.skill_id = sdim.skill_id
JOIN 
    company_dim AS cdim ON job_postings.company_id = cdim.company_id
WHERE
    EXTRACT(MONTH FROM job_postings.job_posted_date) BETWEEN 1 AND 3
    AND COALESCE(job_postings.salary_year_avg, job_postings.salary_hour_avg * 40 * 52) > 70000
ORDER BY 
    extracted_month;



