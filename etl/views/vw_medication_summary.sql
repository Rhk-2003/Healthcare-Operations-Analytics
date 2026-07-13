CREATE OR REPLACE VIEW healthcare.vw_medication_summary AS

SELECT

    m."CODE",

    m."DESCRIPTION",

    COUNT(*) AS prescriptions,

    AVG(m."TOTALCOST") AS average_cost,

    SUM(m."TOTALCOST") AS total_cost

FROM healthcare.medications m

GROUP BY

m."CODE",
m."DESCRIPTION";