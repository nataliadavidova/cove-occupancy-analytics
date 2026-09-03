WITH monthly_occupancy AS (
    SELECT
        property_id,
        property_name,
        city,
        DATE_TRUNC(occupancy_date, MONTH) AS occupancy_month,
        COUNT(*) AS available_room_nights,
        COUNTIF(is_occupied) AS occupied_room_nights
    FROM {{ ref('int_room_nights') }}
    GROUP BY
        property_id,
        property_name,
        city,
        occupancy_month
)

SELECT
    property_id,
    property_name,
    city,
    occupancy_month,
    occupied_room_nights,
    available_room_nights,
    SAFE_DIVIDE(
        occupied_room_nights,
        available_room_nights
    ) AS occupancy_rate
FROM monthly_occupancy