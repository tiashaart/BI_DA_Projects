CREATE TABLE candidates (
    candidate_id INTEGER PRIMARY KEY,
    age INTEGER,
    education_level VARCHAR(100),
    university_tier VARCHAR(100),
    cgpa NUMERIC(5,2),
    internships INTEGER,
    projects INTEGER,
    programming_languages INTEGER,
    certifications INTEGER,
    experience_years NUMERIC(5,2),
    hackathons INTEGER,
    research_papers INTEGER,
    skills_score NUMERIC(6,2),
    hired INTEGER,
    soft_skills_score NUMERIC(6,2),
    resume_length_words INTEGER,
    company_type VARCHAR(100)
);

SELECT COUNT(*)
FROM candidates;

SELECT *
FROM candidates
LIMIT 10;