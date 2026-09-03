SELECT *
FROM {{ ref('fct_monthly_property_occupancy') }}
WHERE occupied_room_nights > available_room_nights