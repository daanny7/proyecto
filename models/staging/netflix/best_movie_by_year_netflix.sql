with source as (
    select * 
    from {{ source('netflix', 'best_movie_by_year_netflix') }}
),

renamed as (
    select
        {{ eliminate_duplicates(['title', 'release_year', 'score']) }} as _row,
        trim(title) as movie_title,
        cast(release_year as int) as release_year,
        {{ round_score('score') }} as imdb_score,
        row_number() over (
            partition by release_year
            order by score desc
        ) as rank_in_year,
        {{ calculate_md5('main_genre') }} as movie_genre_id,
        cast(main_genre as text) as movie_genre,
        {{ calculate_md5('main_production') }} as countryprod_movie_id,
        cast(main_production as text) as countryprod_movie,
        'movie' as content_type
    from source
)

select *
from renamed
where _row = 1  -- Solo la fila "única" 
