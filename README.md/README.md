# Product Analytics Warehouse

An end-to-end analytics pipeline that transforms raw GA4 e-commerce events into business-ready insights — funnel analysis, retention curves, and lifetime value — using DuckDB, dbt, Python, and Power BI.

## Architecture
Raw GA4 events (BigQuery public dataset, queried via SQL)
→ DuckDB (local SQL warehouse)
→ dbt models (staging → intermediate → marts)
→ Power BI dashboard

## Key definitions
- **Session**: ends after 30 minutes of user inactivity.
- **Retention**: users grouped by the week of their first active session and tracked across subsequent weeks.
- **LTV**: historical average order value × number of orders per user.

## How to run this project
1. `pip install -r requirements.txt`
2. Load data: `python python/load_to_duckdb.py`
3. Run transformations: `cd warehouse && dbt run`
4. Run tests: `dbt test`
5. View lineage: `dbt docs generate && dbt docs serve`

## Results
- Evaluated end-to-end conversion efficiency across user sessions.
- Biggest funnel drop-off observed: view → add-to-cart (~20% conversion rate).

## Screenshots
![Lineage Graph](screenshots/lineage_graph.png)
![Dashboard](screenshots/dashboard_overview.png)

## Tech stack
DuckDB, dbt-duckdb, Python, Power BI, Git/GitHub