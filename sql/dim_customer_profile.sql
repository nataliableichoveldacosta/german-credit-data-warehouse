CREATE TABLE dim_customer_profile AS
SELECT
    ROW_NUMBER() OVER () AS customer_profile_key,
    personal_status_sex_code,
    CASE
        WHEN personal_status_sex_code = 'A91' THEN 'male_divorced_separated'
        WHEN personal_status_sex_code = 'A92' THEN 'female_divorced_separated_married'
        WHEN personal_status_sex_code = 'A93' THEN 'male_single'
        WHEN personal_status_sex_code = 'A94' THEN 'male_married_widowed'
        WHEN personal_status_sex_code = 'A95' THEN 'female_single'
    END AS personal_status_sex_desc,
    age_years,
    job_code,
    CASE
        WHEN job_code = 'A171' THEN 'unemployed_unskilled_non_resident'
        WHEN job_code = 'A172' THEN 'unskilled_resident'
        WHEN job_code = 'A173' THEN 'skilled_employee_official'
        WHEN job_code = 'A174' THEN 'management_self_employed_highly_qualified_officer'
    END AS job_desc,
    liable_people_count,
    telephone_code,
    CASE
        WHEN telephone_code = 'A191' THEN 'none'
        WHEN telephone_code = 'A192' THEN 'yes_registered_under_customer_name'
    END AS telephone_desc,
    foreign_worker_code,
    CASE
        WHEN foreign_worker_code = 'A201' THEN 'yes'
        WHEN foreign_worker_code = 'A202' THEN 'no'
    END AS foreign_worker_desc
FROM (
    SELECT DISTINCT
        personal_status_sex_code,
        age_years,
        job_code,
        liable_people_count,
        telephone_code,
        foreign_worker_code
    FROM silver_german_credit_clean
) t;