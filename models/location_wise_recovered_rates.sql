{{  config(    materialized='view'  )}}

with grouped_recovered_rates as (
    SELECT LOCATION, 
    SUM(TOTAL_RECOVERED) AS TOTAL_RECOVERED,
    SUM(CASE_RECOVERED_RATE) AS CASE_RECOVERED_RATE,
    SUM(NEW_RECOVERED) AS NEW_RECOVERED 
    FROM {{ ref('recovered_rates') }} 
    GROUP BY LOCATION
),

top_location_wise_recovered_rates AS (
    SELECT * 
    FROM grouped_recovered_rates 
    ORDER BY TOTAL_RECOVERED DESC
)

SELECT * FROM top_location_wise_recovered_rates