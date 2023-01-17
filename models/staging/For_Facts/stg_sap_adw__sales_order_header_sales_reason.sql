with
    source_sales_order_header_sales_reason as (
        select
            cast (salesorderid as int) as sales_order_id		
            , cast (salesreasonid as int) as sales_reason_id
        from {{ source('db_aw','salesorderheadersalesreason')}}
    )

select *
from source_sales_order_header_sales_reason