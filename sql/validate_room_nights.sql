SELECT
    property_id,
    room_id,
    MIN(occupancy_date) AS first_available_date,
    MAX(occupancy_date) AS last_available_date,
    COUNT(*) AS available_room_nights,
    COUNTIF(is_occupied) AS occupied_room_nights
FROM `authentic-bongo-415313.cove_analytics.int_room_nights`
GROUP BY
    property_id,
    room_id
ORDER BY
    property_id,
    room_id;