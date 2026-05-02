CREATE DATABASE cricket;
USE cricket;

-- UPLOADED DATA USING TABLE WIZARD
SELECT * FROM asiacup;
SELECT * FROM batsman_odi;
SELECT * FROM batsman_t20;
SELECT * FROM bowler_odi;
SELECT * FROM bowler_t20;
SELECT * FROM champion;

DESCRIBE asiacup;
DESCRIBE batsman_odi;
DESCRIBE batsman_t20;
DESCRIBE bowler_odi;
DESCRIBE bowler_t20;
DESCRIBE champion;

-- CHANGING THE NAME OF THE COLUMNS
ALTER TABLE asiacup 
RENAME COLUMN  ï»¿Team TO Team;

ALTER TABLE asiacup
RENAME COLUMN `Run Scored` TO run_scored,
RENAME COLUMN `Wicket Lost` TO wicket_lost,
RENAME COLUMN `Run Rate` TO run_rate,
RENAME COLUMN `Avg Bat Strike Rate` TO avg_bat_strike_rate,
RENAME COLUMN `Highest Score` TO higest_score,
RENAME COLUMN `Wicket Taken` TO wicket_taken,
RENAME COLUMN `Given Extras` TO extra_given,
RENAME COLUMN `Highest Individual wicket` TO highest_wicket_taker,
RENAME COLUMN `Player Of The Match` TO potm;


ALTER TABLE batsman_odi
RENAME COLUMN `Player Name` TO Player_name;

ALTER TABLE batsman_odi
RENAME COLUMN `Highest Score` TO highest_score;

ALTER TABLE batsman_odi
RENAME COLUMN `Time Period` TO time_period,
RENAME COLUMN `Not Outs` TO not_outs,
RENAME COLUMN `Batting Average` TO batting_avg,
RENAME COLUMN `Balls Faced` TO ball_faced,
RENAME COLUMN `Strike Rate` TO strike_rate;


ALTER TABLE batsman_t20
RENAME COLUMN `Highest Score` TO highest_score,
RENAME COLUMN `Player Name` TO Player_name,
RENAME COLUMN `Time Period` TO time_period,
RENAME COLUMN `Not Outs` TO not_outs,
RENAME COLUMN `Batting Average` TO batting_avg,
RENAME COLUMN `Balls Faced` TO ball_faced,
RENAME COLUMN `Strike Rate` TO strike_rate;


ALTER TABLE bowler_odi
RENAME COLUMN `Player Name` TO Player_name,
RENAME COLUMN `Maiden Overs` TO maiden_overs,
RENAME COLUMN `Best Figure` TO best_figure,
RENAME COLUMN `Bowling Average` TO bowling_average,
RENAME COLUMN `Economy Rate` TO economy_rate,
RENAME COLUMN `Strike Rate` TO strike_rate,
RENAME COLUMN `Four Wickets` TO four_wicket,
RENAME COLUMN `Five Wickets` TO five_wickets;

ALTER TABLE bowler_t20
RENAME COLUMN `Player Name` TO Player_name,
RENAME COLUMN `Maiden Overs` TO maiden_overs,
RENAME COLUMN `Best Figure` TO best_figure,
RENAME COLUMN `Bowling Average` TO bowling_average,
RENAME COLUMN `Economy Rate` TO economy_rate,
RENAME COLUMN `Strike Rate` TO strike_rate,
RENAME COLUMN `Four Wickets` TO four_wicket,
RENAME COLUMN `Five Wickets` TO five_wickets;

ALTER TABLE champion
RENAME COLUMN `ï»¿Year` TO hosting_year,
RENAME COLUMN `No Of Team` TO no_of_teams,
RENAME COLUMN `Runner Up` TO runner_ups,
RENAME COLUMN `Player Of The Series` TO pots,
RENAME COLUMN `Highest Run Scorer` TO highest_run_scorer,
RENAME COLUMN `Highest Wicket Taker` TO highest_wicket_taker;

