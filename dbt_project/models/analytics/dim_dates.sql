WITH calendar AS (
    SELECT
        CAST('2024-01-01' AS DATE) AS date_value
    UNION ALL  
    SELECT
        date_value + 1
    FROM calendar
    WHERE date_value < CAST('2025-12-31' AS DATE)
)

SELECT
    CAST(TO_VARCHAR(date_value, 'DDMMYYYY') AS INTEGER) AS date_key,
    TO_VARCHAR(date_value, 'DD.MM.YYYY') AS date_value,
    YEAR(date_value) AS year,
    MONTH(date_value) AS month,
    DAYOFWEEK(date_value) AS day_of_week_number,
    DAYNAME(date_value) AS day_of_week,
    CASE
        WHEN DAYNAME(date_value) IN ('Sat', 'Sun') THEN TRUE
        ELSE FALSE
    END AS is_weekend

FROM calendar