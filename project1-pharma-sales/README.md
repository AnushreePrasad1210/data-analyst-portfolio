# 🏥 Project 1: End-to-End Enterprise Pharma Sales Analytics Pipeline

**Stack:** Python → SQLite → Excel Online → Power BI  
**Scale:** 50,300 synthetic transactions | 3 relational tables | 4 tools

---

## Business Problem
A pharmaceutical company needs to track Medical Representative (MR) 
performance, calculate incentive payouts dynamically, segment doctor 
relationships by engagement level, and monitor territory-level target 
achievement — all from a unified, end-to-end data pipeline.

---

## What I Built

### Layer 1 — Python (Data Engineering)
- Generated a synthetic 50,000+ transaction relational database 
  using Python's Faker library with a fixed random seed 
  for reproducibility
- Designed a 3-table relational schema: Sales, Medical Representatives, 
  Doctors — mirroring real enterprise database architecture
- Deliberately injected realistic data quality issues: 
  1,003 missing unit prices, 757 missing quantities, 
  300 duplicate rows, and inconsistent product name casing 
  across 5% of records

### Layer 2 — SQL (Advanced Analytics)
- Loaded cleaned data into SQLite using SQLAlchemy
- Wrote 6 progressively complex SQL queries:
  - Revenue aggregation by product, MR, and territory
  - `RANK() OVER (PARTITION BY territory)` — ranking MRs 
    within their own territory (not just globally)
  - `LAG()` + CTE for month-over-month doctor revenue 
    trend analysis — flagging 697 doctor-months as "at-risk" 
    (>50% revenue drop vs. prior month)

### Layer 3 — Excel Online (Business Calculator)
- Built a live Sales Rep Incentive Calculator using:
  - `IFS()` for 4-tier performance classification 
    (Bronze/Silver/Gold/Platinum)
  - `XLOOKUP()` for dynamic bonus rate lookup against 
    a reference table
  - `PERCENTRANK.INC()` for doctor engagement percentile scoring
  - `INDEX/MATCH` for top-performer identification
- Built Territory Performance tracker with `SUMIF()` 
  and target achievement % — East Zone flagged as 
  "Missed" at 69.4% achievement
- Built Doctor Segmentation table classifying 200 doctors 
  into KOL / High Value / Standard / Low Engagement tiers

### Layer 4 — Power BI (Executive Dashboard)
- Imported 4 CSVs and modeled relationships 
  via `doctor_id` and `mr_id` foreign keys
- Built 5-visual executive dashboard with full cross-filtering:
  Revenue by Product, Revenue by Territory, 
  Doctor Segment Distribution, Territory Slicer, 3 KPI Cards
- Dashboard verified: Total Revenue ₹12.91bn | 
  200 Doctors | 50 MRs

---

## Key Business Findings
- **Top MR:** Sean Fisher DVM — ₹27.5 Cr total revenue
- **Territory gap:** East Zone missed target by 30.6% 
  (₹338 Cr actual vs. ₹487 Cr target) — highest priority 
  for management intervention
- **Doctor churn risk:** 697 doctor-months flagged using 
  LAG()-based month-over-month decline detection
- **Incentive budget:** Total company-wide bonus liability 
  of ₹72.8 Cr across all 50 MRs

---

## Files in This Folder
| File | Description |
|---|---|
| `01_pharma_sales_master_pipeline.ipynb` | Python ETL + SQL analysis notebook |
| `Pharma_Sales_PowerBI_Dashboard.pbix` | Power BI executive dashboard |
| `Pharma_Sales_Dashboard_Project1.xlsx` | Excel incentive calculator + dashboard |
| `mr_incentive_summary.csv` | MR-level revenue and incentive data |
| `doctor_segmentation.csv` | Doctor percentile ranking and segments |
| `doctors_registry.csv` | Doctor reference table |
| `excel_dashboard.png` | Excel dashboard screenshot |
| `powerbi_dashboard.png` | Power BI dashboard screenshot |
| `live_calculator.png` | Live what-if calculator screenshot |

---

## Technical Challenges & Learnings
- Resolved a `PermissionError` on CSV export caused by 
  a file locked by VS Code's open tab — diagnosed and fixed
- Identified and corrected a database path typo 
  (`pharma_sales_db` vs `pharma_sales.db`) causing 
  an empty SQLite database — diagnosed using 
  `sqlite_master` system query
- Excel Online's PivotChart-slicer cross-filtering 
  showed platform-specific limitations not present 
  in desktop Excel — documented and resolved 
  by migrating to Power BI for full interactivity
