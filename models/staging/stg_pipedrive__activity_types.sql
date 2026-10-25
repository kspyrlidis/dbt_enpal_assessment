-- config_placeholder
with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
activity_types as (

    select *

    from {{ source('postgres_public', 'activity_types') }}

),

-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid(['id']) }} as table_uuid,
        id                                as activity_type_id,
        name                              as activity_type_name,
        type                              as activity_type,
        case
            when active = 'Yes' then true
            when active = 'No' then false
        end                               as is_active

    from activity_types

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
