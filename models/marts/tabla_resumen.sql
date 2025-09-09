with ranked as (
    select 
        title,
        release_year,
        content_type,
        imdb_score,
        vote_count,
        category,
        country,
        row_number() over (
            partition by release_year, content_type
            order by imdb_score desc, vote_count desc
        ) as rank_in_year
    from {{ ref('dim_content') }}
)

select *
from ranked
where rank_in_year <= 10
