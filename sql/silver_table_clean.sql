CREATE TABLE silver_german_credit_clean AS
SELECT
    ROW_NUMBER() OVER () AS credit_application_id,

    col_1  AS checking_account_status_code,
    CAST(col_2 AS UNSIGNED) AS duration_months,
    col_3  AS credit_history_code,
    col_4  AS purpose_code,
    CAST(col_5 AS UNSIGNED) AS credit_amount,
    col_6  AS savings_account_bonds_code,
    col_7  AS employment_since_code,
    CAST(col_8 AS UNSIGNED) AS installment_rate_pct_income,
    col_9  AS personal_status_sex_code,
    col_10 AS other_debtors_guarantors_code,
    CAST(col_11 AS UNSIGNED) AS present_residence_since,
    col_12 AS property_code,
    CAST(col_13 AS UNSIGNED) AS age_years,
    col_14 AS other_installment_plans_code,
    col_15 AS housing_code,
    CAST(col_16 AS UNSIGNED) AS existing_credits_bank,
    col_17 AS job_code,
    CAST(col_18 AS UNSIGNED) AS liable_people_count,
    col_19 AS telephone_code,
    col_20 AS foreign_worker_code,

    CAST(col_21 AS UNSIGNED) AS target_original,

    CASE
        WHEN CAST(col_21 AS UNSIGNED) = 1 THEN 0
        WHEN CAST(col_21 AS UNSIGNED) = 2 THEN 1
    END AS target_default,

    CASE
        WHEN CAST(col_21 AS UNSIGNED) = 1 THEN 'good'
        WHEN CAST(col_21 AS UNSIGNED) = 2 THEN 'bad'
    END AS target_label

FROM bronze_german_credit_raw;