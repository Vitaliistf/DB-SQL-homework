-- Table for files
CREATE TABLE file (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for countries
CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for users
CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (avatar_id) REFERENCES file(id) ON DELETE SET NULL
);

-- Table for genres
CREATE TABLE genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE gender AS ENUM ('male', 'female', 'other');

-- Table for people
CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender gender,
    country_id INTEGER,
    main_photo_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (country_id) REFERENCES country(id) ON DELETE SET NULL,
    FOREIGN KEY (main_photo_id) REFERENCES file(id) ON DELETE SET NULL
);

-- Table for people-photos relations
CREATE TABLE person_photo (
    id SERIAL PRIMARY KEY,
    person_id INTEGER NOT NULL,
    file_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE,
    FOREIGN KEY (file_id) REFERENCES file(id) ON DELETE CASCADE,
    UNIQUE(person_id, file_id)
);

-- Table for movies
CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(15, 2),
    release_date DATE,
    duration INTEGER,
    director_id INTEGER,
    country_id INTEGER,
    poster_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (director_id) REFERENCES person(id) ON DELETE SET NULL,
    FOREIGN KEY (country_id) REFERENCES country(id) ON DELETE SET NULL,
    FOREIGN KEY (poster_id) REFERENCES file(id) ON DELETE SET NULL
);

-- Table for movies-genres relations
CREATE TABLE movie_genre (
    movie_id INTEGER,
    genre_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre(id) ON DELETE CASCADE
);

CREATE TYPE character_role AS ENUM ('leading', 'supporting', 'background');

-- Table for characters
CREATE TABLE character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    role character_role NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for movies-people-characters relations
CREATE TABLE movie_person_character (
    id SERIAL PRIMARY KEY,
    movie_id INTEGER NOT NULL,
    person_id INTEGER,
    character_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE,
    FOREIGN KEY (character_id) REFERENCES character(id) ON DELETE CASCADE
);

-- Table for favorite movies
CREATE TABLE favorite_movie (
    user_id INTEGER,
    movie_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);
   
-- updated_at updating function
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- updated_at updating triggers
CREATE TRIGGER update_user_modtime BEFORE UPDATE ON user FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_file_modtime BEFORE UPDATE ON file FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_country_modtime BEFORE UPDATE ON country FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_genre_modtime BEFORE UPDATE ON genre FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_person_modtime BEFORE UPDATE ON person FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_person_photo_modtime BEFORE UPDATE ON person_photo FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_movie_modtime BEFORE UPDATE ON movie FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_movie_genre_modtime BEFORE UPDATE ON movie_genre FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_character_modtime BEFORE UPDATE ON character FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_movie_person_character_modtime BEFORE UPDATE ON movie_person_character FOR EACH ROW EXECUTE FUNCTION update_modified_column();
CREATE TRIGGER update_favorite_movie_modtime BEFORE UPDATE ON favorite_movie FOR EACH ROW EXECUTE FUNCTION update_modified_column();