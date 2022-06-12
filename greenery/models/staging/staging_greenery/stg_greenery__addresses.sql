{{
    config(
        materialized = 'view'
    )
}}

with addresses_source as (
    select * from {{ source('src_greenery', 'addresses')}}
),

renamed_recast as (
    select
        address_id,
        address,
        zipcode as zip_code,
        state,
        country
    from addresses_source   
)

select * from renamed_recast