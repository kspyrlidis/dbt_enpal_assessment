with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
deal_changes as (

    select *

    from {{ ref('stg_pipedrive__deal_changes') }}

),

users as (

    select *

    from {{ ref('stg_pipedrive__users') }}

),

-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Logic CTEs
owner_changes as (

    select
        deal_uuid,
        deal_id,
        cast(new_value as integer)                             as user_id,
        change_date                                            as valid_from,
        -- the owner is valid until the deal is reassigned, 9999-12-31 for the current one
        lead(change_date, 1, date '9999-12-31')
            over (partition by deal_uuid order by change_date) as valid_to

    from deal_changes

    where changed_field_key = 'user_id'

),

-- ==== END >> Logic CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid(['owner_changes.deal_uuid', 'owner_changes.valid_from']) }} as table_uuid,
        owner_changes.deal_uuid,
        owner_changes.deal_id,
        owner_changes.user_id,
        users.user_name,
        users.user_email,
        owner_changes.valid_from,
        owner_changes.valid_to

    from owner_changes

    left join users
        on owner_changes.user_id = users.user_id

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
