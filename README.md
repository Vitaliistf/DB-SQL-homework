# Movie Database

## Overview

This project consists of a PostgreSQL database designed to store and manage information about movies, including details about actors, directors, genres, countries, and users. The database schema includes various tables to handle the relationships and attributes associated with movies and the people involved in their production.

## Directory Structure

```
/definition
  ├── create-database.sql
  └── populate-database.sql
/queries
  ├── 1_actors-total-budget.sql
  ├── 2_movie-actors-count.sql
  ├── 3_users-favourite-movies.sql
  ├── 4_directors-avg-budget.sql
  ├── 5_movies-by-criteria.sql
  └── 6_detailed-movie-info.sql
README.md
```

- **definition/create-database.sql**: Contains SQL statements to create all necessary tables and constraints.
- **definition/populate-database.sql**: Contains SQL statements to populate the tables with sample data.
- **queries/**: Contains individual SQL query files for retrieving specific information from the database.

## Database Schema

The database schema includes the following tables:

- `file`: Stores information about files (e.g., images, documents).
- `country`: Stores information about countries.
- `user_account`: Stores information about users.
- `genre`: Stores information about movie genres.
- `person`: Stores information about people (e.g., actors, directors).
- `person_photo`: Stores relationships between people and their photos.
- `movie`: Stores information about movies.
- `movie_genre`: Stores relationships between movies and genres.
- `character`: Stores information about characters in movies.
- `movie_person_character`: Stores relationships between movies, people, and characters.
- `favorite_movie`: Stores relationships between users and their favorite movies.

## ER-Diagram

```mermaid
erDiagram
    USER {
        int id PK
        string username
        string first_name
        string last_name
        string email
        string password
        int avatar_id FK
        datetime created_at
        datetime updated_at
    }

    FILE {
        int id PK
        string file_name
        string mime_type
        string key
        string url
        datetime created_at
        datetime updated_at
    }

    COUNTRY {
        int id PK
        string name
        datetime created_at
        datetime updated_at
    }

    GENRE {
        int id PK
        string name
        datetime created_at
        datetime updated_at
    }

    PERSON {
        int id PK
        string first_name
        string last_name
        text biography
        date date_of_birth
        %% ENUM('male', 'female', 'other')
        enum gender 
        int country_id FK
        int main_photo_id FK
        datetime created_at
        datetime updated_at
    }

    PERSON_PHOTO {
        int id PK
        int person_id FK
        int file_id FK
        datetime created_at
        datetime updated_at
    }

    MOVIE {
        int id PK
        string title
        text description
        decimal budget
        date release_date
        int duration
        int director_id FK
        int country_id FK
        int poster_id FK
        datetime created_at
        datetime updated_at
    }

    MOVIE_GENRE {
        int movie_id FK, PK
        int genre_id FK, PK
        datetime created_at
        datetime updated_at
    }

    CHARACTER {
        int id PK
        string name
        text description
        %% ENUM('leading', 'supporting', 'background')
        enum role
        datetime created_at
        datetime updated_at
    }

    MOVIE_PERSON_CHARACTER {
        int id PK
        int movie_id FK
        int person_id FK
        int character_id FK
        datetime created_at
        datetime updated_at
    }

    FAVORITE_MOVIE {
        int user_id FK, PK
        int movie_id FK, PK
        datetime created_at
        datetime updated_at
    }

    USER ||--o| FILE: "has avatar"
    USER ||--o{ FAVORITE_MOVIE : "has"
    MOVIE ||--o| FILE: "has poster" 
    MOVIE ||--o{ MOVIE_GENRE: "has"
    MOVIE ||--o{ MOVIE_PERSON_CHARACTER : "involves"
    COUNTRY ||--o{ MOVIE : "is origin of"
    COUNTRY ||--o{ PERSON: "is origin of"
    GENRE ||--o{ MOVIE_GENRE: "belongs to"
    FILE ||--o{ PERSON_PHOTO : "has"
    FILE ||--o| PERSON : "is main photo for"
    PERSON ||--o{ PERSON_PHOTO : "has"
    PERSON ||--o{ MOVIE: "directed"
    PERSON |o--o{ MOVIE_PERSON_CHARACTER : "participates in"
    CHARACTER |o--o{ MOVIE_PERSON_CHARACTER : "played by"
    FAVORITE_MOVIE }o--|| MOVIE : "refers to"
```

## How to Set Up

1. **Create the Database**: Run the `definition/create-database.sql` script to create the database tables and constraints.
   ```sh
   psql -U your_username -d your_database -f definition/create-database.sql
   ```

2. **Populate the Database**: Run the `definition/populate-database.sql` script to insert sample data into the tables.
   ```sh
   psql -U your_username -d your_database -f definition/populate-database.sql
   ```

3. **Run Queries**: Use the `queries/1_actors-total-budget.sql` file to run predefined queries against the database.
   ```sh
   psql -U your_username -d your_database -f queries/1_actors-total-budget.sql
   ```
   
---

This README provides a basic overview and instructions for setting up and using the movie database. For more detailed information, please refer to the individual SQL files.
