
  
  create view "warehouse"."main"."funnel_steps__dbt_tmp" as (
    with steps as (
    select
        user_pseudo_id,
        session_id,
        max(case when event_name = 'view_item' then 1 else 0 end) as viewed,
        max(case when event_name = 'add_to_cart' then 1 else 0 end) as added_to_cart,
        max(case when event_name = 'begin_checkout' then 1 else 0 end) as began_checkout,
        max(case when event_name = 'purchase' then 1 else 0 end) as purchased
    from "warehouse"."main"."fct_events"
    group by 1, 2
)

select
    sum(viewed) as step_view,
    sum(case when viewed = 1 then added_to_cart else 0 end) as step_add_to_cart,
    sum(case when added_to_cart = 1 then began_checkout else 0 end) as step_begin_checkout,
    sum(case when began_checkout = 1 then purchased else 0 end) as step_purchase
from steps
  );
