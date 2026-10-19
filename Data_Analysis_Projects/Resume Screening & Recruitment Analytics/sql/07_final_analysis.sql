-- Query 1: Overall recruitment summary
SELECT
    COUNT(*) AS total_candidates,

    SUM(
        CASE WHEN hired = 1 THEN 1 ELSE 0 END
    ) AS hired_candidates,

    SUM(
        CASE WHEN hired = 0 THEN 1 ELSE 0 END
    ) AS not_hired_candidates,

    ROUND(
        100.0 * AVG(hired),
        2
    ) AS overall_hiring_rate,

    ROUND(AVG(cgpa), 2) AS average_cgpa,

    ROUND(AVG(experience_years), 2) AS average_experience,

    ROUND(AVG(skills_score), 2) AS average_skills_score

FROM candidates;

-- 2: Education performance
SELECT
    education_level,
    COUNT(*) AS candidate_count,

    SUM(
        CASE WHEN hired = 1 THEN 1 ELSE 0 END
    ) AS hired_candidates,

    ROUND(
        100.0 * AVG(hired),
        2
    ) AS hiring_rate,

    ROUND(AVG(cgpa), 2) AS average_cgpa,

    ROUND(AVG(skills_score), 2) AS average_skills_score

FROM candidates

GROUP BY education_level

ORDER BY hiring_rate DESC;

-- 3: University tier analysis
SELECT
    university_tier,
    COUNT(*) AS candidate_count,
    ROUND(AVG(cgpa), 2) AS average_cgpa,
    ROUND(AVG(skills_score), 2) AS average_skills_score,
    ROUND(AVG(experience_years), 2) AS average_experience,
    ROUND(100.0 * AVG(hired), 2) AS hiring_rate

FROM candidates

GROUP BY university_tier

ORDER BY hiring_rate DESC;

-- 4: Candidate experience analysis
SELECT
    CASE
        WHEN experience_years < 1 THEN 'Less than 1 year'
        WHEN experience_years < 3 THEN '1 to less than 3 years'
        WHEN experience_years < 5 THEN '3 to less than 5 years'
        ELSE '5 or more years'
    END AS experience_group,

    COUNT(*) AS candidate_count,

    ROUND(
        AVG(experience_years),
        2
    ) AS average_experience,

    ROUND(
        100.0 * AVG(hired),
        2
    ) AS hiring_rate

FROM candidates

GROUP BY
    CASE
        WHEN experience_years < 1 THEN 'Less than 1 year'
        WHEN experience_years < 3 THEN '1 to less than 3 years'
        WHEN experience_years < 5 THEN '3 to less than 5 years'
        ELSE '5 or more years'
    END

ORDER BY MIN(experience_years);

-- 5: Skills and hiring analysis
SELECT
    CASE
        WHEN skills_score < 10 THEN 'Low'
        WHEN skills_score < 20 THEN 'Medium'
        WHEN skills_score < 30 THEN 'High'
        ELSE 'Very High'
    END AS skills_group,

    COUNT(*) AS candidate_count,

    ROUND(
        AVG(skills_score),
        2
    ) AS average_skills_score,

    ROUND(
        100.0 * AVG(hired),
        2
    ) AS hiring_rate

FROM candidates

GROUP BY
    CASE
        WHEN skills_score < 10 THEN 'Low'
        WHEN skills_score < 20 THEN 'Medium'
        WHEN skills_score < 30 THEN 'High'
        ELSE 'Very High'
    END

ORDER BY MIN(skills_score);

-- 6: Hired versus not-hired comparison
SELECT
    CASE
        WHEN hired = 1 THEN 'Hired'
        WHEN hired = 0 THEN 'Not Hired'
        ELSE 'Unknown'
    END AS hiring_status,

    COUNT(*) AS candidate_count,

    ROUND(AVG(cgpa), 2) AS average_cgpa,

    ROUND(AVG(experience_years), 2) AS average_experience,

    ROUND(AVG(internships), 2) AS average_internships,

    ROUND(AVG(projects), 2) AS average_projects,

    ROUND(AVG(certifications), 2) AS average_certifications,

    ROUND(AVG(skills_score), 2) AS average_skills_score,

    ROUND(AVG(soft_skills_score), 2) AS average_soft_skills_score

FROM candidates

GROUP BY hired

ORDER BY hired DESC;


