with
    credit_card as (
        select *
        from {{ref('dim_sap_adw__credit_card')}}
    ) 

    , customer as (
        select *
        from {{ref('dim_sap_adw__customer')}}
    ) 

    , products as (
        select *
        from {{ref('dim_sap_adw__products')}}
    ) 

    , territory as (
        select *
        from {{ref('dim_sap_adw__territory')}}
    ) 

    , sales_order_detail as (
        select *
        from {{ref('stg_sap_adw__sales_order_detail')}}
    ) 

    , sales_order_header_sales_reason as (
        select *
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

    , joined_table_facts as ( -- Aqui vai ser montado a tabela Fact com as tabelas Orders (que não formam DIM)
        select
            sales_order_header.sales_order_id
            , sales_order_header.customer_id
            , customer.full_name
            , customer.name_store
            , customer.person_type
            , credit_card.card_type
            , territory.city
            , territory.name_province
            , territory.name_country
            , sales_order_header.order_date
            , sales_order_detail.order_quantity
            , products.name_product
            , sales_order_detail.unit_price
            , sales_reason.reason_name
        from sales_order_header
        -- Join para montar a tabela fato.
        left join sales_order_detail on sales_order_header.sales_order_id = sales_order_detail.sales_order_id
        left join sales_order_header_sales_reason on sales_order_header_sales_reason.sales_order_id = sales_order_header.sales_order_id and sales_order_header_sales_reason.sales_reason_id = 2 --trazer somente aqueles que possuem o código 2 (On promotion)
        left join sales_reason on sales_order_header_sales_reason.sales_reason_id = sales_reason.sales_reason_id
        -- Aqui começa os Join com as dimensões
        left join credit_card on credit_card.pk_credit_card = sales_order_header.credit_card_id
        left join customer on customer.pk_customer_id = sales_order_header.customer_id
        left join products on products.pk_product = sales_order_detail.product_id
        left join territory on territory.pk_address_id = sales_order_header.ship_to_address_id
    )

    , transformacoes as (
        select 
            row_number() over(order by sales_order_id) as sk_sales_order_id
            ,*
        from joined_table_facts
    )

select *
from transformacoes