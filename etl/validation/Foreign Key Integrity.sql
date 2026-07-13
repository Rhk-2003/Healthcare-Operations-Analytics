-- ============================================================================
-- FOREIGN KEY VALIDATION
-- ============================================================================

-- Encounters -> Patients

SELECT COUNT(*) AS orphan_encounter_patients
FROM encounters e
LEFT JOIN patients p
ON e."PATIENT" = p."Id"
WHERE p."Id" IS NULL;

-- Providers -> Organizations

SELECT COUNT(*) AS orphan_provider_organizations
FROM providers pr
LEFT JOIN organizations o
ON pr."ORGANIZATION" = o."Id"
WHERE o."Id" IS NULL;

-- Medications -> Payers

SELECT COUNT(*) AS orphan_medication_payers
FROM medications m
LEFT JOIN payers p
ON m."PAYER" = p."Id"
WHERE p."Id" IS NULL;