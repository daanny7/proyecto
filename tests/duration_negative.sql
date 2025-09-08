SELECT *
FROM {{ ref('best_shows_netflix') }}
WHERE duration_show < 0