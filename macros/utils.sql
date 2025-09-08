{% macro eliminate_duplicates(column_list) %}
    row_number() over (
        partition by
            {%- for col in column_list -%}
                {{ col }}{% if not loop.last %}, {% endif %}
            {%- endfor -%}
        order by
            {%- for col in column_list -%}
                {{ col }}{% if not loop.last %}, {% endif %}
            {%- endfor -%}
    )
{% endmacro %}

{% macro format_fivetran_date(column_name) %}
    cast({{ column_name }} as date)
{% endmacro %}

{% macro calculate_md5(column_name) %}
    md5(cast({{ column_name }} as text))
{% endmacro %}

{% macro round_price(column_name) %}
    round(cast({{ column_name }} as numeric), 2)
{% endmacro %}

{% macro round_score(column_name) %}
    round(cast({{ column_name }} as numeric), 1)
{% endmacro %}