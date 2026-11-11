# Food & Agri Commodity Price Analysis (2016–2026)

An end-to-end analysis of global food and agricultural commodity prices: data collection with source records, cleaning, trend and volatility analysis, seasonality, a backtested 6-month outlook, a 2-page Power BI dashboard and a 1-page market brief.

## Business question

How have the prices of key food and agri commodities behaved over the last 10+ years? Which are the most volatile, do they follow seasonal patterns, and what is a reasonable short-term outlook (with an honest range of uncertainty)?

## Data

- **Source:** World Bank Commodity Price Data ("The Pink Sheet"), monthly prices in nominal US dollars, 1960 to October 2026 (file updated 3 Nov 2026).
- **Commodities analysed:** Rice (Thai 5%), Wheat (US HRW), Maize, Sugar (world), Palm oil, Coconut oil, Tea (Kolkata auction), Rubber (RSS3). Tea (average of 3 auctions) is added as a comparison series.
- **Units differ** ($/mt vs $/kg), so comparisons use percentage changes and indexed prices, never raw prices across units.
- **Limitation:** these are global benchmark prices in US dollars, not Indian local-market (mandi) prices.
- Full source record: `docs/source_log.xlsx`.
- Attribution: World Bank Commodity Price Data (The Pink Sheet). Please check the World Bank's current terms of use before reusing the data.

## Tools

Python (pandas, matplotlib, seaborn) in Jupyter, Power BI Desktop, Excel (inspection and source log).

## Workflow

1. **Collect and record:** downloaded the raw file, left it untouched in `data_raw/`, and wrote a source log.
2. **Clean:** promoted the real header row, separated units, converted the "…" missing-value marker to proper missing values, converted text dates (`1960M01`) to real dates, checked for duplicate dates (none, 802 monthly rows).
3. **Descriptive analysis:** yearly averages and year-on-year % change.
4. **Volatility:** standard deviation of monthly % change over the last 10 years.
5. **Data check:** investigated an unusually large tea spike by comparing four tea benchmarks.
6. **Seasonality:** each month's price as a % of its own year's average, averaged over 2016–2025 (complete years only).
7. **Forecast with a baseline:** rolling backtest (Oct 2021 – Apr 2026) of three simple methods (naive, 12-month average, seasonal naive) at a 6-month horizon, measured by mean absolute percentage error. The best method per commodity gives the April 2027 outlook, with a likely range taken from the 10th–90th percentile of its past errors.
8. **Dashboard and brief:** 2-page Power BI report and a 1-page written market brief.

## Key findings (October 2026)

- **Year-on-year:** rubber +42%, rice +37%, wheat +37%, sugar +26%, maize +14%, palm oil +8%; Kolkata tea −11%, coconut oil −20%.
- **Volatility:** Kolkata tea is by far the most volatile (17.9), about twice the next (coconut oil, 8.0); rice is the most stable (5.3).
- **Tea check:** Kolkata tea jumped 87% in June 2020 and stayed high, while the 3-auction average (volatility about 5.2) did not. The cause was not verified in this project.
- **Seasonality:** Kolkata tea is about 32% below its yearly average in March and about 23% above in July. The other commodities are weakly seasonal (mostly within ±7%).
- **Forecasting:** the simple "price stays at today's level" guess was hardest to beat for most commodities. A seasonal method won only for Kolkata tea (about 12% error vs 33%). Example: rice at $489/mt now, with a likely range of about $399–$592/mt by April 2027.

## Repository structure

```
Commodity_Price_Project/
├── data_raw/        original World Bank file (never edited)
├── data_clean/      cleaned price table and units lookup (CSV)
├── notebooks/       Jupyter notebook with the full analysis
├── outputs/         charts, Power BI file (.pbix), dashboard PDF, outlook table
└── docs/            source log and market brief
```

## How to reproduce

1. Download the monthly Pink Sheet Excel file from the World Bank Commodity Markets page and place it in `data_raw/`.
2. Open the notebook in `notebooks/` and run the cells from top to bottom (requires Python with pandas, matplotlib, seaborn, openpyxl).
3. Open the `.pbix` file in Power BI Desktop (if file paths differ on your machine, update the data source paths).

## Limitations

- Global benchmark prices, not local Indian prices.
- Forecasts use simple baseline methods; the likely range is based on past errors and is not a guarantee. Backtest windows overlap, so the ranges are a rough guide.
- Seasonality is estimated from 10 years of data and can change.


