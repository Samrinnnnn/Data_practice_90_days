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
