/*FROM my repository music_app_analysis data is taken */

--1.Write a query to show the number of plays per day for the last 7 days. Show play_date and daily_plays.
--Order by most recent date first.
SELECT DATE(played_at) AS play_date,COUNT(played_at) AS daily_plays
FROM play_history
WHERE played_at >= CURRENT_DATE-INTERVAL '7 days'
GROUP BY DATE(played_at)
ORDER BY daily_plays DESC;

--2. Write a query to find users who have listened to more than 20 songs total.
--Show user_name and total_plays. Order by most plays first.
SELECT u.user_name, COUNT(ph.history_id) AS total_plays
FROM users u
JOIN play_history ph ON u.user_name=ph.user_name
GROUP BY u.user_name
HAVING COUNT(ph.history_id) >20
ORDER BY total_plays DESC;

--3.Write a query to check if the column user_name exists in the table or not.
SELECT CASE WHEN EXISTS (select 1 FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME='users'
AND COLUMN_NAME='user_name')
THEN 'Column Exists'
ELSE 'Column does not Exist'
END AS message;

--4.Write a query to find each user's most active hour of the day
--(the hour when they listened the most). Show user_name, hour_of_day, 
--and play_count (number of plays during that hour). Each user should 
--appear only once. Order by play_count descending.
SELECT DISTINCT ON(user_name) user_name,EXTRACT(HOUR FROM played_at) AS hour_of_day, 
COUNT(history_id) AS play_count 
FROM play_history 
GROUP BY user_name, hour_of_day
ORDER BY user_name,hour_of_day;

--5.Write a query to find the average rating for each genre, but only 
--include genres that have at least 3 songs. Show genre and
--avg_rating (rounded to 2 decimal places). 
--Order by highest average rating first.
SELECT genre,ROUND(AVG(rating),2) as avg_rating
FROM songs
GROUP BY genre
HAVING COUNT(song_id)>=3
ORDER BY avg_rating DESC;

--6. Write a query to find the highest rated song for each artist. 
--Show artist, title, and rating. Each artist should appear only once. 
--Order by artist name.
SELECT DISTINCT ON (artist) artist,title,rating
FROM songs
ORDER BY artist,rating DESC;

--7.Write a query to find users who have listened to the same song multiple
--times (same user, same song, more than once). 
--Show user_name, song_id, and play_count. 
--Order by play_count descending.
SELECT user_name,song_id,COUNT(history_id) AS play_count
FROM play_history
GROUP BY user_name,song_id
HAVING COUNT(history_id)>1
ORDER BY play_count DESC;

--8.Write a query to find all Pop songs with rating greater than 4.5. 
--Show title, artist, rating and rank. Order by rating from highest to lowest.
SELECT title,artist,rating ,ROW_NUMBER()OVER(ORDER BY rating DESC) AS rank
FROM songs 
WHERE genre='Pop' AND rating > 4.5
ORDER BY rating DESC;

--9.Write a query to find users who have more than 50 total plays. 
--Show user_name and total_plays. Order by highest plays first.
SELECT user_name,COUNT(history_id) AS total_plays
FROM play_history 
GROUP BY user_name
HAVING COUNT(history_id)>50
ORDER BY total_plays DESC;

--10.Write a query to find the top 5 most played songs.
--Show title, artist, and play_count. Order by play_count descending.
SELECT s.title,s.artist, COUNT(ph.history_id) AS play_count
FROM songs s
JOIN play_history ph ON s.song_id=ph.song_id
GROUP BY s.title,s.artist
ORDER BY play_count DESC
LIMIT 5;

--11.Write a query to find songs that have NEVER been played. 
--Show song_id, title, and artist. Order by title.
SELECT s.song_id,s.title,s.artist 
FROM songs s
LEFT JOIN play_history ph ON s.song_id=ph.song_id
GROUP BY s.song_id,s.title,s.artist
HAVING COUNT(ph.history_id)=0
ORDER BY s.title;

--12.Write a query to display songs where the title contains the word 'Love' (case-insensitive). 
--Show title and artist. Order by title.
SELECT title,artist FROM songs
WHERE title ILIKE '%love%'
ORDER BY title;

--13.Write a query to show each user's contact information -
--show user_name and contact (prefer phone, 
--if NULL use email, if both NULL show 'No contact').
SELECT user_name,COALESCE(COALESCE(phone,email),'No contact') AS contact
FROM users;

--14.Write a query to list all Premium songs and all songs with rating > 4.8 (combined, 
--no duplicates). Show title, artist, and a column reason. Order by title.
SELECT title,artist,'Premium' AS reason
FROM songs
WHERE is_premium=TRUE
UNION
SELECT title,artist,'High rating' AS reason
FROM songs
WHERE rating>4.8;

--15.Write a query to find users who listened to at least one song in the last 7 days. 
--Show user_name and last_play_date. Order by last_play_date descending.
SELECT user_name,MAX(played_at) AS last_play_date
FROM play_history
WHERE played_at >= CURRENT_DATE - INTERVAL'7 days'
GROUP BY user_name
ORDER BY last_play_date DESC;

--16.Write a query to find users who have NEVER listened to any song.
--Show user_name and full_name. Order by user_name.
SELECT u.user_name, u.full_name
FROM users u
LEFT JOIN play_history ph ON u.user_name = ph.user_name
WHERE ph.history_id IS NULL
ORDER BY u.user_name;

---------------------OR-----------------
SELECT u.user_name, u.full_name
FROM users u
WHERE NOT EXISTS (
    SELECT 1 FROM play_history ph
    WHERE ph.user_name = u.user_name
)
ORDER BY u.user_name;

--17. Write a query to show count of songs by rating value (1-5) for each genre. 
--Show genre, rating_1, rating_2, rating_3, rating_4, rating_5. 
--Order by genre.
SELECT genre,COUNT(CASE WHEN rating>=4.5 THEN 1 END) AS rating_5,
COUNT(CASE WHEN rating>=4.0 AND rating< 4.5 THEN 1 END) AS rating_4,
COUNT(CASE WHEN rating>=3.0 AND rating< 3.5 THEN 1 END) AS rating_3,
COUNT(CASE WHEN rating>=2.0 AND rating< 2.5 THEN 1  END) AS rating_2,
COUNT(CASE WHEN rating>=1.0 AND rating< 1.5  THEN 1 END) AS rating_1
FROM songs
GROUP BY genre
ORDER BY genre;

--18.Show user_name, current_song_id, next_song_id, played_at. 
--Order by user_name, played_at.
SELECT  user_name,song_id,COALESCE(LEAD(song_id)OVER (PARTITION BY user_name ORDER BY
played_at),0) AS next_song_id,played_at
FROM play_history 
ORDER BY user_name,played_at;

--19.Write a query to show each user and how many days ago they joined. 
--Show user_name, joined_date, and days_ago. Order by days_ago (newest first).
SELECT user_name,created_at AS joined_date,
(CURRENT_DATE-created_at::DATE)AS days_ago
FROM users
ORDER BY days_ago;

--20.
