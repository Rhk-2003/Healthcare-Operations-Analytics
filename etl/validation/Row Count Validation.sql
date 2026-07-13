-- ============================================================================
-- ROW COUNTS
-- ============================================================================

SELECT 'patients' AS table_name, COUNT(*) AS row_count
FROM patients

UNION ALL

SELECT 'organizations', COUNT(*)
FROM organizations

UNION ALL

SELECT 'providers', COUNT(*)
FROM providers

UNION ALL

SELECT 'payers', COUNT(*)
FROM payers

UNION ALL

SELECT 'encounters', COUNT(*)
FROM encounters

UNION ALL

SELECT 'conditions', COUNT(*)
FROM conditions

UNION ALL

SELECT 'procedures', COUNT(*)
FROM procedures

UNION ALL

SELECT 'medications', COUNT(*)
FROM medications

UNION ALL

SELECT 'observations', COUNT(*)
FROM observations

UNION ALL

SELECT 'careplans', COUNT(*)
FROM careplans

ORDER BY table_name;