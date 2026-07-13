/*
===============================================================================
Project : Hospital Operations & Patient Flow Analytics Platform
Author  : Himnish Kumar
Database: PostgreSQL
Script  : 02_create_tables.sql (Part 1 - Reference Tables)

Description:
Creates the reference (master) tables used throughout the Healthcare
Operations Analytics Platform.

Tables Created:
1. patients
2. organizations
3. providers
4. payers

Notes:
- Original Synthea column names are preserved.
- Primary Keys will be added in 03_constraints.sql
- Foreign Keys will be added in 03_constraints.sql
- Indexes will be added in 04_indexes.sql
===============================================================================
*/

SET search_path TO healthcare;

-- ============================================================================
-- TABLE: patients
-- ============================================================================
CREATE TABLE healthcare.patients (

    "Id" UUID,

    "BIRTHDATE" DATE,
    "DEATHDATE" DATE,

    "SSN" VARCHAR(20),
    "DRIVERS" VARCHAR(30),
    "PASSPORT" VARCHAR(30),

    "PREFIX" VARCHAR(20),
    "FIRST" VARCHAR(100),
    "LAST" VARCHAR(100),
    "SUFFIX" VARCHAR(20),
    "MAIDEN" VARCHAR(100),

    "MARITAL" VARCHAR(20),
    "RACE" VARCHAR(50),
    "ETHNICITY" VARCHAR(50),
    "GENDER" VARCHAR(10),

    "BIRTHPLACE" TEXT,

    "ADDRESS" TEXT,
    "CITY" VARCHAR(100),
    "STATE" VARCHAR(100),
    "COUNTY" VARCHAR(100),
    "ZIP" VARCHAR(10),

    "LAT" NUMERIC(10,8),
    "LON" NUMERIC(11,8),

    "HEALTHCARE_EXPENSES" NUMERIC(15,2),
    "HEALTHCARE_COVERAGE" NUMERIC(15,2)

);

-- ============================================================================
-- TABLE: organizations
-- ============================================================================
CREATE TABLE healthcare.organizations (

    "Id" UUID,

    "NAME" VARCHAR(255),

    "ADDRESS" TEXT,
    "CITY" VARCHAR(100),
    "STATE" VARCHAR(100),
    "ZIP" VARCHAR(10),

    "LAT" NUMERIC(10,8),
    "LON" NUMERIC(11,8),

    "PHONE" VARCHAR(30),

    "REVENUE" NUMERIC(18,2),

    "UTILIZATION" INTEGER

);

-- ============================================================================
-- TABLE: providers
-- ============================================================================
CREATE TABLE healthcare.providers (

    "Id" UUID,

    "ORGANIZATION" UUID,

    "NAME" VARCHAR(255),

    "GENDER" VARCHAR(10),

    "SPECIALITY" VARCHAR(100),

    "ADDRESS" TEXT,
    "CITY" VARCHAR(100),
    "STATE" VARCHAR(100),
    "ZIP" VARCHAR(10),

    "LAT" NUMERIC(10,8),
    "LON" NUMERIC(11,8),

    "UTILIZATION" INTEGER

);

-- ============================================================================
-- TABLE: payers
-- ============================================================================
CREATE TABLE healthcare.payers (

    "Id" UUID,

    "NAME" VARCHAR(255),

    "ADDRESS" TEXT,
    "CITY" VARCHAR(100),
    "STATE_HEADQUARTERED" VARCHAR(100),
    "ZIP" VARCHAR(10),

    "PHONE" VARCHAR(30),

    "AMOUNT_COVERED" NUMERIC(18,2),
    "AMOUNT_UNCOVERED" NUMERIC(18,2),
    "REVENUE" NUMERIC(18,2),

    "COVERED_ENCOUNTERS" INTEGER,
    "UNCOVERED_ENCOUNTERS" INTEGER,

    "COVERED_MEDICATIONS" INTEGER,
    "UNCOVERED_MEDICATIONS" INTEGER,

    "COVERED_PROCEDURES" INTEGER,
    "UNCOVERED_PROCEDURES" INTEGER,

    "COVERED_IMMUNIZATIONS" INTEGER,
    "UNCOVERED_IMMUNIZATIONS" INTEGER,

    "UNIQUE_CUSTOMERS" INTEGER,

    "QOLS_AVG" NUMERIC(8,4),

    "MEMBER_MONTHS" INTEGER

);
-- ============================================================================
-- TABLE: encounters
-- ============================================================================

