with
    source_customer as (
        select
            cast (customerid as int) as customer_id		
            , cast (personid as int) as person_id
            , cast (storeid as int) as store_id
        from {{ source('db_aw','customer')}}
    )

select *
from source_customer