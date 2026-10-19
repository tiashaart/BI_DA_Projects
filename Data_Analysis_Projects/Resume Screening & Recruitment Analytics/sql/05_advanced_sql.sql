-- 1: Create hiring labels
SELECT
    candidate_id,
    hired,
    CASE
        WHEN hired = 1 THEN 'Hired'
        WHEN hired = 0 THEN 'Not Hired'
        ELSE 'Unknown'
    END AS hiring_status
FROM candidates
LIMIT 20;

-- 2: Create CGPA categories
SELECT
    candidate_id,
    cgpa,
    CASE
        WHEN cgpa < 6 THEN 'Below 6'
        WHEN cgpa < 7 THEN '6 to less than 7'
        WHEN cgpa < 8 THEN '7 to less than 8'
        WHEN cgpa < 9 THEN '8 to less than 9'
        ELSE '9 or above'
    END AS cgpa_group
FROM candidates
LIMIT 50;

-- 3: Create a candidate profile category
SELECT
    candidate_id,
    cgpa,
    skills_score,
    experience_years,

    CASE
        WHEN cgpa >= 8
         AND skills_score >= 20
         AND experience_years >= 2
            THEN 'Meets Example Criteria'

        WHEN cgpa >= 7
         AND skills_score >= 15
            THEN 'Partially Meets Example Criteria'

        ELSE 'Does Not Meet Example Criteria'
    END AS profile_category

FROM candidates;

-- 4: Your first CTE
WITH candidate_summary AS (
    SELECT
        education_level,
        COUNT(*) AS candidate_count,
        ROUND(AVG(cgpa), 2) AS average_cgpa
    FROM candidates
    GROUP BY education_level
)

-- 5: Calculate hiring rates using a CTE
WITH education_hiring AS (
    SELECT
        education_level,
        COUNT(*) AS candidate_count,
        SUM(CASE WHEN hired = 1 THEN 1 ELSE 0 END) AS hired_count,
        AVG(hired) AS hiring_rate
    FROM candidates
    GROUP BY education_level
)

SELECT
    education_level,
    candidate_count,
    hired_count,
    ROUND(hiring_rate * 100, 2) AS hiring_rate_percentage
FROM education_hiring
ORDER BY hiring_rate DESC;

-- 6: Find education groups with above-average hiring rates
WITH education_hiring AS (
    SELECT
        education_level,
        COUNT(*) AS candidate_count,
        AVG(hired) AS hiring_rate
    FROM candidates
    GROUP BY education_level
),

overall_hiring AS (
    SELECT AVG(hired) AS overall_rate
    FROM candidates
)

SELECT
    e.education_level,
    e.candidate_count,
    ROUND(e.hiring_rate * 100, 2) AS group_hiring_rate,
    ROUND(o.overall_rate * 100, 2) AS overall_hiring_rate
FROM education_hiring e
CROSS JOIN overall_hiring o
WHERE e.hiring_rate > o.overall_rate
ORDER BY e.hiring_rate DESC;

-- 7: Candidates whose CGPA is above the overall average
SELECT
    candidate_id,
    cgpa,
    education_level
FROM candidates
WHERE cgpa > (
    SELECT AVG(cgpa)
    FROM candidates
)
ORDER BY cgpa DESC
LIMIT 100;

-- 8: Candidates whose skills score is above average
SELECT
    candidate_id,
    skills_score,
    hired
FROM candidates
WHERE skills_score > (
    SELECT AVG(skills_score)
    FROM candidates
)
LIMIT 100;

-- 9: Education categories with above-average candidate counts
SELECT
    education_level,
    COUNT(*) AS candidate_count
FROM candidates
GROUP BY education_level
HAVING COUNT(*) > (
    SELECT AVG(group_count)
    FROM (
        SELECT COUNT(*) AS group_count
        FROM candidates
        GROUP BY education_level
    ) AS education_counts
)
ORDER BY candidate_count DESC;