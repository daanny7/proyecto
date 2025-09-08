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
        cast(duration as int) as duration_show,
        {{ calculate_md5('main_genre') }} as show_genre_id,
        cast(main_genre as text) as show_genre,
        {{ calculate_md5('main_production') }} as countryprod_show_id,
        cast(main_production as text) as countryprod_show,
        cast(number_of_votes as int) as vote_count,
        'series' as content_type
    from source
    where cast(number_of_votes as int) >= 200
)

select *
from renamed
where _row = 1