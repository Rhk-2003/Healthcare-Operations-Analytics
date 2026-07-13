CREATE OR REPLACE VIEW healthcare.vw_observation_summary AS

SELECT

    "CATEGORY",

    "DESCRIPTION",

    COUNT(*) AS observation_count,

    AVG(
        CASE
            WHEN "TYPE"='numeric'
            THEN "VALUE"::numeric
        END
    ) AS average_value

FROM healthcare.observations

GROUP BY

"CATEGORY",
"DESCRIPTION";