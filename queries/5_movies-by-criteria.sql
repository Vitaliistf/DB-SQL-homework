-- Отримати інформацію про фільми, що відповідають наступним критеріям
-- Критерії:
-- 		Належить до країни з ID 1
-- 		Випущені у 2022 році або пізніше
-- 		Тривалість більше 2 годин і 15 хвилин
-- 		Містить принаймні один з жанрів: Action або Drama.
-- Shape:
-- 		ID
-- 		Title
-- 		Release date
-- 		Duration
-- 		Description
-- 		Poster (poster file information as JSON)
-- 		Director (director information as JSON):
-- 			ID
-- 			First name
-- 			Last name

SELECT
	m.id AS "ID",
	m.title AS "Title",
	m.release_date AS "Release date",
	m.duration AS "Duration",
	m.description AS "Description",
	json_build_object(
        'id', f.id,
        'file_name', f.file_name, 
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url 
    ) AS "Poster",
    json_build_object(
        'id', p.id, 
        'first_name', p.first_name,
        'last_name', p.last_name
    ) AS "Director"
FROM
	movie m
LEFT JOIN
	file f ON f.id = m.poster_id
LEFT JOIN 
	person p ON p.id = m.director_id
WHERE
	m.country_id = 1 AND
	m.release_date > MAKE_DATE(2022, 1, 1) AND
	m.duration > 135 AND
	EXISTS (
        SELECT 1
        FROM movie_genre mg
        INNER JOIN genre g ON mg.genre_id = g.id
        WHERE mg.movie_id = m.id
        AND g.name IN ('Action', 'Drama')
    )
	