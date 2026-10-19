-- 1: Total candidates
SELECT COUNT(*) AS total_candidates
FROM candidates;

-- 2: Count hired candidates
SELECT COUNT(*) AS hired_candidates
FROM candidates
WHERE hired = 1;

-- 3: Count candidates not hired
SELECT COUNT(*) AS not_hired_candidates
FROM candidates
WHERE hired = 0;

-- 4: Count unique candidate IDs
SELECT COUNT(DISTINCT candidate_id) AS unique_candidates
FROM candidates;

-- 5: Average CGPA
SELECT ROUND(AVG(cgpa), 2) AS average_cgpa
FROM candidates;

-- 6: Average experience
SELECT ROUND(AVG(experience_years), 2) AS average_experience
FROM candidates;

-- 6.1 Average experience by education level
SELECT education_level, AVG(experience_years) AS avg_experience
FROM candidates
GROUP BY education_level;

-- 7: Highest and lowest skills scores
SELECT
    MIN(skills_score) AS minimum_skills_score,
    MAX(skills_score) AS maximum_skills_score
FROM candidates;

-- 8: Average projects per candidate
SELECT ROUND(AVG(projects), 2) AS average_projects
FROM candidates;

-- 9: Count candidates by education
SELECT
    education_level,
    COUNT(*) AS candidate_count
FROM candidates
GROUP BY education_level
ORDER BY candidate_count DESC;

-- 10: Count candidates by company type
SELECT
    company_type,
    COUNT(*) AS candidate_count
FROM candidates
GROUP BY company_type
ORDER BY candidate_count DESC;

-- 11: Average CGPA by education
SELECT
    education_level,
    ROUND(AVG(cgpa), 2) AS average_cgpa
FROM candidates
GROUP BY education_level
ORDER BY average_cgpa DESC;

-- 12: Average skills score by university tier
SELECT
    university_tier,
    ROUND(AVG(skills_score), 2) AS average_skills_score
FROM candidates
GROUP BY university_tier
ORDER BY average_skills_score DESC;

-- 13: Overall hiring rate
SELECT
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN hired = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        100.0 * AVG(hired),
        2
    ) AS hiring_rate_percentage
FROM candidates;

-- 14: Hiring rate by education
SELECT
    education_level,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN hired = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY education_level
ORDER BY hiring_rate_percentage DESC;

-- 15: Hiring rate by university tier
SELECT
    university_tier,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN hired = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY university_tier
ORDER BY hiring_rate_percentage DESC;

-- 16: Hiring rate by company type
SELECT
    company_type,
    COUNT(*) AS total_candidates,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY company_type
ORDER BY hiring_rate_percentage DESC;

-- 17: Education groups with at least 1,000 candidates
SELECT
    education_level,
    COUNT(*) AS candidate_count
FROM candidates
GROUP BY education_level
HAVING COUNT(*) >= 1000
ORDER BY candidate_count DESC;

-- 18: Company categories with hiring rates above 50%
SELECT
    company_type,
    COUNT(*) AS candidate_count,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY company_type
HAVING AVG(hired) > 0.50
ORDER BY hiring_rate_percentage DESC;

-- 19. Candidate count by company type
sql
SELECT company_type, COUNT(*) AS candidate_count
FROM candidates
GROUP BY company_type;
-- 20. Hiring rate by education level
sql
SELECT education_level,
       AVG(CASE WHEN hired = TRUE THEN 1 ELSE 0 END) AS hiring_rate
FROM candidates
GROUP BY education_level;
-- 21. Hiring rate by university tier
sql
SELECT university_tier,
       AVG(CASE WHEN hired = TRUE THEN 1 ELSE 0 END) AS hiring_rate
FROM candidates
GROUP BY university_tier;
-- 22. Hiring rate by internship count
sql
SELECT internships,
       AVG(CASE WHEN hired = TRUE THEN 1 ELSE 0 END) AS hiring_rate
FROM candidates
GROUP BY internships;
-- 23. Education groups with at least 500 candidates
sql
SELECT education_level, COUNT(*) AS candidate_count
FROM candidates
GROUP BY education_level
HAVING COUNT(*) >= 500;
-- 24. Company categories with more than 10,000 candidates
sql
SELECT company_type, COUNT(*) AS candidate_count
FROM candidates
GROUP BY company_type
HAVING COUNT(*) > 10000;