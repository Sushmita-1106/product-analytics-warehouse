
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select *
from "warehouse"."main"."fct_sessions"
where duration_seconds < 0
  
  
      
    ) dbt_internal_test