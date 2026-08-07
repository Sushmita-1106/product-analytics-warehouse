import duckdb, os

os.makedirs("data/marts", exist_ok=True)
con = duckdb.connect(r'C:\Users\LENOVO\Product Analysis Warehouse\warehouse.duckdb')

for table in ["fct_sessions", "dim_users", "funnel_steps", "retention_cohorts", "user_ltv"]:
    con.sql(f"COPY {table} TO 'data/marts/{table}.parquet' (FORMAT PARQUET)")
    print(f"Exported {table}")