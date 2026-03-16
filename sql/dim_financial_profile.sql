CREATE TABLE dim_financial_profile AS
SELECT
    ROW_NUMBER() OVER () AS financial_profile_key,

    checking_account_status_code,

    CASE
        WHEN checking_account_status_code = 'A11' THEN 'saldo menor que 0 DM'
        WHEN checking_account_status_code = 'A12' THEN 'saldo entre 0 e 200 DM'
        WHEN checking_account_status_code = 'A13' THEN 'saldo maior ou igual a 200 DM'
        WHEN checking_account_status_code = 'A14' THEN 'sem conta corrente'
    END AS checking_account_status_desc,

    credit_history_code,

    CASE
        WHEN credit_history_code = 'A30' THEN 'no credits taken'
        WHEN credit_history_code = 'A31' THEN 'all credits paid back duly'
        WHEN credit_history_code = 'A32' THEN 'existing credits paid back duly till now'
        WHEN credit_history_code = 'A33' THEN 'delay in paying off in the past'
        WHEN credit_history_code = 'A34' THEN 'critical account'
    END AS credit_history_desc,

    savings_account_bonds_code,

    CASE
        WHEN savings_account_bonds_code = 'A61' THEN '< 100 DM'
        WHEN savings_account_bonds_code = 'A62' THEN '100 to 500 DM'
        WHEN savings_account_bonds_code = 'A63' THEN '500 to 1000 DM'
        WHEN savings_account_bonds_code = 'A64' THEN '>= 1000 DM'
        WHEN savings_account_bonds_code = 'A65' THEN 'unknown or no savings account'
    END AS savings_account_bonds_desc,

    employment_since_code,

    CASE
        WHEN employment_since_code = 'A71' THEN 'unemployed'
        WHEN employment_since_code = 'A72' THEN '< 1 year'
        WHEN employment_since_code = 'A73' THEN '1 to 4 years'
        WHEN employment_since_code = 'A74' THEN '4 to 7 years'
        WHEN employment_since_code = 'A75' THEN '>= 7 years'
    END AS employment_since_desc,

    other_debtors_guarantors_code,

    CASE
        WHEN other_debtors_guarantors_code = 'A101' THEN 'none'
        WHEN other_debtors_guarantors_code = 'A102' THEN 'co-applicant'
        WHEN other_debtors_guarantors_code = 'A103' THEN 'guarantor'
    END AS other_debtors_guarantors_desc,

    other_installment_plans_code,

    CASE
        WHEN other_installment_plans_code = 'A141' THEN 'bank'
        WHEN other_installment_plans_code = 'A142' THEN 'stores'
        WHEN other_installment_plans_code = 'A143' THEN 'none'
    END AS other_installment_plans_desc,

    existing_credits_bank

FROM (
    SELECT DISTINCT
        checking_account_status_code,
        credit_history_code,
        savings_account_bonds_code,
        employment_since_code,
        other_debtors_guarantors_code,
        other_installment_plans_code,
        existing_credits_bank
    FROM silver_german_credit_clean
) t;