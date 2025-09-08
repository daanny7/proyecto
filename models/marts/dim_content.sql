with movies as (
    select 
        movie_title as title,
        release_year,
        imdb_score,
        vote_count,
        content_type
    from {{ ref('best_movies_netflix') }}
),

shows as (
    select 
        series_title as title,
        release_year,
        imdb_score,
        vote_count,
        content_type
    from {{ ref('best_shows_netflix') }}
),

unioned as (
    select * from movies
    union all
    select * from shows
)

select 
    title,
    release_year,
    content_type,
    imdb_score,
    vote_count
from unioned
