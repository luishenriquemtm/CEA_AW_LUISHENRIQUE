with
    customer as (
        select *
        from {{ref('stg_sap_adw__customer')}}
    ) 

    , person as (
        select *
        from {{ref('stg_sap_adw__person')}}
    ) 

    , store as (
        select *
        from {{ref('stg_sap_adw__store')}}
    ) 

    , joined_tabelas as (
        select
            customer.customer_id
            , customer.person_id
            , person.first_name
            , person.last_name
            , customer.store_id
            , store.name_store
        from customer
        left join person on person.business_entity_id = customer.person_id
        left join store on store.business_entity_id = customer.store_id
    )

    , transformacoes as (
        select
            customer_id as pk_customer_id
            , *
            , concat(first_name, ' ', last_name) as full_name
            , case 
                when person_id is null and store_id is not null then 'Store'
                when person_id is not null and store_id is null then 'Natural Person'
                when person_id is not null and store_id is not null then 'Store Contact'
                end as person_type
        from joined_tabelas
    )

select *
from transformacoes