with
    source_state_province as (
        select
            cast (stateprovincecode as int) as state_province_code		
            , cast (name as string) as name_province
            , cast (countryregioncode as string) as country_region_code
            , cast (stateprovinceid as int) as state_province_id
        from {{ source('db_aw','stateprovince')}}
    )

select *
from source_state_province

