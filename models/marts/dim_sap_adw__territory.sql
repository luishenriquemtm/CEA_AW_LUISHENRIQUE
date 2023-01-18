with
    address as (
        select *
        from {{ref('stg_sap_adw__address')}}
    ) 

    , country_region as (
        select *
        from {{ref('stg_sap_adw__country_region')}}
    ) 

    , state_province as (
        select *
        from {{ref('stg_sap_adw__state_province')}}
    ) 

    , joined_tabelas as (
        select
            address.address_id
            , address.city
            , address.state_province_id
            , state_province.state_province_code
            , state_province.name_province
            , state_province.country_region_code
            , country_region.name_country
            from address
        left join state_province on state_province.state_province_id = address.state_province_id
        left join country_region on state_province.country_region_code = country_region.country_region_code
    )

    , transformacoes as (
        select
            address_id as pk_address_id
            , *
        from joined_tabelas
    )

select *
from transformacoes