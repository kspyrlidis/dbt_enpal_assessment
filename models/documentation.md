{% docs table_uuid %}
Surrogate key of the table, generated with the `generate_table_uuid` macro as an md5 hash of the fields that uniquely identify a row.
{% enddocs %}

{% docs pipedrive__activity_id %}
The ID of the activity.

Source: Pipedrive API, Activities. Not unique on its own in this dataset, so use `table_uuid` as the primary key.
{% enddocs %}

{% docs pipedrive__deal_id %}
The ID of the deal. Deals represent ongoing, lost or won sales to an organization or to a person.

Source: Pipedrive API, Deals and Activities.
{% enddocs %}

{% docs pipedrive__activity_type %}
The type of the activity. Activity types are linked to activities via `ActivityType.key_string = Activity.type`.

Source: Pipedrive API, Activities and ActivityTypes.
{% enddocs %}

{% docs pipedrive__activity_type_id %}
The ID of the activity type.

Source: Pipedrive API, ActivityTypes.
{% enddocs %}

{% docs pipedrive__activity_type_name %}
The name of the activity type.

Source: Pipedrive API, ActivityTypes.
{% enddocs %}

{% docs pipedrive__is_active %}
Whether the activity type is active. Converted to a boolean from the text values `Yes` / `No` in the source.

Source: Pipedrive API, ActivityTypes (`active_flag`).
{% enddocs %}

{% docs pipedrive__change_date %}
The date when the deal field value was changed.

Source: Pipedrive API, Deals (List updates about deal field values).
{% enddocs %}

{% docs pipedrive__deal_uuid %}
Surrogate key of the deal, generated with the `generate_table_uuid` macro from `deal_id` and the time of day (hh:mm:ss) of the change.

In this dataset, all changes of one deal share the same time of day, while a few `deal_id`s were issued to more than one deal (e.g. `deal_id = 399956`). The time of day is the only way to tell those deals apart. Use `deal_uuid` instead of `deal_id` to count deals.
{% enddocs %}

{% docs pipedrive__field_id %}
The ID of the deal field.

Source: Pipedrive API, DealFields.
{% enddocs %}

{% docs pipedrive__field_key %}
The key of the deal field. Custom fields are recognized by long hashes as keys, which can be mapped against `DealField.key`.

Source: Pipedrive API, Deals and DealFields.
{% enddocs %}

{% docs pipedrive__changed_field_key %}
The key of the deal field whose value was changed. Maps to `field_key` in deal fields.

Source: Pipedrive API, Deals (List updates about deal field values) and DealFields.
{% enddocs %}

{% docs pipedrive__field_name %}
The name of the deal field. The label for each custom field can be obtained from `DealField.name`.

Source: Pipedrive API, Deals and DealFields.
{% enddocs %}

{% docs pipedrive__field_value_options %}
Field options (required for enum and set field types), as a JSON array of `id` and `label` pairs.

Source: Pipedrive API, DealFields (`options`).
{% enddocs %}

{% docs pipedrive__new_value %}
The new value of the deal field after the change. For enum fields such as `stage_id` and `lost_reason`, the value is an option `id` from `field_value_options`.

Source: Pipedrive API, Deals (List updates about deal field values).
{% enddocs %}

{% docs pipedrive__stage_id %}
The ID of the stage. Stage is a logical component of a pipeline, and essentially a bucket that can hold a number of deals.

Source: Pipedrive API, Stages.
{% enddocs %}

{% docs pipedrive__stage_name %}
The name of the stage.

Source: Pipedrive API, Stages.
{% enddocs %}

{% docs pipedrive__user_id %}
The ID of the user. Users are people with access to your Pipedrive account, and should not be confused with persons.

Source: Pipedrive API, Users.
{% enddocs %}

{% docs pipedrive__user_name %}
The name of the user.

Source: Pipedrive API, Users.
{% enddocs %}

{% docs pipedrive__user_email %}
The email of the user.

Source: Pipedrive API, Users.
{% enddocs %}

{% docs pipedrive__modified_timestamp %}
The date and time when the user was last modified.

Source: Pipedrive API, Users (`modified`).
{% enddocs %}

{% docs pipedrive__assigned_user_id %}
The ID of the user who owns the activity.

Source: Pipedrive API, Activities (`owner_id`).
{% enddocs %}

