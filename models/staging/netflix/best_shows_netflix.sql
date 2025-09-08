with source as (
    select * 
    from {{ source('NETFLIX', 'BEST_SHOWS_NETFLIX') }}
),

renamed as (
    select
        series_id,
        trim(title) as series_title,
        cast(release_year as int) as release_year,
        cast(imdb_score as float) as imdb_score,
        cast(vote_count as int) as vote_count,
        'series' as content_type
    from source
    where imdb_score >= 7.5
      and vote_count >= 10000
)

select * from renamed
