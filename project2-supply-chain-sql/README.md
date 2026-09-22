# Project 2: Global Supply Chain & Delivery Logistics Bottleneck Tracker

**Stack:** Python (ETL) → MySQL → Advanced SQL

## Files in This Folder
- `02_supply_chain_bottleneck_analysis.ipynb` — Python ETL loading script
- `supply_chain_analysis.sql` — All SQL queries with business context comments
- Screenshots of key query results

## Dataset
DataCo Smart Supply Chain Dataset (Kaggle)
180,519 orders | 53 columns | Real-world messy data

## Key Finding
54.83% of all orders are late — root cause identified as a 
structural SLA misconfiguration in First Class shipping 
(promises 1 day, consistently takes 2 days, 
with literally zero variance across all 27,814 orders).
