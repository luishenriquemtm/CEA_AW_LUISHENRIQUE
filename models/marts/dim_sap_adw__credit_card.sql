with
    credit_card as (
        select *
        from {{ ref('stg_sap_adw__credit_card') }}
    )

    , transformed as (
        select
            credit_card_id as pk_credit_card
            , card_type
        from credit_card order by pk_credit_card
    )

select *
from transformed