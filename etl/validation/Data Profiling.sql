-- ============================================================================
-- DATA PROFILE
-- ============================================================================

SELECT
    COUNT(*) AS total_patients,
    COUNT(DISTINCT "CITY") AS cities,
    COUNT(DISTINCT "STATE") AS states
FROM patients;

SELECT
    COUNT(*) AS total_encounters,
    AVG("TOTAL_CLAIM_COST") AS avg_claim_cost,
    MAX("TOTAL_CLAIM_COST") AS max_claim_cost,
    MIN("TOTAL_CLAIM_COST") AS min_claim_cost
FROM encounters;

SELECT
    COUNT(DISTINCT "CODE") AS unique_conditions
FROM conditions;

SELECT
    COUNT(DISTINCT "CODE") AS unique_procedures
FROM procedures;

SELECT
    COUNT(DISTINCT "CODE") AS unique_medications
FROM medications;

SELECT
    COUNT(DISTINCT "CATEGORY") AS observation_categories
FROM observations;