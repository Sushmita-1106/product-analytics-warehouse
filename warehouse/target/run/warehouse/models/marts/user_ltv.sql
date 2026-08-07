
  
  create view "warehouse"."main"."user_ltv__dbt_tmp" as (
    with purchases as (
    select
        user_pseudo_id,
        count(*) filter (where event_name = 'purchase') as num_purchases,
        sum(case when event_name = 'purchase' then try_cast(purchase_revenue as double) else 0 end) as total_revenue
    from "warehouse"."main"."fct_events"
    group by 1
),

lifespan as (
    select
        user_pseudo_id,
        datediff('day', first_seen_at, last_seen_at) as lifespan_days
    from "warehouse"."main"."dim_users"
)

select
    p.user_pseudo_id,
    p.num_purchases,
    p.total_revenue,
    case when p.num_purchases > 0 then p.total_revenue / p.num_purchases else 0 end as avg_order_value,
    l.lifespan_days,
    (case when p.num_purchases > 0 then p.total_revenue / p.num_purchases else 0 end) * p.num_purchases as historical_ltv
from purchases p
join lifespan l using (user_pseudo_id)
where p.num_purchases > 0
  );
