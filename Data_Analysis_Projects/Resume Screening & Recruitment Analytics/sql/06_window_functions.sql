-- 1: Show the overall average CGPA beside each candidate
SELECT
    candidate_id,
    cgpa,
    ROUND(
        AVG(cgpa) OVER (),
        2
    ) AS overall_average_cgpa
FROM candidates
LIMIT 20;

-- 2: Rank candidates by skills score
SELECT
    candidate_id,
    skills_score,
    RANK() OVER (
        ORDER BY skills_score DESC
    ) AS skills_rank
FROM candidates
ORDER BY skills_rank
LIMIT 50;


-- Task 3: Compare RANK, DENSE_RANK and ROW_NUMBER
SELECT
    candidate_id,
    skills_score,

    RANK() OVER (
        ORDER BY skills_score DESC
    ) AS rank_value,

    DENSE_RANK() OVER (
        ORDER BY skills_score DESC
    ) AS dense_rank_value,

    ROW_NUMBER() OVER (
        ORDER BY skills_score DESC, candidate_id
    ) AS row_number_value

FROM candidates
ORDER BY skills_score DESC, candidate_id
LIMIT 50;

-- 4: Rank education categories by hiring rate
WITH education_hiring AS (
    SELECT
        education_level,
        COUNT(*) AS candidate_count,
        AVG(hired) AS hiring_rate
    FROM candidates
    GROUP BY education_level
)

SELECT
    education_level,
    candidate_count,
    ROUND(hiring_rate * 100, 2) AS hiring_rate_percentage,

    RANK() OVER (
        ORDER BY hiring_rate DESC
    ) AS hiring_rate_rank

FROM education_hiring
ORDER BY hiring_rate_rank;

-- 5: Rank company categories by hiring rate
WITH company_hiring AS (
    SELECT
        company_type,
        COUNT(*) AS candidate_count,
        AVG(hired) AS hiring_rate
    FROM candidates
    GROUP BY company_type
)

SELECT
    company_type,
    candidate_count,
    ROUND(hiring_rate * 100, 2) AS hiring_rate_percentage,

    DENSE_RANK() OVER (
        ORDER BY hiring_rate DESC
    ) AS company_rank

FROM company_hiring
ORDER BY company_rank;

-- 6: Rank candidates within education groups
SELECT
    candidate_id,
    education_level,
    skills_score,

    RANK() OVER (
        PARTITION BY education_level
        ORDER BY skills_score DESC
    ) AS rank_within_education

FROM candidates
ORDER BY education_level, rank_within_education
LIMIT 100;

-- 7: Top five candidates in each education group
WITH ranked_candidates AS (
    SELECT
        candidate_id,
        education_level,
        cgpa,
        skills_score,
        hired,

        ROW_NUMBER() OVER (
            PARTITION BY education_level
            ORDER BY skills_score DESC, cgpa DESC, candidate_id
        ) AS candidate_rank

    FROM candidates
)

SELECT *
FROM ranked_candidates
WHERE candidate_rank <= 5
ORDER BY education_level, candidate_rank;

-- 8: Compare each candidate's skills score with their group's average
SELECT
    candidate_id,
    education_level,
    skills_score,

    ROUND(
        AVG(skills_score) OVER (
            PARTITION BY education_level
        ),
        2
    ) AS education_average_skills

FROM candidates
LIMIT 100;