with
    source_store as (
        select
            cast (businessentityid as int) as business_entity_id		
            , cast (name as string) as name_store
        from {{ source('db_aw','store')}}
    )

select *
from source_store