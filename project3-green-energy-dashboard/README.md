# 🌍 Project 3: Global Green Energy Investment & Carbon Footprint Executive Dashboard

**Stack:** Power BI Desktop | OWID Public Datasets  
**Scale:** 189 countries | 2000–2024 | Two joined real-world datasets

---

## Business Problem
Policy makers, ESG investors, and energy analysts need a single 
executive view of the global clean energy transition — which 
countries lead, which lag, whether the world's CO₂ emissions 
are trending in the right direction, and how these two stories 
(renewables adoption vs. emissions growth) relate to each other 
geographically and over time.

---

## Data Sources
| Dataset | Source | Coverage |
|---|---|---|
| CO₂ & Greenhouse Gas Emissions | Our World in Data (OWID) | 189 countries, 1750–2024 |
| Energy Mix (Renewables/Fossil) | Our World in Data (OWID) | 189 countries, 1965–2024 |

Both datasets are publicly available at:
- github.com/owid/co2-data
- github.com/owid/energy-data

Filtered to **2000–2024** for the dashboard (pre-2000 data has 
significant gaps in energy-mix columns for most countries).

---

## What I Built

### Data Modeling (Power Query + DAX)
- Imported two separate OWID CSV datasets into Power BI
- Created a **DAX-computed bridge column** (`CountryYearKey`) 
  combining country name and year into a single join key — 
  necessary because Power BI doesn't natively support 
  multi-column relationships between tables
- Resolved multiple real data quality issues during import:
  - Text-encoded `"null"` values blocking numeric conversion 
    across three energy columns — fixed using Power Query 
    Replace Values before type conversion
  - Regional aggregate contamination (e.g., "Africa (EIA)," 
    "Asia (Ember)," "World") mixed into the country list — 
    removed using iso_code blank-filter on CO₂ table and 
    parenthesis text-filter on energy table
  - Range slicer accidentally spanning 2023–2025 instead of 
    single-year — diagnosed and fixed, reducing CO₂ KPI 
    from inflated 74.39K to correct 36.96K Mt

### Dashboard Visuals (6 visuals, 4 KPI cards)
| Visual | Purpose |
|---|---|
| Choropleth World Map | Renewable energy share by country (color gradient) |
| CO₂ Trend Line (2000–2024) | Historical emissions trajectory |
| Top 15 Bar Chart (green) | Highest renewable share countries |
| Bottom 15 Bar Chart (red) | Lowest renewable share countries |
| Year Dropdown Slicer | Filter map and bar charts to single year |
| 4 KPI Cards | Global avg renewable %, total CO₂, country count, top country |

---

## Key Business Findings

### Finding 1: Global Renewable Share Is Still Low
- Global average renewable energy share (2023): **16.93%**
- Meaning: **83%** of the world's energy still comes from 
  non-renewable sources despite decades of climate commitments

### Finding 2: Geography Drives Leadership More Than Policy
- **Iceland (78%)** and **Norway (70%)** lead globally — 
  both driven by geothermal and hydropower geography, 
  not just climate policy
- **Turkmenistan (~0%)** and **Trinidad & Tobago (~0%)** 
  sit at the bottom — gas-rich economies with no 
  geographic pressure to transition

### Finding 3: CO₂ Emissions Are Stubbornly Rising
- Global CO₂ emissions (2023): **36.96K million tonnes** 
  — verified against real-world published data
- Two visible dips: **2008 financial crisis** and 
  **2020 COVID-19 pandemic**
- Both recovered fully within 1-2 years and resumed 
  upward trajectory — confirming economic disruption 
  alone doesn't bend the emissions curve
- Structural decarbonization, not recession, 
  is what's needed to produce lasting change

### Finding 4: Data Integrity Verified
- All KPI figures cross-checked against real-world 
  published sources before finalizing dashboard
- CO₂ figure (36.96K Mt) matches OWID's published 
  2023 global total within rounding margin

---

## Files in This Folder
| File | Description |
|---|---|
| `Green_Energy_Carbon_Dashboard.pbix` | Full Power BI dashboard file |
| `owid-co2-data.csv` | CO₂ emissions source data (13.7 MB) |
| `owid-energy-data.csv` | Energy mix source data (8.8 MB) |
| `dashboard_screenshot.png` | Final dashboard preview |
| `README.md` | This file |

---

## Technical Challenges & Learnings
- Power BI map visuals are disabled by default at 
  organizational/account level — required signing out 
  of organizational account and using personal account 
  to enable Bing Maps geocoding
- Multi-column relationships (country + year) are not 
  natively supported in Power BI — resolved using a 
  DAX-computed concatenated key column, a standard 
  real-world workaround
- Text "null" vs genuine null distinction: Power Query 
  reads some empty CSV cells as the literal text 
  string "null" rather than a genuine blank — 
  must be replaced before numeric type conversion
- Range slicer vs single-year slicer: Power BI's 
  default "Between" slicer style spans a range, 
  causing multi-year aggregation — fixed by switching 
  to Dropdown style for true single-year filtering
- Cross-filtering between doctor segmentation and 
  territory charts requires a direct or indirect 
  relationship path — confirmed via bridge table 
  pattern (doctor_segmentation → doctors_registry 
  → full_sales_transactions)
