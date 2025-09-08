with dates as (
    select
        dateadd(day, row_number() over (order by seq4()) - 1, '2000-01-01') as date_day
    from table(generator(rowcount => 10000))
)
select
    date_day,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(quarter from date_day) as quarter,
    extract(week from date_day) as week
from dates
where date_day <= current_date