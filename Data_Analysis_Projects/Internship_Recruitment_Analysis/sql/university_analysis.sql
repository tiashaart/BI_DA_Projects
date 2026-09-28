-- university_analysis
SELECT

    c.university,

    COUNT(DISTINCT a.application_id)
        AS applications,

    COUNT(DISTINCT CASE
        WHEN o.offer_status = 'Accepted'
        THEN o.offer_id
    END)
        AS accepted,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN o.offer_status = 'Accepted'
            THEN o.offer_id
        END)
        /
        NULLIF(
            COUNT(DISTINCT a.application_id),
            0
        ),
        2
    ) AS acceptance_rate

FROM candidates c

JOIN applications a
    ON c.candidate_id = a.candidate_id

LEFT JOIN offers o
    ON a.application_id = o.application_id

GROUP BY c.university

ORDER BY acceptance_rate DESC;

-- University ranking
WITH university_stats AS (

    SELECT

        c.university,

        COUNT(DISTINCT a.application_id)
            AS applications,

        COUNT(DISTINCT CASE
            WHEN o.offer_status = 'Accepted'
            THEN o.offer_id
        END)
            AS accepted

    FROM candidates c

    JOIN applications a
        ON c.candidate_id = a.candidate_id

    LEFT JOIN offers o
        ON a.application_id = o.application_id

    GROUP BY c.university
)

SELECT

    university,
    applications,
    accepted,

    ROUND(
        100.0 * accepted /
        NULLIF(applications, 0),
        2
    ) AS acceptance_rate,

    RANK() OVER (
        ORDER BY accepted DESC
    ) AS university_rank

FROM university_stats

ORDER BY university_rank;

-- Department analysis

SELECT

    d.department_name,

    COUNT(DISTINCT a.application_id)
        AS applications,

    COUNT(DISTINCT o.offer_id)
        AS offers,

    COUNT(DISTINCT CASE
        WHEN o.offer_status = 'Accepted'
        THEN o.offer_id
    END)
        AS accepted,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN o.offer_status = 'Accepted'
            THEN o.offer_id
        END)
        /
        NULLIF(
            COUNT(DISTINCT a.application_id),
            0
        ),
        2
    ) AS acceptance_rate

FROM departments d

JOIN applications a
    ON d.department_id = a.department_id

LEFT JOIN offers o
    ON a.application_id = o.application_id

GROUP BY d.department_name

ORDER BY acceptance_rate DESC;


-- Recruitment source analysis
SELECT

    c.source,

    COUNT(DISTINCT c.candidate_id)
        AS candidates,

    COUNT(DISTINCT a.application_id)
        AS applications,

    COUNT(DISTINCT o.offer_id)
        AS offers,

    COUNT(DISTINCT CASE
        WHEN o.offer_status = 'Accepted'
        THEN o.offer_id
    END)
        AS accepted,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN o.offer_status = 'Accepted'
            THEN o.offer_id
        END)
        /
        NULLIF(
            COUNT(DISTINCT a.application_id),
            0
        ),
        2
    ) AS acceptance_rate

FROM candidates c

LEFT JOIN applications a
    ON c.candidate_id = a.candidate_id

LEFT JOIN offers o
    ON a.application_id = o.application_id

GROUP BY c.source

ORDER BY acceptance_rate DESC;

-- Assessment analysis
-- Average score
SELECT
    ROUND(
        AVG(assessment_score),
        2
    ) AS average_assessment_score
FROM assessments;

-- Pass rate
SELECT

    ROUND(
        100.0 *
        COUNT(
            CASE
                WHEN assessment_status = 'Passed'
                THEN 1
            END
        )
        /
        COUNT(*),
        2
    ) AS assessment_pass_rate

FROM assessments;

-- Score groups
SELECT

    CASE
        WHEN assessment_score >= 80
            THEN 'Excellent'

        WHEN assessment_score >= 60
            THEN 'Pass'

        ELSE 'Fail'
    END AS performance_group,

    COUNT(*) AS candidates

FROM assessments

GROUP BY performance_group

ORDER BY candidates DESC;

