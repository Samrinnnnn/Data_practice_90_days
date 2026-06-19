# DBQuacks Christmas Heist Solutions

---My solutions to the [DBQuacks Christmas Heist 2025](https://dbquacks.com/challenges?series=christmas) SQL challenges (powered by DuckDB).

--Challenge 1: The Missing Presents Report
--Return the total number of missing presents.
SELECT SUM(quantity_missing) as missing_presents FROM missing_presents_report;

--Challenge 2: The Suspect Pool
--Count how many volunteers have an experience_level of 7 or higher. You will be working with the `volunteer_ducks` table
SELECT COUNT(experience_level )
  FROM volunteer_ducks 
  GROUP BY experience_level
    HAVING COUNT(experience_level) >=7;

----Challenge 3: The Pattern Emerges
----Find the district with the most theft reports. Each report has a household_id that links to a household, 
--and each household belongs to a district. You will be working with the `missing_presents_report` and `duck_households` tables.
-- Enter your SQL query here
SELECT mode(d.district) AS most_theft FROM duck_households d
JOIN missing_presents_report m ON d.household_id=m.household_id;
 

