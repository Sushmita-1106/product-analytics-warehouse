
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select user_pseudo_id
from "warehouse"."main"."dim_users"
where user_pseudo_id is null



  
  
      
    ) dbt_internal_test