DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS interviews;
DROP TABLE IF EXISTS assessments;
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS candidates;


CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY,
    candidate_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    university VARCHAR(150),
    degree VARCHAR(100),
    graduation_year INT,
    location VARCHAR(100),
    source VARCHAR(100)
);


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    internship_capacity INT
);


CREATE TABLE applications (
    application_id INT PRIMARY KEY,

    candidate_id INT
        REFERENCES candidates(candidate_id),

    department_id INT
        REFERENCES departments(department_id),

    application_date DATE,

    status VARCHAR(30)
);


CREATE TABLE assessments (
    assessment_id INT PRIMARY KEY,

    application_id INT
        REFERENCES applications(application_id),

    assessment_date DATE,

    assessment_score DECIMAL(5,2),

    assessment_status VARCHAR(30)
);


CREATE TABLE interviews (
    interview_id INT PRIMARY KEY,

    application_id INT
        REFERENCES applications(application_id),

    interview_date DATE,

    interview_round VARCHAR(30),

    technical_score DECIMAL(5,2),

    communication_score DECIMAL(5,2),

    overall_score DECIMAL(5,2),

    interview_status VARCHAR(30)
);


CREATE TABLE offers (
    offer_id INT PRIMARY KEY,

    application_id INT
        REFERENCES applications(application_id),

    offer_date DATE,

    stipend DECIMAL(10,2),

    offer_status VARCHAR(30),

    joining_date DATE
);

SELECT COUNT(*) FROM candidates;

SELECT COUNT(*) FROM departments;

SELECT COUNT(*) FROM applications;

SELECT COUNT(*) FROM assessments;

SELECT COUNT(*) FROM interviews;

SELECT COUNT(*) FROM offers;


SELECT *
FROM candidates
LIMIT 10;

SELECT *
FROM applications
LIMIT 10;
