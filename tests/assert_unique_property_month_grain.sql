SELECT
    property_id,
    occupancy_month,
    COUNT(*) AS row_count
FROM {{ ref('fct_monthly_property_occupancy') }}
GROUP BY
    property_id,
    occupancy_month
HAVING COUNT(*) > 1