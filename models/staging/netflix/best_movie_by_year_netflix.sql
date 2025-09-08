with source as (
    select * 
    from {{ source('NETFLIX', 'BEST_MOVIE_BY_YEAR_NETFLIX') }}
),

renamed as (
    select
        movie_id,
        trim(title) as movie_title,
        cast(release_year as int) as release_year,
        cast(imdb_score as float) as imdb_score,
        cast(vote_count as int) as vote_count,
        row_number() over (
            partition by release_year
            order by imdb_score desc, vote_count desc
        ) as rank_in_year,
        'movie' as content_type
    from source
    where vote_count >= 25000
)

select * from renamed