ALTER TABLE bowler_odi
RENAME COLUMN `Time Period` TO time_period;

ALTER TABLE bowler_t20
RENAME COLUMN `Time Period` TO time_period;

-- CHECKING FOR NULL VALUES

SELECT 
	SUM(CASE WHEN Team IS NULL THEN 1 ELSE 0 END) AS TEAM_NULL,
	SUM(CASE WHEN Opponent IS NULL THEN 1 ELSE 0 END) AS Opponent,
	SUM(CASE WHEN `Format` IS NULL THEN 1 ELSE 0 END) AS `Format`,
	SUM(CASE WHEN Ground IS NULL THEN 1 ELSE 0 END) AS Ground,
	SUM(CASE WHEN `Year` IS NULL THEN 1 ELSE 0 END) AS Year_NULL,
	SUM(CASE WHEN Toss IS NULL THEN 1 ELSE 0 END) AS Toss,
	SUM(CASE WHEN Selection IS NULL THEN 1 ELSE 0 END) AS Selection,
	SUM(CASE WHEN run_scored IS NULL THEN 1 ELSE 0 END) AS run_scored,
	SUM(CASE WHEN wicket_lost IS NULL THEN 1 ELSE 0 END) AS wicket_lost,
	SUM(CASE WHEN Fours IS NULL THEN 1 ELSE 0 END) AS Fours,
	SUM(CASE WHEN Sixes IS NULL THEN 1 ELSE 0 END) AS Sixes,
	SUM(CASE WHEN Extras IS NULL THEN 1 ELSE 0 END) AS Extras,
	SUM(CASE WHEN run_rate IS NULL THEN 1 ELSE 0 END) AS run_rate,
	SUM(CASE WHEN avg_bat_strike_rate IS NULL THEN 1 ELSE 0 END) AS avg_bat_strike_rate,
	SUM(CASE WHEN higest_score IS NULL THEN 1 ELSE 0 END) AS higest_score,
	SUM(CASE WHEN wicket_taken IS NULL THEN 1 ELSE 0 END) AS wicket_taken,
	SUM(CASE WHEN extra_given IS NULL THEN 1 ELSE 0 END) AS extra_given,
	SUM(CASE WHEN highest_wicket_taker IS NULL THEN 1 ELSE 0 END) AS highest_wicket_taker,
	SUM(CASE WHEN potm IS NULL THEN 1 ELSE 0 END) AS potm,
	SUM(CASE WHEN Result IS NULL THEN 1 ELSE 0 END) AS Result
FROM asiacup;


SELECT 
	SUM(CASE WHEN Player_name IS NULL THEN 1 ELSE 0 END) AS Player_name,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country,
    SUM(CASE WHEN time_period IS NULL THEN 1 ELSE 0 END) AS time_period,
    SUM(CASE WHEN Matches IS NULL THEN 1 ELSE 0 END) AS Matches,
    SUM(CASE WHEN Played IS NULL THEN 1 ELSE 0 END) AS Played,
    SUM(CASE WHEN not_outs IS NULL THEN 1 ELSE 0 END) AS not_outs,
    SUM(CASE WHEN Runs IS NULL THEN 1 ELSE 0 END) AS Runs,
    SUM(CASE WHEN highest_score IS NULL THEN 1 ELSE 0 END) AS highest_score,
    SUM(CASE WHEN batting_avg IS NULL THEN 1 ELSE 0 END) AS batting_avg,
    SUM(CASE WHEN ball_faced IS NULL THEN 1 ELSE 0 END) AS ball_faced,
    SUM(CASE WHEN strike_rate IS NULL THEN 1 ELSE 0 END) AS strike_rate,
    SUM(CASE WHEN Centuries IS NULL THEN 1 ELSE 0 END) AS Centuries,
    SUM(CASE WHEN Fifties IS NULL THEN 1 ELSE 0 END) AS Fifties,
    SUM(CASE WHEN Ducks IS NULL THEN 1 ELSE 0 END) AS Ducks,
    SUM(CASE WHEN Fours IS NULL THEN 1 ELSE 0 END) AS Fours,
    SUM(CASE WHEN Sixes IS NULL THEN 1 ELSE 0 END) AS Sixes
