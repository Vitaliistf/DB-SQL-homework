-- Вибрати режисерів разом із середнім бюджетом фільмів, які вони зняли
-- Director ID
-- Director name (concatenation of first and last names)
-- Average budget

SELECT
	p.id AS "Director ID",
	CONCAT(p.first_name, ' ', p.last_name) AS "Director name",
	AVG(m.budget) AS "Average budget"
FROM
	person p
-- ↓ Include only people who directed movies. To include everyone use LEFT JOIN and COALESCE(AVG(m.budget), 0)
RIGHT JOIN
	movie m ON m.director_id = p.id
GROUP BY
	p.id, p.first_name, p.last_name
ORDER BY
	AVG(m.budget) DESC