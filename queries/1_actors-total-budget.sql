-- Вибрати список акторів разом із загальним бюджетом фільмів, в яких вони з’явилися
-- ID
-- First name
-- Last name
-- Total movies budget

SELECT 
	p.id as "ID", 
	p.first_name as "First name", 
	p.last_name as "Last name", 
	SUM(m.budget) as "Total movies budget"
FROM 
	person p
LEFT JOIN 
	movie_person_character mpc ON p.id = mpc.person_id
LEFT JOIN 
	movie m ON mpc.movie_id = m.id
GROUP BY 
	p.id, p.first_name, p.last_name
HAVING					-- Not including non-actors(directors)
    SUM(m.budget) > 0
ORDER BY 
	"Total movies budget" DESC;