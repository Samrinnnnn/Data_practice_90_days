# DBQuacks Christmas Heist Solutions

---My solutions to the [DBQuacks Christmas Heist 2025](https://dbquacks.com/challenges?series=christmas) SQL challenges (powered by DuckDB).

--Challenge 1: The Missing Presents Report
--Return the total number of missing presents.
SELECT SUM(quantity_missing) as missing_presents FROM missing_presents_report;
