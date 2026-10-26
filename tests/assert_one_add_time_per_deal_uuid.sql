-- every deal_uuid must be created exactly once, otherwise deal_uuid still merges distinct deals
select
    deal_uuid,
    count(*) filter (where changed_field_key = 'add_time') as add_time_count

from {{ ref('stg_pipedrive__deal_changes') }}

group by deal_uuid

having count(*) filter (where changed_field_key = 'add_time') <> 1
