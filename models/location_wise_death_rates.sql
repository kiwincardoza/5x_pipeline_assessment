{{  config(    materialized='view'  )}}

with grouped_death_rates as (
    SELECT LOCATION, 
    SUM(TOTAL_DEATHS) AS TOTAL_DEATHS,
    SUM(TOTAL_DEATHS_PER_MILLION) AS TOTAL_DEATHS_RATE,
    SUM(NEW_DEATHS) AS NEW_DEATHS,
    SUM(NEW_DEATHS_PER_MILLION) AS NEW_DEATHS_RATE 
    FROM {{ ref('death_rates') }} 
    GROUP BY LOCATION
),

top_10_location_wise_death_rates AS (
    SELECT * 
    FROM grouped_death_rates 
    ORDER BY TOTAL_DEATHS DESC
)

SELECT * FROM top_10_location_wise_death_rates