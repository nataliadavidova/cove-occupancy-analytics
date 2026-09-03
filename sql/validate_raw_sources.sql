SELECT
    'properties' AS table_name,
    COUNT(*) AS row_count,
    COUNT(DISTINCT _id) AS unique_ids
FROM `authentic-bongo-415313.cove_raw.properties`

UNION ALL

SELECT
    'rooms' AS table_name,
    COUNT(*) AS row_count,
    COUNT(DISTINCT _id) AS unique_ids
FROM `authentic-bongo-415313.cove_raw.rooms`

UNION ALL

SELECT
    'tenancies' AS table_name,
    COUNT(*) AS row_count,
    COUNT(DISTINCT _id) AS unique_ids
FROM `authentic-bongo-415313.cove_raw.tenancies`;