FROM batsman_odi;

SELECT 
	SUM(CASE WHEN Player_name IS NULL THEN 1 ELSE 0 END) AS Player_name,
	SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country,
	SUM(CASE WHEN time_period IS NULL THEN 1 ELSE 0 END) AS time_period,
	SUM(CASE WHEN Matches IS NULL THEN 1 ELSE 0 END) AS Matches,
	SUM(CASE WHEN Played IS NULL THEN 1 ELSE 0 END) AS Played,
	SUM(CASE WHEN Overs IS NULL THEN 1 ELSE 0 END) AS Overs,
	SUM(CASE WHEN maiden_overs IS NULL THEN 1 ELSE 0 END) AS maiden_overs,
	SUM(CASE WHEN Runs IS NULL THEN 1 ELSE 0 END) AS Runs,
	SUM(CASE WHEN Wickets IS NULL THEN 1 ELSE 0 END) AS Wickets,
	SUM(CASE WHEN best_figure IS NULL THEN 1 ELSE 0 END) AS best_figure,
	SUM(CASE WHEN bowling_average IS NULL THEN 1 ELSE 0 END) AS bowling_average,
	SUM(CASE WHEN economy_rate IS NULL THEN 1 ELSE 0 END) AS economy_rate,
	SUM(CASE WHEN strike_rate IS NULL THEN 1 ELSE 0 END) AS strike_rate,
	SUM(CASE WHEN four_wicket IS NULL THEN 1 ELSE 0 END) AS four_wicket,
	SUM(CASE WHEN five_wickets IS NULL THEN 1 ELSE 0 END) AS five_wickets
FROM bowler_odi;


SELECT 
	SUM(CASE WHEN Player_name IS NULL THEN 1 ELSE 0 END) AS Player_name,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country,
    SUM(CASE WHEN time_period IS NULL THEN 1 ELSE 0 END) AS time_period,
    SUM(CASE WHEN Matches IS NULL THEN 1 ELSE 0 END) AS Matches,
    SUM(CASE WHEN Played IS NULL THEN 1 ELSE 0 END) AS Played,
    SUM(CASE WHEN not_outs IS NULL THEN 1 ELSE 0 END) AS not_outs,
    SUM(CASE WHEN Runs IS NULL THEN 1 ELSE 0 END) AS Runs,
    SUM(CASE WHEN highest_score IS NULL THEN 1 ELSE 0 END) AS highest_score,
    SUM(CASE WHEN batting_avg IS NULL THEN 1 ELSE 0 END) AS batting_avg,
    SUM(CASE WHEN ball_faced IS NULL THEN 1 ELSE 0 END) AS ball_faced,
    SUM(CASE WHEN strike_rate IS NULL THEN 1 ELSE 0 END) AS strike_rate,
    SUM(CASE WHEN Centuries IS NULL THEN 1 ELSE 0 END) AS Centuries,
    SUM(CASE WHEN Fifties IS NULL THEN 1 ELSE 0 END) AS Fifties,
    SUM(CASE WHEN Ducks IS NULL THEN 1 ELSE 0 END) AS Ducks,
    SUM(CASE WHEN Fours IS NULL THEN 1 ELSE 0 END) AS Fours,
    SUM(CASE WHEN Sixes IS NULL THEN 1 ELSE 0 END) AS Sixes
FROM batsman_t20;

