SELECT
    event_name,
    COUNT(*) AS total_events
FROM raw_events
GROUP BY event_name
ORDER BY total_events DESC;