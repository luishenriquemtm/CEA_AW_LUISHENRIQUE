with
    source_sales_order_detail as (
        select
            cast (salesorderid as int) as sales_order_id		
            , cast (orderqty as int) as order_quantity
            , cast (productid as int) as product_id
            , cast (unitprice as numeric) as unit_price
            , cast (unitpricediscount as numeric) as unit_price_discount
        from {{ source('db_aw','salesorderdetail')}}
    )

select *
from source_sales_order_detail