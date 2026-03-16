CREATE TABLE dim_credit_request AS
SELECT
    ROW_NUMBER() OVER () AS credit_request_key,
    purpose_code,
    CASE
        WHEN purpose_code = 'A40' THEN 'car_new'
        WHEN purpose_code = 'A41' THEN 'car_used'
        WHEN purpose_code = 'A42' THEN 'furniture_equipment'
        WHEN purpose_code = 'A43' THEN 'radio_tv'
        WHEN purpose_code = 'A44' THEN 'domestic_appliances'
        WHEN purpose_code = 'A45' THEN 'repairs'
        WHEN purpose_code = 'A46' THEN 'education'
        WHEN purpose_code = 'A48' THEN 'retraining'
        WHEN purpose_code = 'A49' THEN 'business'
        WHEN purpose_code = 'A410' THEN 'others'
    END AS purpose_desc,
    installment_rate_pct_income,
    duration_band,
    credit_amount_band
FROM (
    SELECT DISTINCT
        purpose_code,
        installment_rate_pct_income,
        CASE
            WHEN duration_months <= 12 THEN 'short_term'
            WHEN duration_months <= 36 THEN 'medium_term'
            ELSE 'long_term'
        END AS duration_band,
        CASE
            WHEN credit_amount < 2000 THEN 'low_credit'
            WHEN credit_amount < 5000 THEN 'medium_credit'
            ELSE 'high_credit'
        END AS credit_amount_band
    FROM silver_german_credit_clean
) t;