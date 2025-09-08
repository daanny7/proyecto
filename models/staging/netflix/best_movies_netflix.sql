with source as (
    select * 
    from {{ source('netflix', 'best_movies_netflix') }}
),

renamed as (
    select
        movie_id,
        trim(title) as movie_title,
        cast(release_year as int) as release_year,
        cast(imdb_score as float) as imdb_score,
        cast(vote_count as int) as vote_count,
        'movie' as content_type
    from source
    where imdb_score >= 6.9
      and vote_count >= 10000
)

select * from renamed
