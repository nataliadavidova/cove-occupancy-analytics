SELECT *
FROM {{ ref('fct_monthly_property_occupancy') }}
WHERE occupancy_rate < 0
   OR occupancy_rate > 1