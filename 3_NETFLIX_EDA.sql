CREATE TABLE netflix (
    show_id VARCHAR(10),
    type VARCHAR(20),
    title VARCHAR(200),
    director VARCHAR(300),
    cast TEXT,
    country VARCHAR(150),
    date_added VARCHAR(20),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    genres VARCHAR(200),
    description TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/3_NetFlix.csv'
INTO TABLE netflix
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM netflix LIMIT 1000;

-- CHECKING FOR NULL VALUES
SELECT 
	SUM(CASE WHEN show_id IS NULL OR show_id = '' THEN 1 ELSE 0 END) AS SHOWID_NULL,
    SUM(CASE WHEN `type` IS NULL OR `type` = '' THEN 1 ELSE 0 END) AS type_null,
    SUM(CASE WHEN title IS NULL OR title = '' THEN 1 ELSE 0 END) AS title_null,
    SUM(CASE WHEN director IS NULL OR director = '' THEN 1 ELSE 0 END) AS director_NULL,
    SUM(CASE WHEN cast IS NULL OR cast = '' THEN 1 ELSE 0 END) AS cast_NULL,
	SUM(CASE WHEN country IS NULL OR country = '' THEN 1 ELSE 0 END) AS country_NULL,
	SUM(CASE WHEN date_added IS NULL OR date_added = '' THEN 1 ELSE 0 END) AS date_added_NULL,
	SUM(CASE WHEN release_year IS NULL OR release_year = '' THEN 1 ELSE 0 END) AS release_year_NULL,
    SUM(CASE WHEN rating IS NULL OR rating = '' THEN 1 ELSE 0 END) AS rating_NULL,
    SUM(CASE WHEN duration IS NULL OR duration = '' THEN 1 ELSE 0 END) AS duration_NULL,
    SUM(CASE WHEN genres IS NULL OR genres = '' THEN 1 ELSE 0 END) AS genres_NULL,
    SUM(CASE WHEN `description` IS NULL OR `description` = '' THEN 1 ELSE 0 END) AS description_null
FROM netflix;

-- director = 2389 null values
-- cast = 718 null values
-- country = 507 null values
-- date_added = 10 null values
-- rating = 7 null values


-- CREATING A DUPLICATE DATASET
CREATE TABLE netflix_data LIKE netflix;


INSERT INTO netflix_data 
SELECT * FROM netflix;

-- NOW DROPPING THE ROWS WITH THE LEAST NULL VALUES
DELETE FROM netflix_data
WHERE date_added IS NULL OR date_added = '';

DELETE FROM netflix_data
WHERE rating IS NULL OR rating = '';

-- FILLING THE BLANK COLUMNS 
UPDATE netflix_data
SET director = 'Unknown'
WHERE director = '';

UPDATE netflix_data
SET cast = 'Unknown'
WHERE cast = '';

UPDATE netflix_data
SET country = 'Unknown'
WHERE country = '';

SELECT * FROM netflix_data;

-- TOTAL NUMBER OF TV SHOWS AND MOVIES
SELECT 
    `type`,
    COUNT(*) AS total_count
FROM netflix_data
GROUP BY `type`;

-- COUNTRY WITH THE MOST CONTENT
SELECT country , COUNT(*) AS TOTAL_COUNT FROM netflix_data
GROUP BY country
ORDER BY 2 DESC; -- UNITED STATES


-- TOTAL NUMBER 0F CONTENT BY UNITED STATES
SELECT country , COUNT(*) AS TOTAL_COUNT 
FROM netflix_data
WHERE country LIKE '%United States%'
GROUP BY 1;

--  Content Analysis

-- TOP 10 MOST COMMON GENRE
SELECT DISTINCT genres , COUNT(*) AS TOTAL_COUNT
FROM netflix_data
GROUP BY 1
ORDER BY 2 DESC;

-- DIRECTOR WITH THE MOST TITLES
SELECT director, COUNT(*) AS total_count
FROM netflix_data
WHERE director != 'Unknown'
GROUP BY director
ORDER BY total_count DESC
LIMIT 10;

-- DIRECTOR WITH THE MOST TV SHOW AND MOVIES
SELECT director, `type` , COUNT(*) AS TOTAL_COUNT
FROM netflix_data
WHERE director != 'Unknown'
GROUP BY 1, 2
ORDER BY 3 DESC;

-- COUNTRY WITH THE MOST TV SHOW AND MOVIES
SELECT country, `type` , COUNT(*) AS TOTAL_COUNT
FROM netflix_data
WHERE country != 'Unknown'
GROUP BY 1, 2
ORDER BY 3 DESC;

-- MOST COMMON RATINGS
SELECT rating , COUNT(*) AS TOTAL_COUNT
FROM netflix_data
GROUP BY 1 
ORDER BY 2 DESC;

            -- TIME ANALYSIS
-- NO OF MOVIES ADDED PER YEAR
SELECT `type`, 
	YEAR(STR_TO_DATE(date_added, '%d-%b-%y')) AS year,
    COUNT(*) AS TOTAL_NUMBER
FROM netflix_data
WHERE `type` = 'Movie'
GROUP BY 1,2
ORDER BY 3 DESC;

-- YEAR WITH THE MOST CONTENT RELEASED 
SELECT `type`, 
	YEAR(STR_TO_DATE(date_added, '%d-%b-%y')) AS year,
    COUNT(*) AS TOTAL_NUMBER
FROM netflix_data
GROUP BY 1,2
ORDER BY 1,3 DESC;


-- AVERAGE MOVIE DURATION
SELECT `type` , duration from netflix_data
group by 1,2
order by 2 desc;

SELECT `type`,
	AVG(duration) as AVGARAGE_DURATION
FROM netflix_data
WHERE `type` = 'Movie'
ORDER BY 2 DESC;

-- NO OF SEASON THAT TV SHOWS HAVE
SELECT `type`,
	AVG(duration) as AVGARAGE_DURATION
FROM netflix_data
WHERE `type` = 'TV Show'
ORDER BY 2 DESC;
    
    
-- DIRECTORS WHO MADE BOTH TV SHOWS AND MOVIES
SELECT director, 
    SUM(CASE WHEN `type` = 'Movie' THEN 1 ELSE 0 END) AS total_movies,
    SUM(CASE WHEN `type` = 'TV Show' THEN 1 ELSE 0 END) AS total_tvshows
FROM netflix_data
WHERE director != 'Unknown'
GROUP BY director
HAVING total_movies > 0 AND total_tvshows > 0
ORDER BY total_movies DESC;

-- MOST POPULAR GENRE PER COUNTRY

SELECT country, genres, total_count
FROM (
    SELECT country, genres, COUNT(*) AS total_count,
    RANK() OVER(PARTITION BY country ORDER BY COUNT(*) DESC) AS `rank`
    FROM netflix_data
    WHERE country != 'Unknown'
    GROUP BY country, genres
) AS t1
WHERE `rank` = 1
ORDER BY total_count DESC
LIMIT 15;
