with
----------------------------------------------------------------------------------------------------
-- ==== START >> IMPORT CTEs
fields as (

    select *

    from {{ ref('stg_pipedrive__fields') }}

    where field_key = 'lost_reason'

),

-- ==== END >> IMPORT CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Logic CTEs
parsed_options as (

    select
        options.value ->> 'id'    as lost_reason_id,
        options.value ->> 'label' as lost_reason_name

    from fields

    cross join jsonb_array_elements(fields.field_value_options) as options (value)

),

-- ==== END >> Logic CTEs
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- ==== START >> Final CTE
final_cte as (

    select
        {{ generate_table_uuid(['lost_reason_id']) }} as table_uuid,
        lost_reason_id,
        lost_reason_name

    from parsed_options

)
-- ==== END >> Final CTE
----------------------------------------------------------------------------------------------------

select * from final_cte
