select
    content_id,
    release_year,
    imdb_score,
    vote_count,
    case 
        when imdb_score >= 8.5 then 'excelente'
        when imdb_score >= 7.5 then 'muy buena'
        when imdb_score >= 6.5 then 'buena'
        else 'regular'
    end as score_category
from {{ ref('dim_content') }}
