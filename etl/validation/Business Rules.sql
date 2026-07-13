-- ============================================================================
-- BUSINESS RULES
-- ============================================================================

-- Negative Healthcare Expenses

SELECT COUNT(*)
FROM patients
WHERE "HEALTHCARE_EXPENSES" < 0;

-- Negative Claim Cost

SELECT COUNT(*)
FROM encounters
WHERE "TOTAL_CLAIM_COST" < 0;

-- Encounter End Before Start

SELECT COUNT(*)
FROM encounters
WHERE "STOP" < "START";

-- Invalid Latitude

SELECT COUNT(*)
FROM organizations
WHERE "LAT" NOT BETWEEN -90 AND 90;

-- Invalid Longitude

SELECT COUNT(*)
FROM organizations
WHERE "LON" NOT BETWEEN -180 AND 180;