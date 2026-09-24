-- =====================================================================
-- PROJECT: REAL-WORLD EVIDENCE (RWE) DIABETES COHORT STUDY
-- ROLE: HEALTHCARE DATA ANALYST / EPIDEMIOLOGIST
-- =====================================================================

-- ---------------------------------------------------------------------
-- ANALYSIS 1: TREATMENT GROUP READMISSION BENCHMARKING
-- This query computes total prescriptions and tracks how long patients 
-- go before being readmitted. We filter out rare drugs (< 500 cases) 
-- using HAVING to prevent sample bias.
-- ---------------------------------------------------------------------
SELECT 
    p.drug_name,
    COUNT(p.prescription_id) AS total_patients_prescribed,
    AVG(h.days_to_readmission) AS avg_days_before_readmission,
    MIN(h.days_to_readmission) AS fastest_readmission,
    MAX(h.days_to_readmission) AS longest_readmission
FROM 
    prescriptions AS p
LEFT JOIN 
    hospital_visits AS h ON p.patient_id = h.patient_id
GROUP BY 
    p.drug_name
HAVING 
    COUNT(p.prescription_id) >= 500
ORDER BY 
    avg_days_before_readmission DESC;


-- ---------------------------------------------------------------------
-- ANALYSIS 2: RISK CORRELATION (EMERGENCY STAY LENGTH BY DEMOGRAPHIC)
-- Evaluates if specific populations experience prolonged hospital stays. 
-- Groups the metrics by gender and age categories for high-risk tracking.
-- ---------------------------------------------------------------------
SELECT 
    d.gender,
    d.age,
    COUNT(h.visit_id) AS total_logged_admissions,
    AVG(h.length_of_stay_days) AS average_days_hospitalized
FROM 
    patient_demographics AS d
INNER JOIN 
    hospital_visits AS h ON d.patient_id = h.patient_id
WHERE 
    h.admission_type = 'Emergency'
GROUP BY 
    d.gender, 
    d.age
ORDER BY 
    average_days_hospitalized DESC;
