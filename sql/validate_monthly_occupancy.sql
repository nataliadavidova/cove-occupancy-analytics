WITH property_totals AS (
    SELECT
        'property_total' AS check_type,
        property_id,
        CAST(NULL AS DATE) AS occupancy_month,
        SUM(occupied_room_nights) AS occupied_room_nights,
        SUM(available_room_nights) AS available_room_nights,
        SAFE_DIVIDE(
            SUM(occupied_room_nights),
            SUM(available_room_nights)
        ) AS occupancy_rate
    FROM `authentic-bongo-415313.cove_analytics.fct_monthly_property_occupancy`
    GROUP BY property_id
),

overlap_sensitive_month AS (
    SELECT
        'overlap_sensitive_month' AS check_type,
        property_id,
        occupancy_month,
        occupied_room_nights,
        available_room_nights,
        occupancy_rate
    FROM `authentic-bongo-415313.cove_analytics.fct_monthly_property_occupancy`
    WHERE property_id = 'p_002'
      AND occupancy_month = DATE '2025-06-01'
)

SELECT *
FROM property_totals

UNION ALL

SELECT *
FROM overlap_sensitive_month

ORDER BY
    check_type,
    property_id;