with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
deal_changes as (

    select *

    from {{ ref('stg_pipedrive__deal_changes') }}

),

stages as (

    select *

    from {{ ref('stg_pipedrive__stages') }}

),

lost_reasons as (

    select *

    from {{ ref('prep_pipedrive__lost_reasons') }}

),

-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Logic CTEs
deal_created as (

    select
        deal_uuid,
        cast(new_value as timestamp) as created_timestamp

    from deal_changes

    where changed_field_key = 'add_time'

),

deal_lost as (

    select
        deal_changes.deal_uuid,
        deal_changes.change_date      as lost_date,
        lost_reasons.lost_reason_name as lost_reason

    from deal_changes

    left join lost_reasons
        on deal_changes.new_value = lost_reasons.lost_reason_id

    where deal_changes.changed_field_key = 'lost_reason'

),

stage_changes as (

    select
        deal_uuid,
        deal_id,
        cast(new_value as integer)                                           as stage_id,
        change_date                                                          as valid_from,
        -- the step is valid until the deal moves to the next step, null for the current one
        lead(change_date) over (partition by deal_uuid order by change_date) as next_step_date

    from deal_changes

    where changed_field_key = 'stage_id'

),

-- ==== END >> Logic CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid(['stage_changes.deal_uuid', 'stage_changes.stage_id']) }} as table_uuid,
        stage_changes.deal_uuid,
        stage_changes.deal_id,
        deal_created.created_timestamp,
        deal_lost.deal_uuid is not null                                                  as is_lost,
        deal_lost.lost_date,
        deal_lost.lost_reason,
        stages.stage_id                                                                  as funnel_step_number,
        stages.stage_name                                                                as funnel_step_name,
        stage_changes.valid_from,
        -- the current step of a lost deal closes on the lost date, otherwise it stays open
        coalesce(
            stage_changes.next_step_date,
            deal_lost.lost_date,
            date '9999-12-31'
        )                                                                                as valid_to

    from stage_changes

    left join deal_created
        on stage_changes.deal_uuid = deal_created.deal_uuid

    left join deal_lost
        on stage_changes.deal_uuid = deal_lost.deal_uuid

    left join stages
        on stage_changes.stage_id = stages.stage_id

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
