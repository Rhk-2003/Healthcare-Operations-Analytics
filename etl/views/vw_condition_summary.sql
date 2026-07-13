CREATE OR REPLACE VIEW healthcare.vw_condition_summary AS

SELECT

    c."CODE",

    c."DESCRIPTION",

    COUNT(*) AS occurrence_count

FROM healthcare.conditions c

GROUP BY

c."CODE",
c."DESCRIPTION";