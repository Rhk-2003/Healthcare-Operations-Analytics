/*
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar
Database: PostgreSQL
Script  : 04_indexes.sql

Description:
Creates indexes to improve query performance.

Primary keys automatically create indexes.

This script creates indexes on frequently joined
foreign key columns and commonly filtered columns.
===============================================================================
*/

SET search_path TO healthcare;

-- ============================================================================
-- PROVIDERS
-- ============================================================================

CREATE INDEX idx_providers_organization
ON providers("ORGANIZATION");

-- ============================================================================
-- ENCOUNTERS
-- ============================================================================

CREATE INDEX idx_encounters_patient
ON encounters("PATIENT");

CREATE INDEX idx_encounters_provider
ON encounters("PROVIDER");

CREATE INDEX idx_encounters_organization
ON encounters("ORGANIZATION");

CREATE INDEX idx_encounters_payer
ON encounters("PAYER");

CREATE INDEX idx_encounters_start
ON encounters("START");

CREATE INDEX idx_encounters_class
ON encounters("ENCOUNTERCLASS");

-- ============================================================================
-- CONDITIONS
-- ============================================================================

CREATE INDEX idx_conditions_patient
ON conditions("PATIENT");

CREATE INDEX idx_conditions_encounter
ON conditions("ENCOUNTER");

CREATE INDEX idx_conditions_code
ON conditions("CODE");

-- ============================================================================
-- PROCEDURES
-- ============================================================================

CREATE INDEX idx_procedures_patient
ON PROCEDURES("PATIENT");

CREATE INDEX idx_procedures_encounter
ON PROCEDURES("ENCOUNTER");

CREATE INDEX idx_procedures_code
ON PROCEDURES("CODE");

-- ============================================================================
-- MEDICATIONS
-- ============================================================================

CREATE INDEX idx_medications_patient
ON medications("PATIENT");

CREATE INDEX idx_medications_encounter
ON medications("ENCOUNTER");

CREATE INDEX idx_medications_payer
ON medications("PAYER");

CREATE INDEX idx_medications_code
ON medications("CODE");

-- ============================================================================
-- OBSERVATIONS
-- ============================================================================

CREATE INDEX idx_observations_patient
ON observations("PATIENT");

CREATE INDEX idx_observations_encounter
ON observations("ENCOUNTER");

CREATE INDEX idx_observations_category
ON observations("CATEGORY");

CREATE INDEX idx_observations_code
ON observations("CODE");

-- ============================================================================
-- CAREPLANS
-- ============================================================================

CREATE INDEX idx_careplans_patient
ON careplans("PATIENT");

CREATE INDEX idx_careplans_encounter
ON careplans("ENCOUNTER");

CREATE INDEX idx_careplans_code
ON careplans("CODE");