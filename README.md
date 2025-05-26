# 📊 Top Paying Data Analyst Jobs & Skill Demand Analysis

## Introduction
This project was completed as part of a SQL course, intended to build and refine practical data querying skills. 

The objective of this analysis was to explore job market data related to Data Analyst roles, identifying top-paying positions and the most in-demand and optimal technical skills associated with those jobs.

Here's the SQL queries used in for this analysis: [project_sql](/project_sql/)


## 🧠 Background & Objective
In the evolving tech job market, understanding which skills offer the highest return in terms of salary and demand can guide learners and professionals in their upskilling journey. 

This analysis uses real-world datasets to simulate decision-making tasks that a data analyst or business intelligence professional might encounter.

The dataset was given as apart of the SQL Course By Luke Barrousse.

The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?

2. What skills are required for these top-paying jobs?

3. What skills are most in demand for data analysts?

4. Which skills are associated with higher salaries?

5. What are the most optimal skills to learn?

## 🧱 Data Structure Overview
The project uses a relational schema that mimics industry-standard databases. Some of the taables used include:

```job_postings_fact```: Core job listing data

```company_dim```: Company metadata

```skills_job_dim```: Skill-job relationships

```skills_dim```: Skill details and categories

## The Analysis
- Data Analyst roles offering remote work and high compensation are relatively rare.

- SQL, Python, and Tableau are among the most frequently requested and well-paid skills.

- A small cluster of companies consistently offers top-tier salaries.

- Optimal skills were identified using a combination of average salary and demand frequency.

Each query for this project aimed aHere’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
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
```

Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Jobs Roles](csv_files/assets/1_top_paying_roles.png)
**Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results**

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
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
```

![Top Paying Jobs Roles](csv_files/assets/2_top_paying_roles_skills.png)
**Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results**

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- SQL is leading with a bold count of 8.
- Python follows closely with a bold count of 7.
- Tableau is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
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
```
#### 📊 Top 5 In-Demand Data Analyst Skills
Here's the breakdown of the most demanded skills for data analysts in 2023

- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.

- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skill     | Demand Count   |
|-----------|----------------|
| SQL       |   7,291        |
| Excel     |   4,611        |
| Python    |   4,330        |
| Tableau   |   3,745        |
| Power BI  |   2,609        |

**Table of the demand for the top 5 skills in data analyst job postings**

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
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
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.

- Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.

- Cloud Computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

### 💰 Top 10 Highest Paying Skills for Data Analysts

| Skill         | Average Salary ($) |
|---------------|--------------------|
| PySpark       | 208,172            |
| Bitbucket     | 189,155            |
| Couchbase     | 160,515            |
| Watson        | 160,515            |
| DataRobot     | 155,486            |
| GitLab        | 154,500            |
| Swift         | 153,750            |
| Jupyter       | 152,777            |
| Pandas        | 151,821            |
| Elasticsearch | 145,000            |

**Table of the average salary for the top 10 paying skills for data analysts**

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```

**Table of the most optimal skills for data analyst sorted by salary**

### 💰 Top 10 Highest Paying Skills for Data Analysts

| Skill         | Average Salary ($) |
|---------------|--------------------|
| PySpark       | 208,172            |
| Bitbucket     | 189,155            |
| Couchbase     | 160,515            |
| Watson        | 160,515            |
| DataRobot     | 155,486            |
| GitLab        | 154,500            |
| Swift         | 153,750            |
| Jupyter       | 152,777            |
| Pandas        | 151,821            |
| Elasticsearch | 145,000            |


Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- High-Demand Programming Languages: Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.

- Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.

- Business Intelligence and Visualization Tools: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.

- Database Technologies: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

## ✅ Recommendations
After further analysis I was able to deduce some readily facts gained from the dataset for aspiring data professionals:

- Prioritize SQL, Python, Tableau, and Excel proficiency.

- Focus on skills consistently associated with top-paying jobs.

- Practice cross-table joins, CTEs, and data transformation techniques to prepare for real-world BI and analytics tasks.

## ⚠️ Caveats & Assumptions
- The highest paying remote Data Analyst job in the dataset 
offered up to $650,000 annually.
- Advanced SQL was consistently associated with the highest-paying roles.

- SQL also appeared as the most in-demand skill across postings.
-- - Niche technologies such as SVN and Solidity were linked with the highest average salaries, emphasizing their market rarity.
-- - SQL emerged as both high in demand and strong in salary potential, making it the most optimal skill to master.

- Salary fields were sometimes null or inconsistently reported, which may have excluded valid postings.

- Hourly to yearly salary conversion used a standard 40hr/week * 52 weeks formula, which may not reflect real conditions.

- Skills were self-reported in postings and may not cover soft or implicit skill requirements.

- Some rare but high-paying skill mentions (e.g., SVN, Solidity) may be influenced by a small number of job listings. 

- Notability these would be considered outliers but the sheer number of skills that an unviable recoccurence should be exluded to keep the volume and salaru expectation as geniune to the information be sought.

- As a student, this project has served to bridge theoretical SQL concepts with practical, real-world data analysis scenarios commonly encountered in data roles such as data analyst, data engineer, and business intelligence analyst.
