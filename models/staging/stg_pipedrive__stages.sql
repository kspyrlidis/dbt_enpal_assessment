-- config_placeholder
with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
stages as (

    select *

    from {{ source('postgres_public', 'stages') }}

),
-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select 
        {{ generate_table_uuid(['stage_id']) }} as table_uuid,
        stage_id                                as stage_id,
        stage_name                              as stage_name

    from stages
    
)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
