/*
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar
Database: PostgreSQL
Script  : 03_constraints.sql

Description:
Adds relational integrity constraints to the Healthcare schema.

This script adds:

1. Primary Keys
2. Foreign Keys
3. NOT NULL Constraints
4. CHECK Constraints

===============================================================================
*/

SET search_path TO healthcare;

-- ============================================================================
-- PRIMARY KEYS
-- ============================================================================

ALTER TABLE patients
ADD CONSTRAINT pk_patients
PRIMARY KEY ("Id");

ALTER TABLE organizations
ADD CONSTRAINT pk_organizations
PRIMARY KEY ("Id");

ALTER TABLE providers
ADD CONSTRAINT pk_providers
PRIMARY KEY ("Id");

ALTER TABLE payers
ADD CONSTRAINT pk_payers
PRIMARY KEY ("Id");

ALTER TABLE encounters
ADD CONSTRAINT pk_encounters
PRIMARY KEY ("Id");

ALTER TABLE careplans
ADD CONSTRAINT pk_careplans
PRIMARY KEY ("Id");


-- ============================================================================
-- FOREIGN KEYS
-- ============================================================================

-- Providers

ALTER TABLE providers
ADD CONSTRAINT fk_provider_organization
FOREIGN KEY ("ORGANIZATION")
REFERENCES organizations("Id");


-- Encounters

ALTER TABLE encounters
ADD CONSTRAINT fk_encounter_patient
FOREIGN KEY ("PATIENT")
REFERENCES patients("Id");

ALTER TABLE encounters
ADD CONSTRAINT fk_encounter_provider
FOREIGN KEY ("PROVIDER")
REFERENCES providers("Id");

ALTER TABLE encounters
ADD CONSTRAINT fk_encounter_organization
FOREIGN KEY ("ORGANIZATION")
REFERENCES organizations("Id");

ALTER TABLE encounters
ADD CONSTRAINT fk_encounter_payer
FOREIGN KEY ("PAYER")
REFERENCES payers("Id");


-- Conditions

ALTER TABLE conditions
ADD CONSTRAINT fk_condition_patient
FOREIGN KEY ("PATIENT")
REFERENCES patients("Id");

ALTER TABLE conditions
ADD CONSTRAINT fk_condition_encounter
FOREIGN KEY ("ENCOUNTER")
REFERENCES encounters("Id");


-- Procedures

ALTER TABLE procedures
ADD CONSTRAINT fk_procedure_patient
FOREIGN KEY ("PATIENT")
REFERENCES patients("Id");

ALTER TABLE procedures
ADD CONSTRAINT fk_procedure_encounter
FOREIGN KEY ("ENCOUNTER")
REFERENCES encounters("Id");


-- Medications

ALTER TABLE medications
ADD CONSTRAINT fk_medication_patient
FOREIGN KEY ("PATIENT")
REFERENCES patients("Id");

ALTER TABLE medications
ADD CONSTRAINT fk_medication_encounter
FOREIGN KEY ("ENCOUNTER")
REFERENCES encounters("Id");

ALTER TABLE medications
ADD CONSTRAINT fk_medication_payer
FOREIGN KEY ("PAYER")
REFERENCES payers("Id");


-- Observations

ALTER TABLE observations
ADD CONSTRAINT fk_observation_patient
FOREIGN KEY ("PATIENT")
REFERENCES patients("Id");

ALTER TABLE observations
ADD CONSTRAINT fk_observation_encounter
FOREIGN KEY ("ENCOUNTER")
REFERENCES encounters("Id");


-- Careplans

ALTER TABLE careplans
ADD CONSTRAINT fk_careplan_patient
FOREIGN KEY ("PATIENT")
REFERENCES patients("Id");

ALTER TABLE careplans
ADD CONSTRAINT fk_careplan_encounter
FOREIGN KEY ("ENCOUNTER")
REFERENCES encounters("Id");


-- ============================================================================
-- NOT NULL CONSTRAINTS
-- ============================================================================

ALTER TABLE patients
ALTER COLUMN "Id" SET NOT NULL;

ALTER TABLE organizations
ALTER COLUMN "Id" SET NOT NULL;

ALTER TABLE providers
ALTER COLUMN "Id" SET NOT NULL;

ALTER TABLE payers
ALTER COLUMN "Id" SET NOT NULL;

ALTER TABLE encounters
ALTER COLUMN "Id" SET NOT NULL;

ALTER TABLE careplans
ALTER COLUMN "Id" SET NOT NULL;


-- ============================================================================
-- CHECK CONSTRAINTS
-- ============================================================================

ALTER TABLE patients
ADD CONSTRAINT chk_patient_gender
CHECK ("GENDER" IN ('M','F'));

ALTER TABLE providers
ADD CONSTRAINT chk_provider_gender
CHECK ("GENDER" IN ('M','F'));

ALTER TABLE patients
ADD CONSTRAINT chk_patient_expenses
CHECK ("HEALTHCARE_EXPENSES" >= 0);

ALTER TABLE patients
ADD CONSTRAINT chk_patient_coverage
CHECK ("HEALTHCARE_COVERAGE" >= 0);

ALTER TABLE organizations
ADD CONSTRAINT chk_organization_revenue
CHECK ("REVENUE" >= 0);

ALTER TABLE encounters
ADD CONSTRAINT chk_encounter_cost
CHECK ("TOTAL_CLAIM_COST" >= 0);

ALTER TABLE encounters
ADD CONSTRAINT chk_payer_coverage
CHECK ("PAYER_COVERAGE" >= 0);

ALTER TABLE procedures
ADD CONSTRAINT chk_procedure_cost
CHECK ("BASE_COST" >= 0);

ALTER TABLE medications
ADD CONSTRAINT chk_medication_cost
CHECK ("TOTALCOST" >= 0);

ALTER TABLE medications
ADD CONSTRAINT chk_medication_dispenses
CHECK ("DISPENSES" >= 0);