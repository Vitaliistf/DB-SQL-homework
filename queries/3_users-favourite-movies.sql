-- Отримати список усіх користувачів разом із їхніми улюбленими фільмами у вигляді масиву ідентифікаторів
-- ID
-- Username
-- Favorite movie IDs

SELECT 
	u.id AS "ID",
	u.username AS "Username",
	ARRAY_AGG(fm.movie_id) AS "Favorite movie IDs"
FROM 
	user_account u
-- ↓ INNER JOIN here to exclude users that do not have favorite movies
LEFT JOIN 
	favorite_movie fm on fm.user_account_id = u.id
GROUP BY
	u.id, u.username
ORDER BY
	u.id