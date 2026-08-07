select *
from {{ ref('fct_sessions') }}
where duration_seconds < 0