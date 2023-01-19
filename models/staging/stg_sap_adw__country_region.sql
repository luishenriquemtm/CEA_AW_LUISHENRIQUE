with
    source_country_region as (
        select
            cast (countryregioncode as string) as country_region_code		
            , cast (name as string) as name_country
        from {{ source('db_aw','countryregion')}}
    )

select *
from source_country_region