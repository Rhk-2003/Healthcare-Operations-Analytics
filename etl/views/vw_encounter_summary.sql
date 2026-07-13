CREATE OR REPLACE VIEW healthcare.vw_encounter_summary AS

SELECT

    e."Id"                        AS encounter_id,

    e."PATIENT"                   AS patient_id,

    p."FIRST" || ' ' || p."LAST"  AS patient_name,

    e."START"                     AS encounter_start,

    e."STOP"                      AS encounter_end,

    e."ENCOUNTERCLASS"            AS encounter_type,

    e."DESCRIPTION"               AS encounter_description,

    e."TOTAL_CLAIM_COST"          AS total_claim_cost,

    e."PAYER_COVERAGE"            AS payer_coverage,

    (e."TOTAL_CLAIM_COST" - e."PAYER_COVERAGE")
                                  AS patient_out_of_pocket,

    pr."NAME"                     AS provider,

    org."NAME"                    AS organization,

    pay."NAME"                    AS payer

FROM healthcare.encounters e

JOIN healthcare.patients p
ON e."PATIENT" = p."Id"

JOIN healthcare.providers pr
ON e."PROVIDER" = pr."Id"

JOIN healthcare.organizations org
ON e."ORGANIZATION" = org."Id"

JOIN healthcare.payers pay
ON e."PAYER" = pay."Id";