with
    source_address as (
        select
            cast (addressid as int) as address_id		
            , cast (city as string) as city
            , cast (stateprovinceid as int) as state_province_id
        from {{ source('db_aw','address')}}
    )

select *
from source_address