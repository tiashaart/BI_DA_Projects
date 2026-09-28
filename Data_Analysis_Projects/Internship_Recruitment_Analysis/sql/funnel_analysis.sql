-- Total candidates
SELECT COUNT(*) AS total_candidates
FROM candidates;

-- Total applications
SELECT COUNT(*) AS total_applications
FROM applications;

-- Total assessments
SELECT COUNT(*) AS total_assessments
FROM assessments;

-- Total interviews
SELECT COUNT(DISTINCT application_id) AS interviewed_candidates
FROM interviews;

-- Total offers
SELECT COUNT(*) AS total_offers
FROM offers;

-- Accepted offers
SELECT COUNT(*) AS accepted_offers
FROM offers
WHERE offer_status = 'Accepted';