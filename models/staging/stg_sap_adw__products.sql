with
    source_products as (
        select
           cast (productid as int) as product_id
           , cast (name as string) as name_product
        from {{ source('db_aw','product')}}
    )

select *
from source_products

-- Há mais informações sobre cada produto nesta tabela, mas como não é o objetivo da regra de negócio da Adventure Works
-- não foi elencada aqui no dbt.

