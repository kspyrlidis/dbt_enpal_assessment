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
add_timestamps as (

    select
        *,
        -- one deal has only one hh:mm:ss across all the changes, so it can be dropped
        cast(change_time as date)                    as change_date,
        -- in rare cases the same deal_id was issued for >1 deals
        -- the only way to differentiate them is by hh:mm:ss
        -- as it corresponds to one deal. See the example with deal_id = 399956
        change_time - date_trunc('day', change_time) as timestamp_wo_date

    from deal_changes

),

----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid(['deal_id', 'change_time']) }}       as table_uuid,
        {{ generate_table_uuid(['deal_id', 'timestamp_wo_date']) }} as deal_uuid,
        deal_id,
        change_date,
        changed_field_key,
        new_value

    from add_timestamps

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
