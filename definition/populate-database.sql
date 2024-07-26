-- P.S. This data is not the best for testing some of the queries. You might need change query parameters 
-- or some rows to test it properly.

-- Populate file table
INSERT INTO file (file_name, mime_type, key, url) VALUES
('avatar1.jpg', 'image/jpeg', 'avatars/avatar1.jpg', 'https://example.com/avatars/avatar1.jpg'),
('avatar2.png', 'image/png', 'avatars/avatar2.png', 'https://example.com/avatars/avatar2.png'),
('movie_poster1.jpg', 'image/jpeg', 'posters/movie_poster1.jpg', 'https://example.com/posters/movie_poster1.jpg'),
('movie_poster2.jpg', 'image/jpeg', 'posters/movie_poster2.jpg', 'https://example.com/posters/movie_poster2.jpg'),
('actor_photo1.jpg', 'image/jpeg', 'actors/actor_photo1.jpg', 'https://example.com/actors/actor_photo1.jpg'),
('actor_photo2.jpg', 'image/jpeg', 'actors/actor_photo2.jpg', 'https://example.com/actors/actor_photo2.jpg'),
('director_photo1.jpg', 'image/jpeg', 'directors/director_photo1.jpg', 'https://example.com/directors/director_photo1.jpg'),
('director_photo2.jpg', 'image/jpeg', 'directors/director_photo2.jpg', 'https://example.com/directors/director_photo2.jpg'),
('movie_poster3.jpg', 'image/jpeg', 'posters/movie_poster3.jpg', 'https://example.com/posters/movie_poster3.jpg'),
('actor_photo3.jpg', 'image/jpeg', 'actors/actor_photo3.jpg', 'https://example.com/actors/actor_photo3.jpg');

-- Populate country table
INSERT INTO country (name) VALUES
('United States'), ('United Kingdom'), ('France'), ('Germany'), ('Japan'),
('South Korea'), ('Canada'), ('Australia'), ('Italy'), ('Spain');

