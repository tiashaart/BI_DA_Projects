-- 1. Display all columns

SELECT *
FROM candidates
LIMIT 10;

-- Display selected coulmns
SELECT
    candidate_id,
    education_level,
    cgpa,
    skills_score,
    hired
FROM candidates
LIMIT 10;

-- 3: Retrieve candidate profiles
SELECT
    candidate_id,
    age,
    education_level,
    university_tier,
    experience_years
FROM candidates
LIMIT 20;

-- 4: Candidates with CGPA of at least 8
SELECT *
FROM candidates
WHERE cgpa >= 8
LIMIT 20;

-- 5: Candidates with experience of at least two years
SELECT
    candidate_id,
    experience_years,
    skills_score,
    hired
FROM candidates
WHERE experience_years >= 2
LIMIT 20;

-- 6: Hired candidates
SELECT *
FROM candidates
WHERE hired = 1
LIMIT 20;

-- 7: Candidates who were not hired
SELECT *
FROM candidates
WHERE hired = 0
LIMIT 20;

-- AND and OR
-- Task 8: Candidates with high CGPA and multiple internships
SELECT
    candidate_id,
    cgpa,
    internships,
    skills_score,
    hired
FROM candidates
WHERE cgpa >= 8
  AND internships >= 2
LIMIT 50;

-- 9: Candidates with high CGPA or many projects
SELECT
    candidate_id,
    cgpa,
    projects,
    hired
FROM candidates
WHERE cgpa >= 9
   OR projects >= 5
LIMIT 50;

-- Task 10: Combine conditions correctly
SELECT *
FROM candidates
WHERE cgpa >= 8
  AND (
      internships >= 1
      OR projects >= 3
  )
LIMIT 50;

-- 11: List education categories
SELECT DISTINCT education_level
FROM candidates
ORDER BY education_level;

-- 12: List university tiers
SELECT DISTINCT university_tier
FROM candidates
ORDER BY university_tier;

-- 13: List company types
SELECT DISTINCT company_type
FROM candidates
ORDER BY company_type;

-- 14: Highest CGPA first
SELECT
    candidate_id,
    cgpa,
    education_level
FROM candidates
ORDER BY cgpa DESC
LIMIT 20;

-- 15: Lowest CGPA first
SELECT
    candidate_id,
    cgpa
FROM candidates
ORDER BY cgpa ASC
LIMIT 20;

-- 16: Sort by multiple columns
SELECT
    candidate_id,
    skills_score,
    cgpa,
    experience_years
FROM candidates
ORDER BY
    skills_score DESC,
    cgpa DESC
LIMIT 20;

-- 17: Candidates with CGPA between 7 and 9
SELECT *
FROM candidates
WHERE cgpa BETWEEN 7 AND 9
LIMIT 50;

-- 18: Select specific education categories

SELECT DISTINCT education_level
FROM candidates;

-- use the extrsct values
SELECT *
FROM candidates
WHERE education_level IN (
    'Bachelor',
    'Master'
)
LIMIT 50;

--  LIKE
SELECT *
FROM candidates
WHERE education_level LIKE '%Bachelor%';

------------------------
SELECT *
FROM candidates
WHERE education_level ILIKE '%bachelor%';


