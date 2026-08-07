with events as (
    select * from "warehouse"."main"."stg_events"
),

ordered as (
    select
        *,
        lag(event_ts_utc) over (
            partition by user_pseudo_id order by event_ts_utc
        ) as prev_event_ts
    from events
),

flagged as (
    select
        *,
        case
            when prev_event_ts is null
                 or datediff('minute', prev_event_ts, event_ts_utc) >= 30
            then 1 else 0
        end as is_new_session
    from ordered
),

session_ids as (
    select
        *,
        sum(is_new_session) over (
            partition by user_pseudo_id order by event_ts_utc
            rows between unbounded preceding and current row
        ) as session_seq
    from flagged
)

select *, user_pseudo_id || '-' || session_seq as session_id
from session_ids