with first_seen as (
    select
        user_pseudo_id,
        date_trunc('week', first_seen_at) as cohort_week
    from "warehouse"."main"."dim_users"
),

activity as (
    select
        user_pseudo_id,
        date_trunc('week', session_start) as activity_week
    from "warehouse"."main"."fct_sessions"
    group by 1, 2
)

select
    f.cohort_week,
    datediff('week', f.cohort_week, a.activity_week) as weeks_since_cohort,
    count(distinct a.user_pseudo_id) as active_users
from first_seen f
join activity a using (user_pseudo_id)
group by 1, 2
order by 1, 2