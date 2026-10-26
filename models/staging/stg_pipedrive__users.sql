-- config_placeholder
with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
users as (

    select *

    from {{ source('postgres_public', 'users') }}

),

-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid(['id']) }} as table_uuid,
        id                                as user_id,
        name                              as user_name,
        email                             as user_email,
        modified                          as modified_timestamp

    from users

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
