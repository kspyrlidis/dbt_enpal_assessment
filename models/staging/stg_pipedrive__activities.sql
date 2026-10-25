-- config_placeholder
with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
activity as (

    select *

    from {{ source('postgres_public', 'activity') }}

),
-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select 
        {{ generate_table_uuid(['activity_id', 'deal_id']) }} as table_uuid,
        activity_id                                           as activity_id,
        deal_id                                               as deal_id,
        type                                                  as activity_type,
        assigned_to_user                                      as assigned_user_id,
        done                                                  as is_done,
        due_to                                                as due_timestamp

    from activity
    
)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
