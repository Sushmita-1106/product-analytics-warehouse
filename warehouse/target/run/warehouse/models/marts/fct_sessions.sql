
  
  create view "warehouse"."main"."fct_sessions__dbt_tmp" as (
    with events as (
    select * from "warehouse"."main"."fct_events"
)

select
    session_id,
    user_pseudo_id,
    min(event_ts_utc) as session_start,
    max(event_ts_utc) as session_end,
    datediff('second', min(event_ts_utc), max(event_ts_utc)) as duration_seconds,
    count(*) as event_count,
    sum(case when event_name = 'purchase' then try_cast(purchase_revenue as double) else 0 end) as session_revenue,
    max(case when event_name = 'purchase' then 1 else 0 end) as converted
from events
group by 1, 2
  );
