CREATE TABLE fact_credit_risk AS
SELECT
    ROW_NUMBER() OVER () AS credit_risk_key,

    s.credit_application_id,

    dc.customer_profile_key,
    df.financial_profile_key,
    dr.credit_request_key,
    dh.collateral_housing_key,

    s.duration_months,
    s.credit_amount,

    s.target_original,
    s.target_default,
    s.target_label

FROM silver_german_credit_clean s

JOIN dim_customer_profile dc
ON s.personal_status_sex_code = dc.personal_status_sex_code
AND s.age_years = dc.age_years
AND s.job_code = dc.job_code
AND s.liable_people_count = dc.liable_people_count
AND s.telephone_code = dc.telephone_code
AND s.foreign_worker_code = dc.foreign_worker_code

JOIN dim_financial_profile df
ON s.checking_account_status_code = df.checking_account_status_code
AND s.credit_history_code = df.credit_history_code
AND s.savings_account_bonds_code = df.savings_account_bonds_code
AND s.employment_since_code = df.employment_since_code
AND s.other_debtors_guarantors_code = df.other_debtors_guarantors_code
AND s.other_installment_plans_code = df.other_installment_plans_code
AND s.existing_credits_bank = df.existing_credits_bank

JOIN dim_credit_request dr
ON s.purpose_code = dr.purpose_code
AND s.installment_rate_pct_income = dr.installment_rate_pct_income
AND (
    CASE
        WHEN s.duration_months <= 12 THEN 'short_term'
        WHEN s.duration_months <= 36 THEN 'medium_term'
        ELSE 'long_term'
    END
) = dr.duration_band
AND (
    CASE
        WHEN s.credit_amount < 2000 THEN 'low_credit'
        WHEN s.credit_amount < 5000 THEN 'medium_credit'
        ELSE 'high_credit'
    END
) = dr.credit_amount_band

JOIN dim_collateral_housing dh
ON s.property_code = dh.property_code
AND s.housing_code = dh.housing_code
AND s.present_residence_since = dh.present_residence_since;