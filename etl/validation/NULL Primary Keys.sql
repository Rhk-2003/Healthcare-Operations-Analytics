-- ============================================================================
-- NULL PRIMARY KEYS
-- ============================================================================

SELECT COUNT(*) AS null_patient_ids
FROM patients
WHERE "Id" IS NULL;

SELECT COUNT(*) AS null_organization_ids
FROM organizations
WHERE "Id" IS NULL;

SELECT COUNT(*) AS null_provider_ids
FROM providers
WHERE "Id" IS NULL;

SELECT COUNT(*) AS null_payer_ids
FROM payers
WHERE "Id" IS NULL;

SELECT COUNT(*) AS null_encounter_ids
FROM encounters
WHERE "Id" IS NULL;

SELECT COUNT(*) AS null_careplan_ids
FROM careplans
WHERE "Id" IS NULL;