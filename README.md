# 📊 Top Paying Data Analyst Jobs & Skill Demand Analysis

## Introduction
This project was completed as part of a SQL course, intended to build and refine practical data querying skills. 

The objective of this analysis was to explore job market data related to Data Analyst roles, identifying top-paying positions and the most in-demand and optimal technical skills associated with those jobs.

Here's the SQL queries used in for this analysis: [project_sql folder](/project_sql/)


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
