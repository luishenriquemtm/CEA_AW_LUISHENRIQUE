with
    sales_order_detail as (
        select *
        from {{ref('stg_sap_adw__sales_order_detail')}}
    ) 

    , sales_order_header_sales_reason as (
<<<<<<< HEAD
        select 
            sales_order_id
            , sales_reason_id
            , row_number() over (partition by sales_order_id) as rn
=======
        select *
>>>>>>> 8ffbc90696aff76c32c336dd465d8b04666c328a
        from {{ref('stg_sap_adw__sales_order_header_sales_reason')}}
    )

    , sales_order_header as (
        select *
        from {{ref('stg_sap_adw__sales_order_header')}}
    )  

    , sales_reason as (
        select *
        from {{ref('stg_sap_adw__sales_reason')}}
    ) 

    , joined_table_facts as ( 
        select
            sales_order_header.sales_order_id
            , sales_order_header.customer_id
            , sales_order_header.credit_card_id
            , sales_order_detail.product_id
            , sales_order_header.ship_to_address_id
            , sales_order_header.order_date
            , sales_order_detail.order_quantity
            , sales_order_detail.unit_price
            , sales_reason.reason_name
        from sales_order_header
        -- Join para montar a tabela fato.
        left join sales_order_detail on sales_order_header.sales_order_id = sales_order_detail.sales_order_id
<<<<<<< HEAD
        left join sales_order_header_sales_reason on sales_order_header_sales_reason.sales_order_id = sales_order_header.sales_order_id and sales_order_header_sales_reason.rn = 1
=======
        left join sales_order_header_sales_reason on sales_order_header_sales_reason.sales_order_id = sales_order_header.sales_order_id and sales_order_header_sales_reason.sales_reason_id = 2 --trazer somente aqueles que possuem o código 2 (On promotion)
>>>>>>> 8ffbc90696aff76c32c336dd465d8b04666c328a
        left join sales_reason on sales_order_header_sales_reason.sales_reason_id = sales_reason.sales_reason_id
    )

    , transformacoes as (
        select 
            row_number() over(order by sales_order_id) as sk_sales_order_id
            ,*
            , order_quantity * unit_price as total_product_value
        from joined_table_facts
    )

select *
from transformacoes