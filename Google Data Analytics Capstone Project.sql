-- ----------Combining all data files into one
CREATE TABLE cyclistic_data
(
    ride_id TEXT,
    rideable_type TEXT,
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    start_lat NUMERIC,
    start_lng NUMERIC,
    end_lat NUMERIC,
    end_lng NUMERIC,
    member_casual TEXT
)


\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2023_08-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2023_09-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2023_10-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2023_11-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2023_12-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2024_01-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2024_02-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2024_03-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2024_04-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2024_05-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2023_06-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy cyclistic_data FROM 'C:\Users\jatin\SQL Project Data Job Analysis\CSV_GDACP_Files\D2023_07-divvy-tripdata.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

SELECT *
FROM cyclistic_data

-- ----------Saving combined file
\copy cyclistic_data TO 'C:\Users\jatin\Downloads\combined_cyclistic_data.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');



-- ----------------------------------------CREATE FINAL TABLE------------------------------------------

-- Create a final table with calculated columns

CREATE TABLE cyclistic_final AS
SELECT *,
    (ended_at - started_at) AS ride_length, -- Calculate total ride length
    TO_CHAR(started_at, 'Day') AS day_of_week, -- Extract the day of the week
    DATE(started_at) AS date, -- Extract the date (yyyy-mm-dd)
    EXTRACT(MONTH FROM started_at) AS month, -- Extract the month
    EXTRACT(DAY FROM started_at) AS day, -- Extract the day
    EXTRACT(YEAR FROM started_at) AS year, -- Extract the year
    EXTRACT(HOUR FROM started_at) AS hour -- Extract the hour
FROM 
    cyclistic_data;

SELECT * 
FROM cyclistic_final 
limit 10

-----Correcting a mistake
--Add a new numeric column
ALTER TABLE cyclistic_final ADD COLUMN ride_length_minutes NUMERIC;

--Update the ride_length_minutes column with rounded values
UPDATE cyclistic_final
SET ride_length_minutes = ROUND(EXTRACT(EPOCH FROM (ended_at - started_at)) / 60, 2);

--Optionally drop the old ride_length column if not needed
ALTER TABLE cyclistic_final DROP COLUMN ride_length;

--Optionally rename the new column to ride_length
ALTER TABLE cyclistic_final RENAME COLUMN ride_length_minutes TO ride_length;


-- -------------------------------------ADD SEASON COLUMN-----------------------------------------------
ALTER TABLE cyclistic_final
ADD COLUMN season TEXT;

-- Update the final table with a 'season' column based on the month
UPDATE cyclistic_final
SET season = CASE 
    WHEN month IN (3, 4, 5) THEN 'Spring'
    WHEN month IN (6, 7, 8) THEN 'Summer'
    WHEN month IN (9, 10, 11) THEN 'Fall'
    ELSE 'Winter'
END;

-- ------------------------------------ADD TIME OF DAY COLUMN--------------------------------------------
ALTER TABLE cyclistic_final
ADD COLUMN time_of_day TEXT;

-- Update the final table with a 'time_of_day' column based on the hour
UPDATE cyclistic_final
SET time_of_day = CASE 
    WHEN hour BETWEEN 0 AND 5 THEN 'Night'
    WHEN hour BETWEEN 6 AND 11 THEN 'Morning'
    WHEN hour BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END;

-- -----------------------------------------DATA CLEANING-----------------------------------------------

-- Remove rows with invalid data (negative or zero ride lengths)
DELETE FROM cyclistic_final
WHERE ride_length <= 0;

-- Remove rows with NA values
DELETE FROM cyclistic_final
WHERE ride_id IS NULL
   OR rideable_type IS NULL
   OR started_at IS NULL
   OR ended_at IS NULL
   OR start_lat IS NULL
   OR start_lng IS NULL
   OR end_lat IS NULL
   OR end_lng IS NULL
   OR member_casual IS NULL
   OR ride_length IS NULL;

-- ---------------------------------------TOTAL RIDES---------------------------------------------------

-- Count the total number of rides
SELECT COUNT(*) AS total_rides
FROM cyclistic_final;