{% docs pipedrive__is_done %}
Whether the activity is marked as done or not.

Source: Pipedrive API, Activities.
{% enddocs %}

{% docs pipedrive__due_timestamp %}
The due date and time of the activity.

Source: Pipedrive API, Activities (`due_date` and `due_time`). This is the scheduled time, not the time the activity was marked as done.
{% enddocs %}

{% docs pipedrive__lost_reason_id %}
The ID of the lost reason, parsed from the `id` key of the `lost_reason` deal field options. Maps to the `new_value` of a `lost_reason` change in deal changes.

Source: Pipedrive API, DealFields (`options`).
{% enddocs %}

{% docs pipedrive__lost_reason_name %}
The name of the lost reason, parsed from the `label` key of the `lost_reason` deal field options.

Source: Pipedrive API, DealFields (`options`).
{% enddocs %}

{% docs pipedrive__created_timestamp %}
The date and time when the deal was created.

Source: Pipedrive API, Deals (`add_time`), taken from the `add_time` change in deal changes.
{% enddocs %}

{% docs pipedrive__funnel_step_number %}
The number of the funnel step, equal to the `stage_id` the deal moved into. Stages are numbered in funnel order, so a higher number means a later step.

Source: Pipedrive API, Deals (List updates about deal field values) and Stages.
{% enddocs %}

{% docs pipedrive__funnel_step_name %}
The name of the funnel step, equal to the `stage_name` of the stage the deal moved into.

Source: Pipedrive API, Stages.
{% enddocs %}

{% docs pipedrive__valid_from %}
The date when the deal entered the funnel step, taken from the `change_date` of the `stage_id` change.
{% enddocs %}

{% docs pipedrive__valid_to %}
The date when the deal left the funnel step, equal to the `valid_from` of the deal's next step (exclusive). For the last step of a lost deal it is the `lost_date`, and for the step an open deal is currently in it is `9999-12-31`.
{% enddocs %}

{% docs pipedrive__owner_user_id %}
The ID of the user who owns the deal, taken from the `new_value` of the `user_id` change. Maps to `user_id` in users.

Source: Pipedrive API, Deals (List updates about deal field values) and Users.
{% enddocs %}

{% docs pipedrive__owner_valid_from %}
The date when the user became the owner of the deal, taken from the `change_date` of the `user_id` change.
{% enddocs %}

{% docs pipedrive__owner_valid_to %}
The date when the deal was reassigned to another user, equal to the `valid_from` of the deal's next owner (exclusive). Set to `9999-12-31` for the current owner.
{% enddocs %}

{% docs pipedrive__is_lost %}
Whether the deal was lost, i.e. has a `lost_reason` change. A deal-level flag, repeated on every step of the deal.

Source: Pipedrive API, Deals (List updates about deal field values).
{% enddocs %}

{% docs pipedrive__lost_date %}
The date when the deal was lost, taken from the `change_date` of the `lost_reason` change. Null for deals that were not lost.

Source: Pipedrive API, Deals (List updates about deal field values).
{% enddocs %}

{% docs pipedrive__lost_reason %}
The reason the deal was lost, mapped from the `lost_reason` change to the lost reason name in `prep_pipedrive__lost_reasons`. Null for deals that were not lost.

Source: Pipedrive API, Deals (List updates about deal field values) and DealFields (`options`).
{% enddocs %}

{% docs rep__month %}
The reporting month, as the first day of the month. Spans from the month of the first deal creation to the month of the last step entry, so both the flow and the cohort view are fully covered.
{% enddocs %}

{% docs rep__kpi_name %}
The name of the funnel step (KPI), equal to the stage name.
{% enddocs %}

{% docs rep__funnel_step %}
The number of the funnel step, equal to the stage ID. Stages are numbered in funnel order.
{% enddocs %}

{% docs rep__deals_count %}
Flow view: the number of distinct deals that entered the funnel step during the month, based on the `valid_from` of the step. A deal counts only for the steps it actually entered, so counts can increase from one step to the next within a month.
{% enddocs %}

{% docs rep__cohort_deals_count %}
Cohort view: the number of deals created in the month that reached the funnel step at any time. Deals can skip steps, so a deal counts for every step up to the furthest one it reached, which keeps the funnel non-increasing from one step to the next. Zero for months without deal creations, and incomplete for recent cohorts whose deals are still progressing.
{% enddocs %}
