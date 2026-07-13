-- ============================================================================
-- DUPLICATE PRIMARY KEYS
-- ============================================================================

SELECT "Id", COUNT(*)
FROM patients
GROUP BY "Id"
HAVING COUNT(*) > 1;

SELECT "Id", COUNT(*)
FROM organizations
GROUP BY "Id"
HAVING COUNT(*) > 1;

SELECT "Id", COUNT(*)
FROM providers
GROUP BY "Id"
HAVING COUNT(*) > 1;

SELECT "Id", COUNT(*)
FROM payers
GROUP BY "Id"
HAVING COUNT(*) > 1;

SELECT "Id", COUNT(*)
FROM encounters
GROUP BY "Id"
HAVING COUNT(*) > 1;

SELECT "Id", COUNT(*)
FROM careplans
GROUP BY "Id"
HAVING COUNT(*) > 1;