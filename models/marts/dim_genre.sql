select distinct
    sk_genre_id,
    genre
from (
    select
        movie_genre_id as sk_genre_id,
        movie_genre as genre
    from {{ ref('best_movies_netflix') }}

    union

    select
        show_genre_id as sk_genre_id,
        show_genre as genre
    from {{ ref('best_shows_netflix') }}
)