with source as (
    select * 
    from {{ source('netflix', 'best_shows_netflix') }}
),

renamed as (
    select
        {{ eliminate_duplicates(['title', 'release_year', 'score']) }} as _row,
        title,
        trim(title) as series_title,
        cast(release_year as int) as release_year,
        {{ round_score('score') }} as imdb_score,
        cast(duration as int) as duration_movie,
        {{ calculate_md5('main_genre') }} as movie_genre_id,
        cast(main_genre as text) as movie_genre,
        {{ calculate_md5('main_production') }} as countryprod_movie_id,
        cast(main_production as text) as countryprod_movie,
        'series' as content_type
    from source
    where {{ round_score('score') }} >= 7.5
)

select *
from renamed
where _row = 1