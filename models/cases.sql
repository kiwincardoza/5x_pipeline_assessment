{{  config(    materialized='view'  )}}

WITH cases AS (
    SELECT LOCATION,
    POPULATION,
    AREA_IN_KILOMETER_SQUARE,
    LOCATION_ISO_CODE,
    TOTAL_CASES,
    TOTAL_CASES_PER_MILLION,
    NEW_CASES,
    NEW_ACTIVE_CASES 
    FROM {{ ref('covid19') }}
)

SELECT * FROM cases