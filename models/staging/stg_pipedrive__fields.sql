-- config_placeholder
with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
fields as (

    select *

    from {{ source('postgres_public', 'fields') }}

),

-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid(['id']) }} as table_uuid,
        id                                as field_id,
        field_key,
        name                              as field_name,
        field_value_options

    from fields

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
