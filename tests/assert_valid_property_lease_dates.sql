SELECT *
FROM {{ ref('stg_properties') }}
WHERE lease_start_date > lease_end_date