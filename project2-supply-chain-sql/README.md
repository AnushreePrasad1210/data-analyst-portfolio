# 🚚 Project 2: Global Supply Chain & Delivery Logistics Bottleneck Tracker

**Stack:** Python (ETL only) → MySQL → Advanced SQL  
**Scale:** 180,519 real orders | 53 columns | Kaggle public dataset

---

## Business Problem
A global e-commerce company needs to identify why over half its 
shipments arrive late, pinpoint exactly where in the logistics 
process the problem originates, and quantify the financial impact 
by product category — using SQL as the single source of truth, 
with no dashboarding tools involved.

---

## Dataset
**DataCo Smart Supply Chain for Big Data Analysis**  
Source: Kaggle (shashwatwork)  
- 180,519 order records
- 53 original columns (trimmed to 27 relevant columns during ETL)
- Real-world messy data: text-encoded nulls, regional aggregates, 
  mixed date formats

---

## What I Built

### ETL Pipeline (Python → MySQL)
- Loaded raw CSV into Pandas with `encoding='latin1'` 
  to handle special characters
- Trimmed 53 columns to 27 relevant ones — excluding PII fields 
  (Customer Email, Password, Name) as a responsible 
  data-handling practice
- Converted date columns from plain text to proper datetime format
- Loaded 180,519 rows into MySQL using SQLAlchemy 
  with `chunksize=5000` for memory efficiency

### SQL Analysis (8 Progressive Queries)

| Step | Query Type | Business Question |
|---|---|---|
| 1 | Aggregation | Overall late delivery rate |
| 2 | GROUP BY | Late rate by shipping mode |
| 3 | AVG comparison | Scheduled vs actual days per mode |
| 4 | CASE bucketing | Lateness distribution per mode |
| 5 | Delivery Status join | Verifying official vs derived late flag |
| 6 | RANK() OVER (PARTITION BY) | Regional ranking within each market |
| 7 | DATE_FORMAT() + GROUP BY | Monthly trend analysis (2015–2018) |
| 8 | CTE + Window Function | Category revenue-at-risk ranking |

---

## Key Business Findings

### Finding 1: Scale of the Problem
- **54.83%** of all 180,519 orders are flagged as late delivery risk
- This is a company-threatening statistic affecting 
  more than half of all customer shipments

### Finding 2: Root Cause Identified
- First Class shipping has a **structurally impossible** 
  1-day delivery promise
- **100% of its 27,814 orders miss by exactly 1 day** 
  — zero variance, zero exceptions
- This is not operational failure — it's a systematic 
  SLA misconfiguration
- First Class is actually the **fastest** shipping mode 
  in absolute terms (2.00 days avg) vs Standard Class 
  (4.00 days avg)

### Finding 3: Global, Not Regional
- All 5 markets show nearly identical late rates (54.36%–55.21%)
- All 26 regions show rates between 52%–58%
- **Canada** is the only meaningful positive outlier at 48.80%
- This rules out "bad warehouse" or "regional logistics failure" 
  as the cause — the problem is systemic

### Finding 4: Persistent — 3+ Years Unchanged
- Monthly trend analysis (Jan 2015 – Jan 2018) shows 
  ~55% late rate every single month with no improvement
- The company either never noticed or never actioned this problem

### Finding 5: Financial Stakes
- Fishing category: **$978,169** revenue tied to 
  broken First Class promises (rank 1)
- Every product category shows ~95% late rate 
  within First Class — confirming it's the mode, 
  not the product

### Recommendation
Recalibrate First Class SLA from 1 day to 2 days. 
Since First Class is already the fastest shipping mode 
in absolute terms, the fix is the **promise**, not the process.

---

## Files in This Folder
| File | Description |
|---|---|
| `02_supply_chain_bottleneck_analysis.ipynb` | Python ETL loading script |
| `supply_chain_analysis.sql` | All 8 SQL queries with business context comments |
| `result_overall_late_rate.csv` | Query 1 result: 54.83% overall late rate |
| `result_shipping_mode_breakdown.csv` | Query 2 result: late rate by shipping mode |
| `result_category_revenue_risk.csv` | Query 8 result: top 10 categories by revenue at risk |

---

## Technical Challenges & Learnings
- CSV required `encoding='latin1'` — default UTF-8 would 
  have failed on special characters in customer names
- MySQL connection string required URL-encoding of 
  special characters in password using `urllib.parse.quote_plus()`
- `OperationalError: no such table` was caused by a 
  path typo creating two separate database files — 
  diagnosed using `sqlite_master` system query pattern 
  (same technique as Project 1)
- Discovered that `Late_delivery_risk` flag uses different 
  logic than simple day-count comparison — documented 
  transparently as a limitation rather than ignoring the discrepancy
