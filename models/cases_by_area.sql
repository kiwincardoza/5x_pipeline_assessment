{{  config(    materialized='view'  )}}

SELECT AREA_IN_KILOMETER_SQUARE,
SUM(TOTAL_CASES) AS TOTAL_CASES,
SUM(TOTAL_CASES_PER_MILLION) AS TOTAL_CASES_PER_MILLION,
SUM(NEW_CASES) AS NEW_CASES,
SUM(NEW_ACTIVE_CASES) AS NEW_ACTIVE_CASES 
FROM {{ ref('cases') }} 
GROUP BY AREA_IN_KILOMETER_SQUARE 
ORDER BY TOTAL_CASES DESC