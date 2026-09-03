WITH source AS (
    SELECT *
    FROM {{ source('cove_raw', 'rooms') }}
),

renamed_and_typed AS (
    SELECT
        _id AS room_id,
        propertyId AS property_id,
        room_number,
        type AS room_type,
        SAFE_CAST(updatedAt AS TIMESTAMP) AS updated_at,
        SAFE_CAST(deletedAt AS TIMESTAMP) AS deleted_at
    FROM source
)

SELECT *
FROM renamed_and_typed