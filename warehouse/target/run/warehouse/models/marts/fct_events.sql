
  
  create view "warehouse"."main"."fct_events__dbt_tmp" as (
    select
    session_id,
    user_pseudo_id,
    event_name,
    event_ts_utc,
    page_location,
    page_title,
    device_category,
    country,
    traffic_source,
    purchase_revenue
from "warehouse"."main"."int_sessions"
  );