SELECT 
	SUM(CASE WHEN Player_name IS NULL THEN 1 ELSE 0 END) AS Player_name,
	SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country,
	SUM(CASE WHEN time_period IS NULL THEN 1 ELSE 0 END) AS time_period,
	SUM(CASE WHEN Matches IS NULL THEN 1 ELSE 0 END) AS Matches,
	SUM(CASE WHEN Played IS NULL THEN 1 ELSE 0 END) AS Played,
	SUM(CASE WHEN Overs IS NULL THEN 1 ELSE 0 END) AS Overs,
	SUM(CASE WHEN maiden_overs IS NULL THEN 1 ELSE 0 END) AS maiden_overs,
	SUM(CASE WHEN Runs IS NULL THEN 1 ELSE 0 END) AS Runs,
	SUM(CASE WHEN Wickets IS NULL THEN 1 ELSE 0 END) AS Wickets,
	SUM(CASE WHEN best_figure IS NULL THEN 1 ELSE 0 END) AS best_figure,
	SUM(CASE WHEN bowling_average IS NULL THEN 1 ELSE 0 END) AS bowling_average,
	SUM(CASE WHEN economy_rate IS NULL THEN 1 ELSE 0 END) AS economy_rate,
	SUM(CASE WHEN strike_rate IS NULL THEN 1 ELSE 0 END) AS strike_rate,
	SUM(CASE WHEN four_wicket IS NULL THEN 1 ELSE 0 END) AS four_wicket,
	SUM(CASE WHEN five_wickets IS NULL THEN 1 ELSE 0 END) AS five_wickets
FROM bowler_t20;

-- TEAMS WITH THE HIGHEST TOTAL RUN IN ASIA CUP FORMAT
SELECT * FROM asiacup;
ALTER TABLE asiacup RENAME COLUMN higest_score TO highest_score;

SELECT DISTINCT team , 	SUM(highest_score) as highest_score FROM asiacup
group by 1
ORDER BY 2 DESC;

-- NO OF MATCHES PLAYED BY TEAMS IN ODI AND T2Oi FORMAT
SELECT DISTINCT team , `Format`, COUNT(*) AS match_played FROM asiacup
GROUP BY  1,2
ORDER BY 2,3 DESC;

-- MOST PLAYER OF THE MATCH AWARD
SELECT DISTINCT potm , COUNT(*) AS number_of_awards FROM asiacup
GROUP BY 1
ORDER BY 2 DESC;

--  Which country has produced the most top ODI batsmen?
SELECT * FROM batsman_odi;

SELECT 
    Country,
    COUNT(Player_name) AS total_top_batsmen
FROM batsman_odi
GROUP BY Country
ORDER BY total_top_batsmen DESC;

-- the average economy rate of bowlers for each country in T20I format

SELECT * FROM bowler_t20;

SELECT COUNTRY , AVG(economy_rate) as avg_economy FROM bowler_t20
GROUP BY 1
ORDER BY 2 DESC;



-- For each Asia Cup tournament year, show the Champion and who was the highest run scorer — along with that player's career batting average from batsman_odi
SELECT * FROM asiacup;
SELECT * FROM batsman_odi;
SELECT * FROM champion;

SELECT
    c.hosting_year,
    c.Champion,
    c.highest_run_scorer,
    b.batting_avg
FROM champion c
LEFT JOIN batsman_odi b ON b.Player_name = TRIM(c.highest_run_scorer)
ORDER BY c.hosting_year;

-- Remove trailing spaces from name columns
UPDATE batsman_odi SET Player_name = TRIM(Player_name);
UPDATE bowler_odi SET Player_name = TRIM(Player_name);
UPDATE batsman_t20 SET Player_name = TRIM(Player_name);
UPDATE bowler_t20 SET Player_name = TRIM(Player_name);
UPDATE champion SET highest_run_scorer = TRIM(highest_run_scorer);
UPDATE champion SET highest_wicket_taker = TRIM(highest_wicket_taker);


-- Which Asia Cup winning teams had a bowler in the bowler_odi table with an economy rate under 4.0?
SELECT
    c.Champion,
    b.Player_name,
    b.economy_rate
FROM champion c
JOIN bowler_odi b ON TRIM(c.Champion) = TRIM(b.Country)
WHERE b.economy_rate < 4.0
ORDER BY b.economy_rate ASC;