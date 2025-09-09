with movies as (
    select 
        movie_title as title,
        content_type,
        movie_genre as category
    from {{ ref('best_movies_netflix') }}
),

shows as (
    select 
        series_title as title,
        content_type,
        show_genre as category
    from {{ ref('best_shows_netflix') }}
),

unioned as (
    select * from movies
    union all
    select * from shows
)

select 
    title,
    category,
    content_type,
    count(*) as total
from unioned
group by category, content_type, title
order by total desc