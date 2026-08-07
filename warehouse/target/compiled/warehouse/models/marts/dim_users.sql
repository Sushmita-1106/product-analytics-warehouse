select
    user_pseudo_id,
    min(session_start) as first_seen_at,
    max(session_end) as last_seen_at,
    count(distinct session_id) as total_sessions,
    sum(session_revenue) as lifetime_revenue
from "warehouse"."main"."fct_sessions"
group by 1