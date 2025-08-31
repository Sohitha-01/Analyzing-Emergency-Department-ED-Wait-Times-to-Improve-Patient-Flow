# 🏥 Analyzing Emergency Department (ED) Wait Times to Improve Patient Flow

**Author:** Sohitha Kommineni  
**License:** MIT  

> This project focuses on **data cleaning, exploratory data analysis (EDA), and SQL analytics** for emergency department (ED) wait times.  
> The analysis uses a synthetic/open dataset sourced from **Kaggle** (`Hospital ER_Data.csv`) and produces a cleaned dataset (`er_clean.csv`) along with SQL-based performance metrics.  

📄 **Full Report (PDF):** [ED_Wait_Times.pdf](https://github.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/blob/2896d5135fd728899393598ae638504c5975dcde/Report/ED_Wait_Times.pdf)  

---

## 📑 Table of Contents
- [🎯 Project Goals](#-project-goals)
- [📊 Data](#-data)
- [📂 Repo Structure](#-repo-structure)
- [⚡ Quick Start](#-quick-start)
- [🧹 Data Cleaning](#-data-cleaning)
- [🔎 Exploratory Data Analysis](#-exploratory-data-analysis)
- [🗄️ SQL Analytics](#️-sql-analytics)
- [📌 Results](#-results)
- [📜 License](#-license)

---

## 🎯 Project Goals
- Analyze **ED wait times** and admission trends.  
- Identify **patterns in demographics, departments, and wait times**.  
- Build a reproducible pipeline for:  
  1. Data Cleaning (Python + SQL)  
  2. Exploratory Data Analysis (Python)  
  3. SQL Queries (aggregates, KPIs, trends)  

---

## 📊 Data
- **Source**: [Kaggle Dataset](https://www.kaggle.com/)  
- **Raw dataset**: `Hospital ER_Data.csv`  
- **Cleaned dataset**: `er_clean.csv`  

---

## 📂 Repo Structure
```
Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/
├─ Data/
│  ├─ Hospital ER_Data.csv         # Raw dataset
│  ├─ er_clean.csv                 # Cleaned dataset
├─ Notebooks/
│  ├─ 01_cleaning.ipynb            # Python notebook for cleaning
│  └─ 02_eda.ipynb                 # Python notebook for EDA
├─ SQL/
│  ├─ 01_data_cleaning.sql
│  ├─ 02_data_quality.sql
│  ├─ 03_feature_engineering.sql
│  ├─ 04_aggregate_time_category.sql
│  ├─ 05_kpi_calculations.sql
│  ├─ 06_trend_analysis.sql
│  ├─ 07_category_performance.sql
│  └─ 08_monitoring_queries.sql
├─ Report/
│  └─ ED_Wait_Times.pdf
├─ Images/
│  └─ EDA plots (PNG)
├─ requirements.txt
└─ README.md
```

---

## ⚡ Quick Start
```bash
# Clone the repo
git clone https://github.com/<your-username>/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow.git
cd Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow

# Create environment
python -m venv .venv
source .venv/bin/activate     # Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run cleaning script
python src/clean_data.py --in Data/Hospital_ER_Data.csv --out Data/er_clean.csv

# Run EDA
python src/eda_report.py --in Data/er_clean.csv --out Images/
```

---

## 🧹 Data Cleaning
- Converted `Patient Admission Date` into time parts (`Year`, `Month`, `Day`, `Weekday`, `Hour`).  
- Created `AgeGroup` buckets.  
- Created flags:  
  - `AdmissionStatus` (Admitted / Not Admitted)  
  - `Within30min` (Waittime <= 30 mins).  

---

## 🔎 Exploratory Data Analysis

### Age Distribution
![Age Distribution](https://github.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/blob/main/Images/age_distribution.png?raw=true)  

### Gender Distribution
![Gender Distribution](https://github.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/blob/main/Images/gender_distribution.png?raw=true)  

### Race Distribution
![Race Distribution](https://github.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/blob/main/Images/race_distribution.png?raw=true)  

### Wait Time Distribution
![Waittime Distribution](https://github.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/blob/main/Images/waittime_distribution.png?raw=true)  

### Avg Wait Time by Department
![Wait by Department](https://github.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/blob/main/Images/avg_wait_by_department.png?raw=true)  

---

## 🗄️ SQL Analytics
SQL scripts mirror the analysis pipeline:  
- **01_data_cleaning.sql** – create staging & clean tables.  
- **02_data_quality.sql** – missing values & validation checks.  
- **03_feature_engineering.sql** – derived features.  
- **04_aggregate_time_category.sql** – temporal & categorical breakdowns.  
- **05_kpi_calculations.sql** – KPIs (avg wait, satisfaction, admission rate).  
- **06_trend_analysis.sql** – daily/monthly trends.  
- **07_category_performance.sql** – departmental & demographic performance.  
- **08_monitoring_queries.sql** – monitoring queries for ongoing use.  

---

## 📌 Results
- 🚑 Most ED visits are concentrated during **weekday daytime hours**.  
- 🕒 Average wait times vary significantly by department.  
- 🏥 **Admission flag** and **wait times** are correlated (non-admitted patients wait longer).  
- 📉 Patient satisfaction decreases with higher wait times.  

---

## 📜 License
MIT © 2025 Sohitha Kommineni
