
-- Task 1: Compare hired and not-hired candidates
SELECT
    hired,
    COUNT(*) AS candidate_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM candidates
GROUP BY hired
ORDER BY hired DESC;

-- 2: Compare candidate characteristics
SELECT
    hired,
    COUNT(*) AS candidate_count,
    ROUND(AVG(cgpa), 2) AS average_cgpa,
    ROUND(AVG(experience_years), 2) AS average_experience,
    ROUND(AVG(internships), 2) AS average_internships,
    ROUND(AVG(projects), 2) AS average_projects,
    ROUND(AVG(skills_score), 2) AS average_skills_score,
    ROUND(AVG(soft_skills_score), 2) AS average_soft_skills_score
FROM candidates
GROUP BY hired
ORDER BY hired DESC;

-- 3: Hiring rate by internship count
SELECT
    internships,
    COUNT(*) AS candidate_count,
    SUM(CASE WHEN hired = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY internships
ORDER BY internships;

-- 4: Hiring rate by project count
SELECT
    projects,
    COUNT(*) AS candidate_count,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY projects
ORDER BY projects;

-- 5: Hiring rate by experience group

SELECT
    CASE
        WHEN experience_years < 1 THEN 'Less than 1 year'
        WHEN experience_years < 3 THEN '1 to less than 3 years'
        WHEN experience_years < 5 THEN '3 to less than 5 years'
        ELSE '5 or more years'
    END AS experience_group,

    COUNT(*) AS candidate_count,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage,

    CASE
        WHEN experience_years < 1 THEN 1
        WHEN experience_years < 3 THEN 2
        WHEN experience_years < 5 THEN 3
        ELSE 4
    END AS sort_order

FROM candidates
GROUP BY
    CASE
        WHEN experience_years < 1 THEN 'Less than 1 year'
        WHEN experience_years < 3 THEN '1 to less than 3 years'
        WHEN experience_years < 5 THEN '3 to less than 5 years'
        ELSE '5 or more years'
    END,
    CASE
        WHEN experience_years < 1 THEN 1
        WHEN experience_years < 3 THEN 2
        WHEN experience_years < 5 THEN 3
        ELSE 4
    END
ORDER BY sort_order;

-- 6: Hiring rate by skills group
SELECT
    CASE
        WHEN skills_score < 10 THEN 'Low'
        WHEN skills_score < 20 THEN 'Medium'
        WHEN skills_score < 30 THEN 'High'
        ELSE 'Very High'
    END AS skills_group,

    COUNT(*) AS candidate_count,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage

FROM candidates
GROUP BY
    CASE
        WHEN skills_score < 10 THEN 'Low'
        WHEN skills_score < 20 THEN 'Medium'
        WHEN skills_score < 30 THEN 'High'
        ELSE 'Very High'
    END
ORDER BY hiring_rate_percentage DESC;

-- 7: Hiring rate by certifications
SELECT
    certifications,
    COUNT(*) AS candidate_count,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY certifications
ORDER BY certifications;

-- 8: Hiring rate by hackathons
SELECT
    hackathons,
    COUNT(*) AS candidate_count,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY hackathons
ORDER BY hackathons;

-- 9: Hiring rate by company and education

SELECT
    company_type,
    education_level,
    COUNT(*) AS candidate_count,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate_percentage
FROM candidates
GROUP BY
    company_type,
    education_level
ORDER BY
    company_type,
    hiring_rate_percentage DESC;