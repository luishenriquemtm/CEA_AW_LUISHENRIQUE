with
    source_sales_order_header as (
        select
            cast (salesorderid as int) as sales_order_id		
            , cast (customerid as int) as customer_id
            , cast (creditcardid as int) as credit_card_id
            , cast (shiptoaddressid as int) as ship_to_address_id
            , cast (orderdate as DATETIME) as order_date
        from {{ source('db_aw','salesorderheader')}}
    )

select *
from source_sales_order_header