SELECT *
FROM {{ ref('stg_tenancies') }}
WHERE check_in_date >= check_out_date