-- Populate user_account table
INSERT INTO user_account (username, first_name, last_name, email, password, avatar_id) VALUES
('john_doe', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', 1),
('jane_smith', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', 2),
('bob_johnson', 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashed_password_3', NULL),
('alice_williams', 'Alice', 'Williams', 'alice.williams@example.com', 'hashed_password_4', NULL),
('charlie_brown', 'Charlie', 'Brown', 'charlie.brown@example.com', 'hashed_password_5', NULL),
('emma_davis', 'Emma', 'Davis', 'emma.davis@example.com', 'hashed_password_6', NULL),
('michael_wilson', 'Michael', 'Wilson', 'michael.wilson@example.com', 'hashed_password_7', NULL),
('olivia_jones', 'Olivia', 'Jones', 'olivia.jones@example.com', 'hashed_password_8', NULL),
('william_taylor', 'William', 'Taylor', 'william.taylor@example.com', 'hashed_password_9', NULL),
('sophia_brown', 'Sophia', 'Brown', 'sophia.brown@example.com', 'hashed_password_10', NULL);

-- Populate genre table
INSERT INTO genre (name) VALUES
('Action'), ('Comedy'), ('Drama'), ('Science Fiction'), ('Horror'),
('Romance'), ('Thriller'), ('Adventure'), ('Fantasy'), ('Animation');

-- Populate person table
INSERT INTO person (first_name, last_name, biography, date_of_birth, gender, country_id, main_photo_id) VALUES
('Tom', 'Hanks', 'American actor and filmmaker', '1956-07-09', 'male', 1, 5),
('Meryl', 'Streep', 'American actress', '1949-06-22', 'female', 1, 6),
('Leonardo', 'DiCaprio', 'American actor and producer', '1974-11-11', 'male', 1, NULL),
('Scarlett', 'Johansson', 'American actress', '1984-11-22', 'female', 1, NULL),
('Brad', 'Pitt', 'American actor and producer', '1963-12-18', 'male', 1, NULL),
('Cate', 'Blanchett', 'Australian actress', '1969-05-14', 'female', 8, NULL),
('Denzel', 'Washington', 'American actor and director', '1954-12-28', 'male', 1, NULL),
('Viola', 'Davis', 'American actress and producer', '1965-08-11', 'female', 1, NULL),
('Robert', 'De Niro', 'American actor and producer', '1943-08-17', 'male', 1, NULL),
('Meryl', 'Streep', 'American actress', '1949-06-22', 'female', 1, NULL);

-- Populate person_photo table
INSERT INTO person_photo (person_id, file_id) VALUES
(1, 5), (1, 6), (2, 5), (2, 6), (3, 5), (3, 6),
(4, 5), (4, 6), (5, 5), (5, 6);

-- Populate movie table
INSERT INTO movie (title, description, budget, release_date, duration, director_id, country_id, poster_id) VALUES
('The Shawshank Redemption', 'Two imprisoned men bond over a number of years', 25000000, '1994-09-22', 142, 1, 1, 3),
('The Godfather', 'The aging patriarch of an organized crime dynasty', 6000000, '1972-03-24', 175, 2, 1, 4),
('The Dark Knight', 'Batman fights the menace known as the Joker', 185000000, '2008-07-18', 152, 3, 1, 3),
('12 Angry Men', 'A jury holdout attempts to prevent a miscarriage of justice', 350000, '1957-04-10', 96, 4, 1, 4),
('Schindler''s List', 'In German-occupied Poland during World War II', 22000000, '1993-12-15', 195, 5, 1, 3),
('The Lord of the Rings: The Return of the King', 'Gandalf and Aragorn lead the World of Men against Sauron''s army', 94000000, '2003-12-17', 201, 6, 1, 4),
('Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife', 8000000, '1994-10-14', 154, 7, 1, 3),
('The Good, the Bad and the Ugly', 'A bounty hunting scam joins two men in an uneasy alliance', 1200000, '1966-12-23', 178, 8, 5, 4),
('Forrest Gump', 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal', 55000000, '1994-07-06', 142, 1, 1, 3),
('Inception', 'A thief who steals corporate secrets through the use of dream-sharing technology', 160000000, '2010-07-16', 148, 3, 1, 4);

-- Populate movie_genre table
INSERT INTO movie_genre (movie_id, genre_id) VALUES
(1, 3), (2, 3), (3, 1), (3, 7), (4, 3), (5, 3),
(6, 1), (6, 8), (6, 9), (7, 3), (7, 7), (8, 1),
(9, 3), (9, 6), (10, 1), (10, 4), (10, 7);

-- Populate character table
INSERT INTO character (name, description, role) VALUES
('Andy Dufresne', 'Wrongfully convicted banker', 'leading'),
('Ellis Boyd ''Red'' Redding', 'Prison contraband smuggler', 'leading'),
('Vito Corleone', 'Patriarch of the Corleone family', 'leading'),
('Michael Corleone', 'Youngest son of Vito Corleone', 'leading'),
('Batman / Bruce Wayne', 'Billionaire superhero', 'leading'),
('The Joker', 'Criminal mastermind', 'leading'),
('Juror 8', 'Architect and initial holdout', 'leading'),
('Oskar Schindler', 'German industrialist', 'leading'),
('Frodo Baggins', 'Hobbit and Ring-bearer', 'leading'),
('Vincent Vega', 'Hitman working for Marsellus Wallace', 'leading');

-- Populate movie_person_character table
INSERT INTO movie_person_character (movie_id, person_id, character_id) VALUES
(1, 1, 1), (1, 2, 2), (2, 3, 3), (2, 4, 4), (3, 5, 5),
(3, 6, 6), (4, 7, 7), (5, 8, 8), (6, 9, 9), (7, 10, 10);

-- Populate favorite_movie table
INSERT INTO favorite_movie (user_account_id, movie_id) VALUES
(1, 1), (1, 3), (2, 2), (2, 4), (3, 5), (3, 7),
(4, 6), (4, 8), (5, 9), (5, 10);
