CREATE OR REPLACE VIEW healthcare.vw_provider_performance AS

SELECT

    pr."Id"              AS provider_id,

    pr."NAME"            AS provider_name,

    pr."SPECIALITY"      AS speciality,

    org."NAME"           AS organization,

    COUNT(e."Id")        AS total_encounters,

    AVG(e."TOTAL_CLAIM_COST") AS avg_claim_cost,

    SUM(e."TOTAL_CLAIM_COST") AS total_revenue

FROM healthcare.providers pr

LEFT JOIN healthcare.organizations org

ON pr."ORGANIZATION" = org."Id"

LEFT JOIN healthcare.encounters e

ON pr."Id" = e."PROVIDER"

GROUP BY

pr."Id",
pr."NAME",
pr."SPECIALITY",
org."NAME";