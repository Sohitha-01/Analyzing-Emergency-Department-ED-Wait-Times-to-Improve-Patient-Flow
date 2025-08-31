# 🏥 Analyzing Emergency Department (ED) Wait Times to Improve Patient Flow

## 📝 Project Overview
Comprehensive analysis of emergency department (ED) wait times through data cleaning, exploratory data analysis (EDA), and SQL-based performance evaluation.  

The objective is to prepare a reliable dataset, uncover patterns affecting patient flow, and generate performance metrics that highlight departmental efficiency and bottlenecks. 

---

## 📑 Table of Contents
- [📂 Repo Structure](#-repo-structure)
- [🎯 Project Golas](#-project-Goals)
- [📊 Data](#-data)
- [⚡ Quick Start](#-quick-start)
- [🧹 Data Cleaning](#-data-cleaning)
- [🔎 Exploratory Data Analysis](#-exploratory-data-analysis)
- [📊 Visualizations](#-Visualizations)
- [🗄️ SQL Analytics](#️-sql-analytics)
- [📌 Results](#-results)
- [📜 License](#-license)

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
- 
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

## 🔍 Exploratory Data Analysis (EDA)
Exploratory Data Analysis was performed to understand the distribution, variability, and relationships within the emergency department (ED) dataset.  
The analysis focused on the following aspects:

- **Distribution of Wait Times**: Visualized using histograms and density plots to observe patterns in patient waiting behavior.  
- **Categorical Analysis**: Bar charts and count plots were used to examine patient volumes across age groups, departments, and admission types.  
- **Outlier Detection**: Boxplots highlighted extreme values in wait times, helping to identify anomalies.  
- **Trend Analysis**: Line plots captured variations in waiting times over different time intervals (hours, days, etc.).  
- **Correlation Analysis**: A heatmap and pairplots revealed relationships between wait times and other numerical features, providing insight into potential influencing factors.  

These findings formed the basis for identifying bottlenecks in patient flow and guided the SQL-based performance evaluation.

---

## 📊 Visualizations
Below are the key plots generated during the analysis. Click the links to view each visualization:

### Wait Time Distributions
[Wait Time Distribution](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235559.png)          [Patient Count by Category](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235614.png)         [Admissions by Department](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235640.png)         [Discharge Types](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235659.png)  

### Wait Times by Categories
[Wait Time by Admission Type](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235711.png)          [Wait Time by Patient Type](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235722.png)  

### Outlier Detection (Boxplots)
[Boxplot of Wait Times (Overall)](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235733.png)          [Boxplot by Department](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235753.png)          [Boxplot by Admission Type](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235805.png)  

### Performance Metrics
[Average Wait Times by Department](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235840.png)         [Average Wait Times by Admission Type](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235855.png)  

### Trends Over Time
[Wait Time Trends Over Time](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235910.png)  

### Correlation & Statistics
[Correlation Heatmap](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235927.png)          [Correlation Matrix Plot](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-30%20235953.png)         [Outlier Detection](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-31%20000008.png)         [Summary Statistics Plot](https://raw.githubusercontent.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/5b47c441ea89e8e9226cb120fc3df2caea41c10a/Images/Screenshot%202025-08-31%20000022.png)  

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
- 📄 **Full Report (PDF):** [ED_Wait_Times.pdf](https://github.com/Sohitha-01/Analyzing-Emergency-Department-ED-Wait-Times-to-Improve-Patient-Flow/blob/2896d5135fd728899393598ae638504c5975dcde/Report/ED_Wait_Times.pdf) 

---

## 📜 License
This project is open-source and licensed under MIT – feel free to use it.
