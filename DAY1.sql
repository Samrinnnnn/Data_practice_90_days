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

--10.



