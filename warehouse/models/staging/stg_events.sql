with source as (
    select * from {{ source('raw', 'raw_events') }}
),

deduplicated as (
    select distinct
        cast(user_pseudo_id as varchar) as user_pseudo_id,
        event_date,
        event_timestamp,
        event_name,
        ga_session_id,
        page_location,
        page_title,
        device_category,
        country,
        traffic_source,
        purchase_revenue,
        to_timestamp(event_timestamp / 1000000) as event_ts_utc
    from source
)

select * from deduplicated