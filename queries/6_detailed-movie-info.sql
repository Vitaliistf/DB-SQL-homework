-- Вибрати детальну інформацію про фільм з ID 1
-- Shape:
-- 		ID
-- 		Title
-- 		Release date
-- 		Duration
-- 		Description
-- 		Poster (poster file information in JSON format)
-- 		Director (person information in JSON format):
-- 			ID
-- 			First name
-- 			Last name
-- 			Photo (primary photo file information in JSON format)
-- 		Actors (array of JSON objects)
-- 			ID
-- 			First name
-- 			Last name
-- 			Photo (primary photo file information in JSON format)
-- 		Genres (array of objects in JSON format)
-- 			ID
-- 			Name

SELECT
	m.id AS "ID", 
	m.title AS "Title", 
	m.release_date AS "Release date", 
	m.duration AS "Duration", 
	m.description AS "Description", 
    (
		SELECT json_build_object(
			'id', f.id,
			'file_name', f.file_name,
			'mime_type', f.mime_type,
			'key', f.key,
			'url', f.url
		)
		FROM file f
		WHERE f.id = m.poster_id
	) AS "Poster",
	(
		SELECT json_build_object(
			'id', p.id,
			'first_name', p.first_name,
			'last_name', p.last_name,
			'photo', (
				SELECT json_build_object(
					'id', pf.id,
					'file_name', pf.file_name,
					'mime_type', pf.mime_type,
					'key', pf.key,
					'url', pf.url
				)
				FROM file pf
				WHERE pf.id = p.main_photo_id
			)
		)
		FROM person p
		WHERE p.id = m.director_id
	) AS "Director",
	(
		SELECT array_agg(
			json_build_object(
				'id', a.id,
				'first_name', a.first_name, 
				'last_name', a.last_name,
				'photo', (
					SELECT json_build_object(
						'id', af.id,
						'file_name', af.file_name,
						'mime_type', af.mime_type,
						'key', af.key, 
						'url', af.url
					)
					FROM file af
					WHERE af.id = a.main_photo_id
				)
			)
		)
		FROM person a
		INNER JOIN movie_person_character mpc ON a.id = mpc.person_id
		WHERE mpc.movie_id = m.id
	) AS "Actors",
	(
		SELECT json_agg(
 			json_build_object(
				'id', g.id, 
				'name', g.name
			)
		)
		FROM genre g 
		INNER JOIN movie_genre mg ON g.id = mg.genre_id
		WHERE mg.movie_id = m.id
	) AS "Genres"
FROM
	movie m
WHERE 
	m.id = 1;
