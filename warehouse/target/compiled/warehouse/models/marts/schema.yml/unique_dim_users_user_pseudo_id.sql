
    
    

select
    user_pseudo_id as unique_field,
    count(*) as n_records

from "warehouse"."main"."dim_users"
where user_pseudo_id is not null
group by user_pseudo_id
having count(*) > 1


