{{  config(    materialized='view'  )}}

with main_subset AS (
    SELECT LOCATION,
    CONCAT(SPLIT(DATE, '/')[0], '-', SPLIT(DATE, '/')[2]) AS MONTH_YEAR,
    TOTAL_CASES,
    TOTAL_DEATHS,
    TOTAL_RECOVERED,
    TOTAL_CASES_PER_MILLION  
    FROM {{ ref('covid19') }}
), 
location_month_group AS (
    SELECT LOCATION,
    MONTH_YEAR,
    SUM(TOTAL_DEATHS) AS TOTAL_DEATHS,
    SUM(TOTAL_CASES) AS TOTAL_CASES,
    SUM(TOTAL_RECOVERED) AS TOTAL_RECOVERED,
    SUM(TOTAL_CASES_PER_MILLION) AS TOTAL_CASES_PER_MILLION 
    FROM main_subset 
    GROUP BY LOCATION, MONTH_YEAR
),
month_group AS (
    SELECT MONTH_YEAR,
    SUM(TOTAL_DEATHS) AS TOTAL_DEATHS,
    SUM(TOTAL_CASES) AS TOTAL_CASES,
    SUM(TOTAL_RECOVERED) AS TOTAL_RECOVERED,
    MAX(TOTAL_CASES_PER_MILLION) AS TOTAL_CASES_PER_MILLION 
    FROM location_month_group 
    GROUP BY MONTH_YEAR
),
final_dataset AS (
    SELECT TO_DATE(a.MONTH_YEAR, 'MM-YYYY') AS MONTH_YEAR, 
    b.LOCATION,
    a.TOTAL_CASES,
    a.TOTAL_DEATHS,
    a.TOTAL_RECOVERED 
    FROM month_group a 
    INNER JOIN location_month_group b 
    ON a.TOTAL_CASES_PER_MILLION = b.TOTAL_CASES_PER_MILLION 
    ORDER BY MONTH_YEAR
)

SELECT * FROM final_dataset