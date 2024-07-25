-- Вибрати фільми, випущені за останні 5 років, з кількістю акторів, які з’явилися в кожному фільмі
-- ID
-- Title
-- Actors count

SELECT 
	m.id AS "ID",
	m.title AS "Title",
	COUNT(mpc.person_id) AS "Actors count"
FROM 
	movie m
LEFT JOIN
	movie_person_character mpc ON mpc.movie_id = m.id
WHERE
	m.release_date > CURRENT_DATE - INTERVAL '5 years'
GROUP BY
	m.id, m.title