-- Interview analysis
SELECT

    interview_round,

    COUNT(*) AS interviews,

    ROUND(
        AVG(technical_score),
        2
    ) AS avg_technical_score,

    ROUND(
        AVG(communication_score),
        2
    ) AS avg_communication_score,

    ROUND(
        AVG(overall_score),
        2
    ) AS avg_overall_score

FROM interviews

GROUP BY interview_round

ORDER BY interview_round;

-- Time to offer
SELECT

    a.application_id,

    a.application_date,

    o.offer_date,

    (
        o.offer_date -
        a.application_date
    ) AS days_to_offer

FROM applications a

JOIN offers o
    ON a.application_id = o.application_id

ORDER BY days_to_offer DESC;

-- Average
SELECT

    ROUND(
        AVG(
            o.offer_date -
            a.application_date
        ),
        2
    ) AS average_days_to_offer

FROM applications a

JOIN offers o
    ON a.application_id = o.application_id;

-- Time to offer by department
SELECT

    d.department_name,

    ROUND(
        AVG(
            o.offer_date -
            a.application_date
        ),
        2
    ) AS average_days_to_offer

FROM applications a

JOIN departments d
    ON a.department_id = d.department_id

JOIN offers o
    ON a.application_id = o.application_id

GROUP BY d.department_name

ORDER BY average_days_to_offer DESC;

-- Monthly applications
SELECT

    DATE_TRUNC(
        'month',
        application_date
    ) AS month,

    COUNT(*) AS applications

FROM applications

GROUP BY month

ORDER BY month;

-- Monthly application growth
WITH monthly AS (

    SELECT

        DATE_TRUNC(
            'month',
            application_date
        ) AS month,

        COUNT(*) AS applications

    FROM applications

    GROUP BY month
)

SELECT

    month,

    applications,

    LAG(applications)
        OVER (
            ORDER BY month
        ) AS previous_month,

    ROUND(
        100.0 *
        (
            applications -
            LAG(applications)
            OVER (
                ORDER BY month
            )
        )
        /
        NULLIF(
            LAG(applications)
            OVER (
                ORDER BY month
            ),
            0
        ),
        2
    ) AS growth_percentage

FROM monthly

ORDER BY month;

-- Top candidates
WITH candidate_scores AS (

    SELECT

        a.application_id,

        c.candidate_name,

        c.university,

        c.degree,

        ass.assessment_score,

        i.overall_score,

        ROUND(
            (
                ass.assessment_score * 0.4
                +
                i.overall_score * 0.6
            ),
            2
        ) AS final_score

    FROM applications a

    JOIN candidates c
        ON a.candidate_id = c.candidate_id

    JOIN assessments ass
        ON a.application_id = ass.application_id

    JOIN interviews i
        ON a.application_id = i.application_id

    WHERE i.interview_round = 'Final'
)

SELECT

    *,

    RANK() OVER (
        ORDER BY final_score DESC
    ) AS candidate_rank

FROM candidate_scores

ORDER BY candidate_rank;

-- Create an analysis view
CREATE OR REPLACE VIEW recruitment_analysis AS

SELECT

    c.candidate_id,
    c.candidate_name,
    c.gender,
    c.age,
    c.university,
    c.degree,
    c.graduation_year,
    c.location,
    c.source,

    a.application_id,
    a.application_date,
    a.status AS application_status,

    d.department_name,

    ass.assessment_date,
    ass.assessment_score,
    ass.assessment_status,

    i.interview_date,
    i.interview_round,
    i.technical_score,
    i.communication_score,
    i.overall_score,
    i.interview_status,

    o.offer_date,
    o.stipend,
    o.offer_status,
    o.joining_date

FROM candidates c

JOIN applications a
    ON c.candidate_id = a.candidate_id

JOIN departments d
    ON a.department_id = d.department_id

LEFT JOIN assessments ass
    ON a.application_id = ass.application_id

LEFT JOIN interviews i
    ON a.application_id = i.application_id

LEFT JOIN offers o
    ON a.application_id = o.application_id;

--
SELECT *
FROM recruitment_analysis
LIMIT 20;

