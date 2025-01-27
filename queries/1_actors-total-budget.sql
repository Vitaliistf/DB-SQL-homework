-- Вибрати список акторів разом із загальним бюджетом фільмів, в яких вони з’явилися
-- ID
-- First name
-- Last name
-- Total movies budget

SELECT 
	p.id AS "ID", 
	p.first_name AS "First name", 
	p.last_name AS "Last name", 
	SUM(m.budget) AS "Total movies budget"
FROM 
	person p
-- ↓ INNER JOIN to exclude non-actors(directors), LEFT JOIN to include them
INNER JOIN 
	movie_person_character mpc ON p.id = mpc.person_id
INNER JOIN 
	movie m ON mpc.movie_id = m.id
GROUP BY 
	p.id, p.first_name, p.last_name
ORDER BY 
	SUM(m.budget) DESC;