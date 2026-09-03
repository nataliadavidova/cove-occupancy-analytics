WITH valid_tenancies AS (
    SELECT
        tenancy_id,
        room_id,
        check_in_date,
        check_out_date
    FROM `authentic-bongo-415313.cove_analytics.stg_tenancies`
    WHERE status != 'cancelled'
)

SELECT
    t1.room_id,
    t1.tenancy_id AS first_tenancy_id,
    t2.tenancy_id AS second_tenancy_id,
    GREATEST(t1.check_in_date, t2.check_in_date) AS overlap_start_date,
    LEAST(t1.check_out_date, t2.check_out_date) AS overlap_end_date,
    DATE_DIFF(
        LEAST(t1.check_out_date, t2.check_out_date),
        GREATEST(t1.check_in_date, t2.check_in_date),
        DAY
    ) AS overlapping_nights
FROM valid_tenancies AS t1
INNER JOIN valid_tenancies AS t2
    ON t1.room_id = t2.room_id
    AND t1.tenancy_id < t2.tenancy_id
    AND t1.check_in_date < t2.check_out_date
    AND t2.check_in_date < t1.check_out_date
ORDER BY
    t1.room_id,
    overlap_start_date;