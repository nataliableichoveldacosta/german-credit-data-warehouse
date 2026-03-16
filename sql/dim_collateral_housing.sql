CREATE TABLE dim_collateral_housing AS
SELECT
    ROW_NUMBER() OVER () AS collateral_housing_key,
    property_code,
    CASE
        WHEN property_code = 'A121' THEN 'real_estate'
        WHEN property_code = 'A122' THEN 'building_society_savings_or_life_insurance'
        WHEN property_code = 'A123' THEN 'car_or_other_property'
        WHEN property_code = 'A124' THEN 'unknown_or_no_property'
    END AS property_desc,
    housing_code,
    CASE
        WHEN housing_code = 'A151' THEN 'rent'
        WHEN housing_code = 'A152' THEN 'own'
        WHEN housing_code = 'A153' THEN 'for_free'
    END AS housing_desc,
    present_residence_since
FROM (
    SELECT DISTINCT
        property_code,
        housing_code,
        present_residence_since
    FROM silver_german_credit_clean
) t;