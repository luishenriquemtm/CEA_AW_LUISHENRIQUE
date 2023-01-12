with
    source_creditcard as (
        select
            cast (creditcardid as int) as credit_card_id			
            , cast (cardtype as string) as card_type
        from {{ source('db_aw','creditcard')}}
    )

select *
from source_creditcard