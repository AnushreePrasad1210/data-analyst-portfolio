# 📊 Data Analyst Portfolio — Anushree Prasad

**B.Tech | Applied Electronics & Instrumentation | College of Engineering Trivandrum**

A portfolio of three end-to-end, corporate-grade data analytics projects 
built from scratch — demonstrating the full analyst stack: 
data engineering, SQL analysis, Excel business logic, 
and Power BI executive dashboarding.

---

## 🛠️ Core Technical Skills

| Category | Tools & Technologies |
|---|---|
| **Languages** | Python (Pandas, NumPy, Faker, SQLAlchemy), SQL |
| **Databases** | MySQL, SQLite |
| **Visualization** | Power BI Desktop, Microsoft Excel Online |
| **SQL Techniques** | Window Functions (RANK, LAG), CTEs, Multi-table JOINs, Subqueries |
| **Excel** | IFS, XLOOKUP, INDEX/MATCH, PERCENTRANK, Pivot Tables, Data Validation |
| **Concepts** | ETL Pipelines, Relational Data Modeling, EDA, KPI Design, Dashboard UX |

---

## 📁 Projects

---

### 🏥 Project 1: End-to-End Enterprise Pharma Sales Analytics Pipeline
**Stack:** Python → SQLite → Excel Online → Power BI

**Business Problem:** A pharmaceutical company needs to track sales 
representative performance, calculate incentive payouts, 
segment doctor relationships, and monitor territory-level 
target achievement — all from a single, unified data pipeline.

**What I Built:**
- Generated a synthetic 50,000+ transaction relational database 
  (Sales, Medical Representatives, Doctors) using Python's Faker library
- Deliberately injected realistic data quality issues 
  (missing values, duplicates, inconsistent casing) 
  to simulate real enterprise data
- Wrote advanced SQL queries using Window Functions 
  (RANK OVER PARTITION BY territory) and LAG() for 
  month-over-month doctor churn risk detection
- Built a live Excel Online Incentive Calculator using 
  IFS() tier logic, XLOOKUP() bonus lookup, 
  PERCENTRANK() doctor segmentation, and INDEX/MATCH 
  for dynamic top-performer identification
- Designed a 5-KPI Power BI executive dashboard with 
  full cross-filtering across product, territory, 
  and doctor segment dimensions

**Key Findings:**
- Identified top MR (Sean Fisher DVM) generating ₹27.5 Cr 
  in total revenue across the synthetic period
- East Zone missed its sales target by 30.6%, 
  flagging it as the highest-priority territory 
  for management intervention
- 697 doctor-months flagged as "at-risk" using LAG()-based 
  month-over-month revenue decline detection

**Files:**
- `pharma_pipeline.ipynb` — Python ETL & SQL analysis notebook
- `Pharma_Sales_Dashboard_Project1.pbix` — Power BI dashboard
- `Pharma_Sales_Dashboard_Project1.xlsx` — Excel calculator & dashboard
- `screenshots/` — Dashboard screenshots

---

### 🚚 Project 2: Global Supply Chain & Delivery Logistics Bottleneck Tracker
**Stack:** Python (ETL only) → MySQL → Advanced SQL

**Business Problem:** A global e-commerce company with 180,000+ 
order records needs to identify why over half its shipments 
arrive late, and pinpoint exactly where in the logistics 
process the problem originates.

**What I Built:**
- Loaded and cleaned the DataCo Smart Supply Chain 
  Kaggle dataset (180,519 rows, 53 columns) 
  into MySQL using a Python ETL script
- Wrote 8 progressively advanced SQL queries covering: 
  overall late delivery rate, shipping mode breakdown, 
  scheduled vs. actual delivery day comparison, 
  CASE-based lateness bucketing, geographic ranking 
  using RANK() OVER (PARTITION BY market), 
  monthly trend analysis using DATE_FORMAT(), 
  and a final CTE + window function combining 
  product category with revenue-at-risk calculation

**Key Findings:**
- **54.83%** of all orders are flagged as late — 
  a company-threatening statistic
- Root cause identified: First Class shipping promises 
  1-day delivery but consistently takes 2 days — 
  literally 100% of First Class orders miss their 
  promise by exactly 1 day, with zero variance, 
  pointing to a structural SLA misconfiguration 
  rather than operational failure
- The problem is global and systemic — all 5 markets 
  show nearly identical late rates (~54-55%), 
  with Canada as the only notable positive outlier (48.8%)
- Problem has persisted unchanged for 3+ years 
  (2015-2018), suggesting it was never actioned
- Fishing category has the highest revenue at risk 
  (~$978K tied to broken First Class promises)

**Recommendation:** Recalibrate First Class SLA from 
1 day to 2 days — since First Class is already the 
fastest shipping mode in absolute terms, 
the fix is the promise, not the process.

**Files:**
- `etl_load.ipynb` — Python ETL loading script
- `supply_chain_analysis.sql` — All 8 SQL queries with comments
- `screenshots/` — Query result screenshots

---

### 🌍 Project 3: Global Green Energy Investment & Carbon Footprint Executive Dashboard
**Stack:** Power BI Desktop (OWID public datasets)

**Business Problem:** Policy makers and ESG investors need a 
single executive view of the global clean energy transition — 
which countries lead, which lag, and whether the world's 
CO₂ emissions are trending in the right direction.

**What I Built:**
- Imported and joined two Our World in Data (OWID) 
  public datasets (CO₂ emissions + energy mix) 
  via a DAX-computed CountryYearKey bridge column
- Resolved multiple real data quality issues: 
  text-encoded null values blocking numeric conversion, 
  regional aggregate contamination in the country list, 
  and a range slicer accidentally spanning multiple years
- Built a 6-visual Power BI dashboard: 
  world choropleth map (renewable share by country), 
  CO₂ trend line (2000–2024), 
  Top 15 / Bottom 15 country ranked bar charts, 
  and 4 KPI cards — all with consistent 
  green/red thematic color coding

**Key Findings:**
- Global average renewable energy share in 2023: **16.93%**
- Global CO₂ emissions in 2023: **36.96K million tonnes** 
  (matches real-world verified figures)
- Iceland (78%+) and Norway (70%+) lead globally — 
  both driven by geography (geothermal/hydro), 
  not just policy
- Turkmenistan and Trinidad & Tobago sit at essentially 
  0% renewable share — almost entirely gas-based economies
- CO₂ emissions show a persistent upward trend despite 
  two visible dips (2008 financial crisis, 2020 COVID) — 
  both fully recovered within 1-2 years, 
  confirming structural decarbonization 
  (not economic disruption) is what bends the curve

**Files:**
- `Green_Energy_Carbon_Dashboard.pbix` — Power BI dashboard
- `owid-co2-data.csv` — Source dataset (OWID)
- `owid-energy-data.csv` — Source dataset (OWID)
- `screenshots/` — Dashboard screenshots

---

## 📬 Contact

- **LinkedIn:** [linkedin.com/in/anushreeprasad](#) 
- **Email:** *(anushreeanu703@gmail.com)*
- **Location:** Thiruvananthapuram, Kerala, India

---

*All projects built independently as part of a structured 
self-directed learning program targeting 
Data Analyst roles at product-based tech, 
engineering, and financial firms.*
