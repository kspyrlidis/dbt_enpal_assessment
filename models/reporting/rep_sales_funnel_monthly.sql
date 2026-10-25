with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
deal_steps as (

    select *

    from {{ ref('deal_steps') }}

),

stages as (

    select *

    from {{ ref('stg_pipedrive__stages') }}

),

-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Logic CTEs
min_max_months as (

    select
        -- the first deal creation month opens the cohort view, the last step entry closes the flow view
        date_trunc('month', min(created_timestamp)) as min_month,
        date_trunc('month', max(valid_from))        as max_month

    from deal_steps

),

months_spine as (

    select generate_series(min_month, max_month, interval '1 month')::date as month

    from min_max_months

),

months_spine_enriched as (

    select
        months_spine.month,
        stages.stage_id   as funnel_step,
        stages.stage_name as kpi_name

    from months_spine

    cross join stages

),

deals as (

    select
        deal_uuid,
        (date_trunc('month', created_timestamp))::date as created_month,
        max(funnel_step_number)                        as max_funnel_step

    from deal_steps

    group by 1, 2

),

-- flow: deals that entered the step in the month
flow_counts as (

    select
        (date_trunc('month', valid_from))::date as month,
        funnel_step_number                      as funnel_step,
        count(distinct deal_uuid)               as deals_count

    from deal_steps

    group by 1, 2

),

-- cohort: deals created in the month that reached the step,
-- a deal counts for every step up to the furthest one it reached as deals can skip steps
cohort_counts as (

    select
        deals.created_month    as month,
        stages.stage_id        as funnel_step,
        count(deals.deal_uuid) as cohort_deals_count

    from deals

    inner join stages
        on deals.max_funnel_step >= stages.stage_id

    group by 1, 2

),

-- ==== END >> Logic CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid([
            'month_spine.month',
            'month_spine.funnel_step',
        ]) }}                                         as table_uuid,
        month_spine.month,
        month_spine.kpi_name,
        month_spine.funnel_step,
        coalesce(flow_counts.deals_count, 0)          as deals_count,
        coalesce(cohort_counts.cohort_deals_count, 0) as cohort_deals_count

    from months_spine_enriched as month_spine

    left join flow_counts
        on month_spine.month = flow_counts.month
        and month_spine.funnel_step = flow_counts.funnel_step

    left join cohort_counts
        on month_spine.month = cohort_counts.month
        and month_spine.funnel_step = cohort_counts.funnel_step

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
