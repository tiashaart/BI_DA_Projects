-- Data Quality
-- Duplicates candidates

SELECT
    candidate_id,
    COUNT(*) AS duplicate_count
FROM candidates
GROUP BY candidate_id
HAVING COUNT(*) > 1;

-- Missing Values
SELECT
    COUNT(*) AS total_rows,
    COUNT(candidate_id) AS candidate_id_count,
    COUNT(university) AS university_count,
    COUNT(degree) AS degree_count,
    COUNT(source) AS source_count
FROM candidates;

-- Invalid ages
SELECT *
FROM candidates
WHERE age < 18
   OR age > 40;

-- Invalid Assessment Scores
SELECT *
FROM assessments
WHERE assessment_score < 0
   OR assessment_score > 100;

-- Invalid interview scores
SELECT *
FROM interviews
WHERE technical_score < 0
   OR technical_score > 100
   OR communication_score < 0
   OR communication_score > 100
   OR overall_score < 0
   OR overall_score > 100;