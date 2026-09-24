# Real-World Evidence (RWE) Chronic Disease Cohort Analysis (SQL)

## 📌 Project Overview
This project simulates a Real-World Evidence (RWE) cohort study analyzing healthcare outcomes for a large population of diabetic patients. The objective is to evaluate the clinical efficacy of different treatment regimens (e.g., Metformin vs. Insulin) by analyzing long-term metrics such as hospital readmission rates and glycemic control parameters.

## 🧪 Database Architecture
The analytical environment utilizes a multi-table relational schema linked via patient metrics:
* **`Patient_Demographics`**: Captures patient profiles, age, gender, and geographical identifiers.
* **`Prescriptions`**: Tracks specific pharmaceutical agents prescribed, dosage duration, and frequency.
* **`Hospital_Visits`**: Logs admissions, lengths of stay, discharge dispositions, and readmission timelines.

## 📊 Core Analytical Metrics Evaluated

### 1. Treatment Efficacy & Retention Profiles
Calculates the average days to hospital readmission across distinct drug regimens, ignoring small-sample therapeutic classes (<500 prescriptions) to maintain statistical integrity.
```sql
SELECT 
    drug_name,
    COUNT(prescription_id) AS total_prescriptions,
    AVG(days_to_readmission) AS average_days_to_readmission
FROM 
    prescriptions AS p
LEFT JOIN 
    hospital_visits AS h ON p.patient_id = h.patient_id
GROUP BY 
    drug_name
HAVING 
    COUNT(prescription_id) >= 500;
```

## 🛠️ Tech Stack Employed
* **Language:** Structured Query Language (SQL)
* **Framework Focus:** Advanced Aggregations (`GROUP BY`, `HAVING`), Relational Joins (`LEFT JOIN`), Mathematical Reductions (`AVG`, `COUNT`).
* **Domain Context:** Real-World Evidence (RWE), Health Economics and Outcomes Research (HEOR).