CREATE TABLE healthcare.encounters (

    "Id" UUID,

    "START" TIMESTAMP,

    "STOP" TIMESTAMP,

    "PATIENT" UUID,

    "ORGANIZATION" UUID,

    "PROVIDER" UUID,

    "PAYER" UUID,

    "ENCOUNTERCLASS" VARCHAR(50),

    "CODE" INTEGER,

    "DESCRIPTION" TEXT,

    "BASE_ENCOUNTER_COST" NUMERIC(15,2),

    "TOTAL_CLAIM_COST" NUMERIC(15,2),

    "PAYER_COVERAGE" NUMERIC(15,2),

    "REASONCODE" BIGINT,

    "REASONDESCRIPTION" TEXT

);
-- ============================================================================
-- TABLE: conditions
-- Description:
-- Stores medical conditions (diagnoses) recorded during patient encounters.
-- ============================================================================

CREATE TABLE healthcare.conditions (

    "START" DATE,

    "STOP" DATE,

    "PATIENT" UUID,

    "ENCOUNTER" UUID,

    "CODE" BIGINT,

    "DESCRIPTION" TEXT

);

-- ============================================================================
-- TABLE: procedures
-- Description:
-- Stores procedures performed during patient encounters.
-- ============================================================================

CREATE TABLE healthcare.procedures (

    "START" TIMESTAMP,

    "STOP" TIMESTAMP,

    "PATIENT" UUID,

    "ENCOUNTER" UUID,

    "CODE" BIGINT,

    "DESCRIPTION" TEXT,

    "BASE_COST" NUMERIC(15,2),

    "REASONCODE" BIGINT,

    "REASONDESCRIPTION" TEXT

);

-- ============================================================================
-- TABLE: medications
-- Description:
-- Stores medications prescribed or administered during encounters.
-- ============================================================================

CREATE TABLE healthcare.medications (

    "START" DATE,

    "STOP" DATE,

    "PATIENT" UUID,

    "PAYER" UUID,

    "ENCOUNTER" UUID,

    "CODE" BIGINT,

    "DESCRIPTION" TEXT,

    "BASE_COST" NUMERIC(15,2),

    "PAYER_COVERAGE" NUMERIC(15,2),

    "DISPENSES" INTEGER,

    "TOTALCOST" NUMERIC(15,2),

    "REASONCODE" BIGINT,

    "REASONDESCRIPTION" TEXT

);

-- ============================================================================
-- TABLE: observations
-- Description:
-- Stores patient observations such as vitals, laboratory values and
-- clinical measurements.
-- ============================================================================

CREATE TABLE healthcare.observations (

    "DATE" TIMESTAMP,

    "PATIENT" UUID,

    "ENCOUNTER" UUID,

    "CATEGORY" VARCHAR(100),

    "CODE" VARCHAR(50),

    "DESCRIPTION" TEXT,

    "VALUE" TEXT,

    "UNITS" VARCHAR(100),

    "TYPE" VARCHAR(50)

);

-- ============================================================================
-- TABLE: careplans
-- Description:
-- Stores care plans prescribed to patients.
-- ============================================================================

CREATE TABLE healthcare.careplans (

    "Id" UUID,

    "START" DATE,

    "STOP" DATE,

    "PATIENT" UUID,

    "ENCOUNTER" UUID,

    "CODE" BIGINT,

    "DESCRIPTION" TEXT,

    "REASONCODE" BIGINT,

    "REASONDESCRIPTION" TEXT

);