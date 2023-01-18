with
    source_person as (
        select
            cast (businessentityid as int) as business_entity_id
            --, cast (persontype as string) as person_type	--EM = Employee(non-sales), SC = Store Contact, IN = Individual Customer, SP = Sales Person, VC = Vendor contact, GC = General Contact	
            , cast (firstname as string) as first_name
            , cast (lastname as string) as last_name
        from {{ source('db_aw','person')}}
    )

select *
from source_person