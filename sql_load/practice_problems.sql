CREATE TABLE january_2023_jobs
SELECT *     
FROM  job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1

/* Here’s the improved query for January, and then I'll provide versions for each month*/

-- Create a table for each month's job postings in 2023

-- January
CREATE TABLE january_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- February
CREATE TABLE february_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- March
CREATE TABLE march_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- April
CREATE TABLE april_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 4
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- May
CREATE TABLE may_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 5
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- June
CREATE TABLE june_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 6
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- July
CREATE TABLE july_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 7
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- August
CREATE TABLE august_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 8
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- September
CREATE TABLE september_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 9
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- October
CREATE TABLE october_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 10
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- November
CREATE TABLE november_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 11
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;

-- December
CREATE TABLE december_2023_jobs AS
SELECT * FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 12
  AND EXTRACT(YEAR FROM job_posted_date) = 2023
  AND job_posted_date IS NOT NULL;


SELECT job_posted_date
FROM march_2023_jobs

SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_catergory
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_catergory;


