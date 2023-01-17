with
    source_person as (
        select
            cast (businessentityid as int) as business_entity_id		
            , cast (firstname as string) as first_name
            , cast (lastname as string) as last_name
        from {{ source('db_aw','person')}}
    )

select *
from source_person