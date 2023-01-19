with
    source_sales_reason as (
        select
            cast (name as string) as reason_name		
            , cast (salesreasonid as int) as sales_reason_id
        from {{ source('db_aw','salesreason')}}
    )

select *
from source_sales_reason