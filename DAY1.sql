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

--5.
