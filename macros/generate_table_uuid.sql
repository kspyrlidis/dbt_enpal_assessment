{% macro generate_table_uuid(fields) %}

    {#- Hashes an arbitrary list of fields into a deterministic md5 key.
        Nulls are replaced with a sentinel and fields are joined with a delimiter,
        so ('a', null) and (null, 'a') or ('ab', 'c') and ('a', 'bc') do not collide. -#}

    {%- if fields is string -%}
        {%- set fields = [fields] -%}
    {%- endif -%}

    {%- if fields | length == 0 -%}
        {{ exceptions.raise_compiler_error("generate_table_uuid requires at least one field") }}
    {%- endif -%}

    md5(
        {%- for field in fields %}
        coalesce(cast({{ field }} as text), '_null_')
        {%- if not loop.last %} || '-' ||{% endif -%}
        {%- endfor %}
    )

{% endmacro %}