-- TOTAL RIDES = 5663066

-- ----------------------------MEMBER TYPE (MEMBER VS. CASUAL)------------------------------------------

-- Count rides by member type (member vs casual)
SELECT member_casual, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY member_casual;

--Casual = 2019258
--Member = 3643808

-- -----------------------------TYPE OF BIKE------------------------------------------------------------

-- Count rides by bike type and member type
SELECT member_casual, rideable_type, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY member_casual, rideable_type;

-- Count rides by bike type only
SELECT rideable_type, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY rideable_type;

-- -------------------------------HOUR ANALYSIS----------------------------------------------------------

-- Count rides by hour and member type
SELECT member_casual, hour, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY member_casual, hour
ORDER BY hour;

-- Count total rides by hour
SELECT hour, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY hour;

-- ----------------------------TIME OF DAY ANALYSIS-----------------------------------------------------

-- Count rides by time of day and member type for Morning
SELECT member_casual, COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Morning'
GROUP BY member_casual;

-- Count total rides in the Morning
SELECT COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Morning';

-- Count rides by time of day and member type for Afternoon
SELECT member_casual, COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Afternoon'
GROUP BY member_casual;

-- Count total rides in the Morning
SELECT COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Afternoon';

-- Count rides by time of day and member type for Evening
SELECT member_casual, COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Evening'
GROUP BY member_casual;

-- Count total rides in the Morning
SELECT COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Evening';

-- Count rides by time of day and member type for Night
SELECT member_casual, COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Night'
GROUP BY member_casual;

-- Count total rides in the Morning
SELECT COUNT(*) AS total_rides
FROM cyclistic_final
WHERE time_of_day = 'Night';

-- -----------------------------AVERAGE RIDE LENGTH ANALYSIS--------------------------------------------

-- Calculate the overall average ride length
SELECT AVG(ride_length) AS avg_ride_length
FROM cyclistic_final;

-- Calculate the average ride length by member type
SELECT member_casual, AVG(ride_length) AS avg_ride_length
FROM cyclistic_final
GROUP BY member_casual;

-- ----------------------------BIKE TYPE ANALYSIS------------------------------------------------------

-- Calculate the average ride length by bike type
SELECT rideable_type, AVG(ride_length) AS avg_ride_length
FROM cyclistic_final
GROUP BY rideable_type;

-- Count total rides by bike type
SELECT rideable_type, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY rideable_type;

-- Count rides by bike type and member type (for more granular insights)
SELECT member_casual, rideable_type, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY member_casual, rideable_type;

-- ------------------------------HOUR OF DAY ANALYSIS----------------------------------------------------

-- Calculate the average ride length by hour of the day
SELECT hour, AVG(ride_length) AS avg_ride_length
FROM cyclistic_final
GROUP BY hour
ORDER BY hour;

-- Count total rides by hour of the day
SELECT hour, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY hour
ORDER BY hour;

-- Count rides by hour of the day and member type
SELECT member_casual, hour, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY member_casual, hour
ORDER BY hour;

-- ----------------------------TIME OF DAY ANALYSIS-----------------------------------------------------

-- Calculate the average ride length by time of day
SELECT time_of_day, AVG(ride_length) AS avg_ride_length
FROM cyclistic_final
GROUP BY time_of_day;

-- Count total rides by time of day
SELECT time_of_day, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY time_of_day;

-- Count rides by time of day and member type
SELECT member_casual, time_of_day, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY member_casual, time_of_day;

-- -----------------------------SEASONAL ANALYSIS-------------------------------------------------------

-- Calculate the average ride length by season
SELECT season, AVG(ride_length) AS avg_ride_length
FROM cyclistic_final
GROUP BY season;

-- Count total rides by season
SELECT season, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY season;

-- Count rides by season and member type
SELECT member_casual, season, COUNT(*) AS total_rides
FROM cyclistic_final
GROUP BY member_casual, season;



-- Save File
COPY (SELECT * FROM cyclistic_final) 
TO 'C:/Users/jatin/Downloads/cyclistic_data_modified.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',');


