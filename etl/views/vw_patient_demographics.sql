CREATE OR REPLACE VIEW healthcare.vw_patient_demographics AS

SELECT

    "Id"                    AS patient_id,

    "FIRST"                 AS first_name,

    "LAST"                  AS last_name,

    "BIRTHDATE"             AS birth_date,

    "DEATHDATE"             AS death_date,

    EXTRACT(
        YEAR FROM AGE(CURRENT_DATE, "BIRTHDATE")
    )                       AS age,

    "GENDER"                AS gender,

    "RACE"                  AS race,

    "ETHNICITY"             AS ethnicity,

    "CITY"                  AS city,

    "STATE"                 AS state,

    "COUNTY"                AS county,

    "HEALTHCARE_EXPENSES"   AS healthcare_expenses,

    "HEALTHCARE_COVERAGE"   AS healthcare_coverage

FROM healthcare.patients;