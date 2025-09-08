with movie_shows as (
    select
        {{ calculate_md5('movie_title') }} as sk_movie_show_id,
        movie_title,
        release_year,
        imdb_score,
        vote_count,
        duration_movie,
        movie_genre_id,
        countryprod_movie_id,
        content_type
    from {{ ref('best_movies_netflix') }}

    union all

    select
        {{ calculate_md5('series_title') }} as sk_movie_show_id,
        series_title,
        release_year,
        imdb_score,
        vote_count,
        duration_show,
        show_genre_id,
        countryprod_show_id,
        content_type
    from {{ ref('best_shows_netflix') }}
)

select
    sk_movie_show_id,
    movie_title,
    release_year,
    imdb_score,
    vote_count,
    duration_movie,
    movie_genre_id,
    countryprod_movie_id,
    content_type,
    current_date as view_date
from movie_shows