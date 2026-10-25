-- config_placeholder
with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
deal_changes as (

    select *

    from {{ source('postgres_public', 'deal_changes') }}

),
-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select 
        {{ generate_table_uuid(['deal_id', 'change_time']) }} as table_uuid,
        deal_id                                               as deal_id,
        change_time                                           as change_timestamp,
        changed_field_key                                     as changed_field_key,
        new_value                                             as new_value

    from deal_changes
    
)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
