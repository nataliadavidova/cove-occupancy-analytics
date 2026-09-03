WITH source AS (
    SELECT *
    FROM {{ source('cove_raw', 'tenancies') }}
),

renamed_and_typed AS (
    SELECT
        _id AS tenancy_id,
        roomId AS room_id,
        tenant_id,
        SAFE_CAST(checkInDate AS DATE) AS check_in_date,
        SAFE_CAST(checkOutDate AS DATE) AS check_out_date,
        status,
        SAFE_CAST(updatedAt AS TIMESTAMP) AS updated_at
    FROM source
)

SELECT *
FROM renamed_and_typed