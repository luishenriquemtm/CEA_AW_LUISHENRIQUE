with
    products as (
        select *
        from {{ ref('stg_sap_adw__products') }}
    )

    , transformed as (
        select
            product_id as pk_product
            , name_product
        from products order by product_id
    )

select *
from transformed