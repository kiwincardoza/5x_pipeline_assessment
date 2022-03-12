# 5x_pipeline_assessment
Dbt Cloud integrated Repository - 5x 6 hour pipeline assessment

A fully functional pipeline which includes:
  1. Ingesting data from Google Sheets to Snowflake using Fivetran
  2. Creating models using 'dbt' integrated with this repository
  3. Visualizing the reports using 'Google Data Studio' from Snowflake

NOTES:
  1. The models and reports include only a subset of the fields from the original dataset (Google Sheets)
  2. The models as of now, is not implemented to run like a production environment. It has to be manually triggered using 'dbt run'

