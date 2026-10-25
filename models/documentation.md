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

{% docs pipedrive__change_timestamp %}
The date and time when the deal field value was changed.

Source: Pipedrive API, Deals (List updates about deal field values).
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
