SELECT
    room_id,
    occupancy_date,
    COUNT(*) AS row_count
FROM {{ ref('int_room_nights') }}
GROUP BY
    room_id,
    occupancy_date
HAVING COUNT(*) > 1