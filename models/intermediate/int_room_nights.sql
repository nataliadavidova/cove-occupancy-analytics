WITH room_availability AS (
    SELECT
        p.property_id,
        p.property_name,
        p.city,
        r.room_id,
        p.lease_start_date AS available_start_date,
        LEAST(
            p.lease_end_date,
            CURRENT_DATE(),
            COALESCE(
                DATE_SUB(DATE(p.deleted_at), INTERVAL 1 DAY),
                DATE '9999-12-31'
            ),
            COALESCE(
                DATE_SUB(DATE(r.deleted_at), INTERVAL 1 DAY),
                DATE '9999-12-31'
            )
        ) AS available_end_date
    FROM {{ ref('stg_rooms') }} AS r
    INNER JOIN {{ ref('stg_properties') }} AS p
        ON r.property_id = p.property_id
),

room_nights AS (
    SELECT
        property_id,
        property_name,
        city,
        room_id,
        occupancy_date
    FROM room_availability
    CROSS JOIN UNNEST(
        GENERATE_DATE_ARRAY(available_start_date, available_end_date)
    ) AS occupancy_date
    WHERE available_start_date <= available_end_date
),

room_night_occupancy AS (
    SELECT
        rn.property_id,
        rn.property_name,
        rn.city,
        rn.room_id,
        rn.occupancy_date,
        COUNTIF(t.tenancy_id IS NOT NULL) > 0 AS is_occupied
    FROM room_nights AS rn
    LEFT JOIN {{ ref('stg_tenancies') }} AS t
        ON rn.room_id = t.room_id
        AND t.status != 'cancelled'
        AND rn.occupancy_date >= t.check_in_date
        AND rn.occupancy_date < t.check_out_date
    GROUP BY
        rn.property_id,
        rn.property_name,
        rn.city,
        rn.room_id,
        rn.occupancy_date
)

SELECT
    property_id,
    property_name,
    city,
    room_id,
    occupancy_date,
    is_occupied
FROM room_night_occupancy