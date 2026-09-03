WITH source AS (
    SELECT *
    FROM {{ source('cove_raw', 'properties') }}
),

renamed_and_typed AS (
    SELECT
        _id AS property_id,
        name AS property_name,
        city,
        SAFE_CAST(lease_start_date AS DATE) AS lease_start_date,
        SAFE_CAST(lease_end_date AS DATE) AS lease_end_date,
        SAFE_CAST(updatedAt AS TIMESTAMP) AS updated_at,
        SAFE_CAST(deletedAt AS TIMESTAMP) AS deleted_at
    FROM source
)

SELECT *
FROM renamed_and_typed