USE CRICKET_LEAGUE;

-- BASIC(Q1-Q20)
-- Q1. List the team name, country, and coach name of all teams from India.
SELECT TEAM_NAME , COUNTRY , COACH_NAME
FROM TEAMS
WHERE COUNTRY='INDIA';

-- Q2. List all player names and their roles, sorted alphabetically by player name.
SELECT PLAYER_NAME , ROLE
FROM PLAYERS
ORDER BY PLAYER_NAME ;

-- Q3. List the match ID, date, and venue of all matches played at "Wankhede Stadium".
SELECT MATCH_ID , MATCH_DATE , VENUE
FROM MATCHES
WHERE VENUE='WANKHEDE STADIUM';

-- Q4. Insert a new player: YUVRAJ RATHORE, team_id 1, role BATSMAN, DOB 2000-05-10.
INSERT INTO PLAYERS(PLAYER_NAME , TEAM_ID , ROLE , DATE_OF_BIRTH) 
VALUES ('YUVRAJ RATHORE',1,'BATSMAN','2000-05-10');
SELECT * FROM PLAYERS;

-- Q5. Update the coach name of "Sydney Sixers" to Michael Clarke.
UPDATE TEAMS
SET COACH_NAME='MICHAEL CLARKE' WHERE TEAM_NAME='SYDNEY SIXERS';
SELECT * FROM TEAMS;

-- Q6. Delete the performance record for match_id 8, player_id 2.
DELETE FROM PERFORMANCES WHERE MATCH_ID=8 AND PLAYER_ID=2;
SELECT * FROM PERFORMANCES;

-- Q7. Add a new column jersey_number (INT, nullable) to the players table.
ALTER TABLE PLAYERS
ADD COLUMN JERSEY_NUMBER INT NULL;
SELECT * FROM PLAYERS;

-- Q8. Find the number of players in each team (team name + player count).
SELECT TEAM_NAME , COUNT(PLAYER_ID)
FROM TEAMS
JOIN PLAYERS
ON TEAMS.TEAM_ID=PLAYERS.TEAM_ID
GROUP BY TEAM_NAME;

-- Q9. Find all players born after the year 1995 (use a date/year function).
SELECT PLAYER_NAME , DATE_OF_BIRTH
FROM PLAYERS
WHERE YEAR(DATE_OF_BIRTH)>1995;

-- Q10. Find all distinct roles that exist in the players table.
SELECT DISTINCT ROLE
FROM PLAYERS;

-- Q11. List the match date and venue for all matches played at "SCG".
SELECT MATCH_DATE , VENUE 
FROM MATCHES
WHERE VENUE='SCG';

-- Q12. List all team names and coach names, sorted alphabetically by team name.
SELECT TEAM_NAME , COACH_NAME
FROM TEAMS
ORDER BY TEAM_NAME;

-- Q13. List the player name and role for all players belonging to team_id 3 (Chennai Titans).
SELECT PLAYER_NAME , ROLE
FROM PLAYERS
WHERE TEAM_ID=3;

-- Q14. Insert a new player: DEV PATEL, team_id 2, role BOWLER, date_of_birth 2001-07-20.
INSERT INTO PLAYERS(PLAYER_NAME , TEAM_ID , ROLE , DATE_OF_BIRTH)
VALUES('DEV PATEL',2,'BOWLER','2001-07-20');
SELECT * FROM PLAYERS;

-- 15. Update the venue of match_id 5 from "SCG" to "The Gabba".
UPDATE MATCHES
SET VENUE='THE GABBA' 
WHERE VENUE='SCG' AND MATCH_ID=5;
SELECT * FROM MATCHES;

-- Q16.Delete the performance record where match_id = 6 and player_id = 11.
DELETE FROM PERFORMANCES WHERE MATCH_ID=6 AND PLAYER_ID=11;
SELECT * FROM PERFORMANCES;

-- Q17. Add a new column is_captain (TINYINT(1), default 0) to the players table
ALTER TABLE PLAYERS
ADD COLUMN IS_CAPTAIN TINYINT(1) DEFAULT 0;
SELECT * FROM PLAYERS;

-- Q18. Count the number of players for each role.
SELECT ROLE , COUNT(PLAYER_ID)
FROM PLAYERS
GROUP BY ROLE;

-- Q19. Find all players whose date_of_birth is NULL.
SELECT PLAYER_ID , PLAYER_NAME , DATE_OF_BIRTH
FROM PLAYERS
WHERE DATE_OF_BIRTH IS NULL;

-- 20. Find all distinct venues used across matches.
SELECT DISTINCT VENUE
FROM MATCHES;

-- INTERMEDIATE(Q21-Q40)
-- Q21. Using an INNER JOIN, list every player's name, role, and team name.
SELECT PLAYER_NAME , ROLE , TEAM_NAME
FROM TEAMS
INNER JOIN PLAYERS
ON TEAMS.TEAM_ID=PLAYERS.TEAM_ID
ORDER BY PLAYER_NAME;

-- Q22. Using a LEFT JOIN, find every player who has no performance record at all.
SELECT PLAYERS.PLAYER_ID, PLAYER_NAME 
FROM PLAYERS
LEFT JOIN PERFORMANCES
ON PLAYERS.PLAYER_ID=PERFORMANCES.PLAYER_ID
WHERE PERFORMANCE_ID IS NULL;

-- Q23. Using a SELF JOIN on players, list every unique pair of players who play for the same team.
SELECT P1.PLAYER_NAME AS PLAYER1 , P2.PLAYER_NAME AS PLAYER2 , P1.TEAM_ID
FROM PLAYERS P1
JOIN PLAYERS P2
ON P1.TEAM_ID=P2.TEAM_ID AND P1.PLAYER_ID>P2.PLAYER_ID
ORDER BY P1.TEAM_ID , PLAYER1 , PLAYER2;

-- Q24. Using JOIN + GROUP BY, calculate total runs scored by each player who has played at least one match.
SELECT PLAYER_NAME , SUM(RUNS_SCORED)
FROM PLAYERS
JOIN PERFORMANCES 
ON PLAYERS.PLAYER_ID=PERFORMANCES.PLAYER_ID
GROUP BY PLAYER_NAME
ORDER BY SUM(RUNS_SCORED) DESC;

-- Q25. Find every instance of a player scoring more than 50 runs in a single match — show player name, match_id, runs.
SELECT PLAYER_NAME , MATCH_ID , RUNS_SCORED
FROM PERFORMANCES
INNER JOIN PLAYERS
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE RUNS_SCORED>50
ORDER BY RUNS_SCORED DESC;

-- Q26. Using GROUP BY and HAVING, find teams with more than 3 players.
SELECT  TEAM_NAME , COUNT(PLAYER_ID)
FROM TEAMS
INNER JOIN PLAYERS
ON TEAMS.TEAM_ID=PLAYERS.TEAM_ID
GROUP BY TEAM_NAME
HAVING COUNT(PLAYER_ID)>3;

-- Q27. Using UNION, produce one combined list of names of all Batsmen and all Wicket-Keepers.
SELECT PLAYER_ID , PLAYER_NAME , ROLE FROM PLAYERS WHERE ROLE='BATSMAN'
UNION
SELECT PLAYER_ID, PLAYER_NAME , ROLE FROM PLAYERS WHERE ROLE='WICKET-KEEPER';

-- Q28. Using a subquery, find the (distinct) names of players who, in at least one match, scored more runs than the average runs scored across all performance records.
SELECT DISTINCT PLAYER_NAME
FROM PLAYERS
JOIN PERFORMANCES
ON PLAYERS.PLAYER_ID=PERFORMANCES.PLAYER_ID
WHERE RUNS_SCORED>
(
SELECT AVG(RUNS_SCORED) FROM PERFORMANCES
)
ORDER BY PLAYER_NAME ASC;

-- Q29. Create a VIEW called player_stats showing player_id, player_name, total_runs, total_wickets, and matches_played for every player. Then query it.
CREATE VIEW PLAYER_STATS AS
SELECT PLAYERS.PLAYER_ID , PLAYERS.PLAYER_NAME , SUM(RUNS_SCORED) , SUM(WICKETS_TAKEN) , COUNT(PERFORMANCE_ID)
FROM PLAYERS
LEFT JOIN PERFORMANCES
ON PLAYERS.PLAYER_ID=PERFORMANCES.PLAYER_ID
GROUP BY PLAYERS.PLAYER_ID , PLAYERS.PLAYER_NAME;
SELECT * FROM PLAYER_STATS
ORDER BY PLAYER_ID;

-- Q30. Create an INDEX called idx_team_id on players(team_id).
CREATE INDEX idx_team_id ON PLAYERS(TEAM_ID);
SHOW INDEXES IN PLAYERS;

-- Q31. Using an INNER JOIN, list match_id, team1's name, and team2's name for every match.
SELECT MATCH_ID , T1.TEAM_NAME AS TEAM1 , T2.TEAM_NAME AS TEAM2
FROM MATCHES 
INNER JOIN TEAMS T1
ON MATCHES.TEAM1_ID=T1.TEAM_ID
INNER JOIN TEAMS T2
ON MATCHES.TEAM2_ID=T2.TEAM_ID
ORDER BY MATCH_ID;

-- Q32. Using a LEFT JOIN, find any team that has never won a match.
SELECT TEAM_NAME
FROM TEAMS
LEFT JOIN MATCHES
ON TEAMS.TEAM_ID=MATCHES.WINNER_ID
WHERE WINNER_ID IS NULL;

-- Q33. Using a SELF JOIN, find pairs of players who were born in the same year.
SELECT P1.PLAYER_NAME AS PLAYER1 , P2.PLAYER_NAME AS PLAYER2 , YEAR(P1.DATE_OF_BIRTH) AS BIRTH_YEAR
FROM PLAYERS P1
JOIN PLAYERS P2
ON YEAR(P1.DATE_OF_BIRTH)=YEAR(P2.DATE_OF_BIRTH)
AND P1.DATE_OF_BIRTH > P2.DATE_OF_BIRTH
WHERE P1.DATE_OF_BIRTH IS NOT NULL
AND P2.DATE_OF_BIRTH IS NOT NULL
ORDER BY BIRTH_YEAR , PLAYER1;

-- Q34. Using JOIN + GROUP BY + HAVING, find the total wickets taken by each player who has taken at least 1 wicket.
SELECT PLAYERS.PLAYER_NAME , SUM(WICKETS_TAKEN)
FROM PLAYERS
JOIN PERFORMANCES 
ON PLAYERS.PLAYER_ID=PERFORMANCES.PLAYER_ID
GROUP BY PLAYERS.PLAYER_ID 
HAVING SUM(WICKETS_TAKEN)>=1
ORDER BY SUM(WICKETS_TAKEN) DESC;

-- Q35. Find every performance where a player took at least 1 catch — show player name, match_id, catches.
SELECT PLAYERS.PLAYER_NAME , MATCH_ID , CATCHES
FROM PERFORMANCES
JOIN PLAYERS
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE CATCHES >=1
ORDER BY CATCHES;

-- Q36. Using GROUP BY and HAVING, find roles where the average runs scored (across all performances by players of that role) is greater than 20.
SELECT  PLAYERS.ROLE, AVG(RUNS_SCORED) 
FROM PLAYERS
JOIN PERFORMANCES
ON PLAYERS.PLAYER_ID=PERFORMANCES.PLAYER_ID
GROUP BY PLAYERS.ROLE
HAVING AVG(RUNS_SCORED)>20;

-- Q37. Using UNION, combine the list of team names with total_wins > 0 and the list of team names from country = 'India' into one deduplicated list.
SELECT TEAM_NAME FROM TEAMS WHERE TOTAL_WINS>0
UNION
SELECT TEAM_NAME FROM TEAMS WHERE COUNTRY='INDIA';

-- Q38. Using a subquery, find the match_id and winning team name for every match won by whichever team(s) currently have the highest total_wins.
SELECT MATCH_ID , TEAM_NAME
FROM MATCHES
JOIN TEAMS
ON MATCHES.WINNER_ID=TEAMS.TEAM_ID
WHERE TOTAL_WINS=(SELECT MAX(TOTAL_WINS) FROM TEAMS)
ORDER BY MATCH_ID;

-- Q39. Create a VIEW called team_summary showing team_id, team_name, total_wins, and total_matches_played (a team's matches counted whether they were team1 or team2).
CREATE VIEW TEAM_SUMMARY AS
SELECT TEAM_ID , TEAM_NAME , TOTAL_WINS,(SELECT COUNT(*) FROM MATCHES WHERE MATCHES.TEAM1_ID=TEAMS.TEAM_ID OR MATCHES.TEAM2_ID=TEAMS.TEAM_ID) AS TOTAL_MATCHES
FROM TEAMS;

SELECT * FROM TEAM_SUMMARY;

-- Q40. Create an INDEX called idx_match_venue on matches(venue).
CREATE INDEX idx_match ON MATCHES(VENUE);
SHOW INDEXES IN MATCHES;


-- ADVANCED(Q41-Q60)
-- Q41. Using a correlated subquery, find the highest run-scorer in each match.
SELECT MATCH_ID , PLAYERS.PLAYER_NAME ,  RUNS_SCORED
FROM PERFORMANCES
JOIN PLAYERS
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE RUNS_SCORED =
(SELECT MAX(RUNS_SCORED) 
FROM PERFORMANCES PF
WHERE PF.MATCH_ID=PERFORMANCES.MATCH_ID)
ORDER BY MATCH_ID;

-- Q42. Using multiple JOINs, list match_id, date, team1 name, team2 name, and winner's team name (NULL if no result).
SELECT MATCH_ID , MATCH_DATE , T1.TEAM_NAME , T2.TEAM_NAME , TW.TEAM_NAME
FROM MATCHES
JOIN TEAMS T1
ON MATCHES.TEAM1_ID=T1.TEAM_ID
JOIN TEAMS T2
ON MATCHES.TEAM2_ID=T2.TEAM_ID
LEFT JOIN TEAMS TW
ON MATCHES.WINNER_ID=TW.TEAM_ID
ORDER BY MATCH_ID;

-- Q43. Using UNION ALL, combine (a) all performance rows with runs_scored > 50 and (b) all performance rows with wickets_taken >= 2 — duplicates allowed. Show player name, runs, wickets.
SELECT PLAYERS.PLAYER_NAME , ROLE , RUNS_SCORED , WICKETS_TAKEN   
FROM PERFORMANCES 
JOIN PLAYERS 
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE RUNS_SCORED>50
UNION ALL
SELECT PLAYERS.PLAYER_NAME , ROLE , RUNS_SCORED , WICKETS_TAKEN 
FROM PERFORMANCES 
JOIN PLAYERS 
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE WICKETS_TAKEN>=2;

-- Q44. Using JOIN + GROUP BY + HAVING, find teams with total_wins greater than 1.
SELECT TEAM_NAME , TOTAL_WINS 
FROM TEAMS
GROUP BY TEAM_NAME
HAVING TOTAL_WINS >1;

-- Q45. Using a subquery with MAX(), find the team(s) with the highest total_wins.
SELECT TEAM_NAME , TOTAL_WINS
FROM TEAMS
WHERE TOTAL_WINS=(SELECT MAX(TOTAL_WINS) FROM TEAMS);

-- Q46. Demonstrate a TRANSACTION: move MANOJ TIWARI (player_id 6) from Delhi Strikers to Chennai Titans, verify with a SELECT, then COMMIT. Then explain what ROLLBACK would have done instead.
START TRANSACTION;
UPDATE PLAYERS SET TEAM_ID=3 WHERE PLAYER_ID=6;
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID
FROM PLAYERS WHERE PLAYER_ID = 6;
COMMIT;

-- Q47. Create a STORED PROCEDURE GetPlayerPerformances(IN p_player_id INT) that returns all performance rows for a given player. Call it for player_id = 1.
DELIMITER $$
CREATE PROCEDURE GETPLAYERPERFORMANCE(IN P_PLAYER_ID INT)
BEGIN
	SELECT * FROM PERFORMANCES WHERE PLAYER_ID=P_PLAYER_ID;
END $$
DELIMITER ;
CALL GETPLAYERPERFORMANCE(1);

-- Q48. Create a TRIGGER trg_update_team_wins that automatically increments the winning team's total_wins whenever a new row is inserted into matches with a non-NULL winner_id. Demonstrate it with a new match insert.
DELIMITER $$
CREATE TRIGGER trg_update_team_wins
AFTER INSERT ON MATCHES
FOR EACH ROW
BEGIN	
	IF NEW.WINNER_ID IS NOT NULL THEN
			UPDATE TEAMS SET TOTAL_WINS=TOTAL_WINS+1 WHERE TEAM_ID=NEW.WINNER_ID;
	END IF;
END $$
DELIMITER ;
INSERT INTO MATCHES (TEAM1_ID, TEAM2_ID, MATCH_DATE, VENUE, WINNER_ID)
VALUES (1, 5, '2026-01-25', 'WANKHEDE STADIUM', 1);

-- Q49. Create a STORED PROCEDURE AddMatchResult(...) that inserts a new match row, relying on the trigger from Q48 to update total_wins automatically. Wrap the call in a transaction.
DELIMITER $$
CREATE PROCEDURE AddMatchResult(
	IN p_team1_id   INT,
    IN p_team2_id   INT,
    IN p_match_date DATE,
    IN p_venue      VARCHAR(50),
    IN p_winner_id  INT
)
BEGIN
	INSERT INTO MATCHES (TEAM1_ID, TEAM2_ID, MATCH_DATE, VENUE, WINNER_ID)
    VALUES (p_team1_id, p_team2_id, p_match_date, p_venue, p_winner_id);
END $$
DELIMITER ;
START TRANSACTION;
CALL AddMatchResult(3, 5, '2026-01-27', 'MA CHIDAMBARAM STADIUM', 3);
COMMIT;

-- Q50. Using JOIN + subquery + GROUP BY, find the top run-scorer for each team (team name, player name, total runs).
SELECT t.TEAM_NAME, p.PLAYER_NAME, pr.TOTAL_RUNS
FROM (
    SELECT PL.TEAM_ID, PL.PLAYER_ID, SUM(PF.RUNS_SCORED) AS total_runs
    FROM PLAYERS PL
    JOIN PERFORMANCES PF
        ON PL.PLAYER_ID = PF.PLAYER_ID
    GROUP BY PL.TEAM_ID, PL.PLAYER_ID
) PR
JOIN (
    SELECT PL.TEAM_ID, MAX(team_runs.total_runs) AS max_runs
    FROM (
        SELECT PL2.TEAM_ID, PL2.PLAYER_ID, SUM(PF2.RUNS_SCORED) AS total_runs
        FROM PLAYERS PL2
        JOIN PERFORMANCES PF2
            ON PL2.PLAYER_ID = PF2.PLAYER_ID
        GROUP BY PL2.TEAM_ID, PL2.PLAYER_ID
    ) team_runs
    JOIN PLAYERS PL
        ON PL.PLAYER_ID = team_runs.PLAYER_ID
    GROUP BY PL.TEAM_ID
) maxr
ON pr.TEAM_ID = maxr.TEAM_ID
AND pr.total_runs = maxr.max_runs
JOIN PLAYERS p
    ON p.PLAYER_ID = pr.PLAYER_ID
JOIN TEAMS t
    ON t.TEAM_ID = pr.TEAM_ID
ORDER BY t.TEAM_NAME;

-- Q51. Using a correlated subquery, find the lowest run-scorer in each match.
SELECT  MATCH_ID  , PLAYERS.PLAYER_NAME , RUNS_SCORED
FROM PERFORMANCES
JOIN PLAYERS
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE RUNS_SCORED = 
(SELECT MIN(RUNS_SCORED)
FROM PERFORMANCES PF
WHERE PF.MATCH_ID=PERFORMANCES.MATCH_ID)
ORDER BY MATCH_ID;

-- Q52. Using multiple JOINs, list player name, team name, match date, venue, and runs scored — for every performance recorded at "Wankhede Stadium"
SELECT PLAYERS.PLAYER_NAME , TEAM_NAME , MATCH_DATE , VENUE , RUNS_SCORED
FROM PERFORMANCES
JOIN PLAYERS
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
JOIN MATCHES
ON PERFORMANCES.MATCH_ID=MATCHES.MATCH_ID
JOIN TEAMS
ON PLAYERS.TEAM_ID=TEAMS.TEAM_ID
WHERE MATCHES.VENUE='WANKHEDE STADIUM'
ORDER BY MATCHES.MATCH_ID , PLAYERS.PLAYER_NAME;

-- Q53. Using UNION ALL, combine (a) all performance rows with runs_scored = 0 and (b) all performance rows with wickets_taken = 0 — duplicates allowed. Show player name, match_id, runs, wickets.
SELECT PLAYERS.PLAYER_NAME , MATCH_ID , RUNS_SCORED , WICKETS_TAKEN
FROM PERFORMANCES
JOIN PLAYERS
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE RUNS_SCORED=0
UNION ALL
SELECT PLAYERS.PLAYER_NAME , MATCH_ID , RUNS_SCORED , WICKETS_TAKEN
FROM PERFORMANCES
JOIN PLAYERS
ON PERFORMANCES.PLAYER_ID=PLAYERS.PLAYER_ID
WHERE WICKETS_TAKEN=0
ORDER BY MATCH_ID;

-- Q54. Using JOIN + GROUP BY + HAVING, find teams whose players' combined total runs scored (summed across all performances) exceeds 250.
SELECT TEAM_NAME , SUM(RUNS_SCORED)
FROM TEAMS
JOIN PLAYERS 
ON TEAMS.TEAM_ID=PLAYERS.TEAM_ID
JOIN PERFORMANCES
ON PLAYERS.PLAYER_ID=PERFORMANCES.PLAYER_ID
GROUP BY TEAMS.TEAM_ID , TEAMS.TEAM_NAME
HAVING SUM(RUNS_SCORED)>250;

-- Q55. Using a subquery with MIN(), find the team(s) with the lowest total_wins.
SELECT TEAM_ID , TEAM_NAME , TOTAL_WINS
FROM TEAMS
WHERE TOTAL_WINS = (SELECT MIN(TOTAL_WINS) FROM TEAMS);

-- Q56. Demonstrate a multi-statement TRANSACTION: update Sydney Sixers' coach_name to Ricky Ponting AND update match_id 2's venue to MCG, in the same transaction. Verify both with SELECTs, then COMMIT. Explain what ROLLBACK would have done instead.
START TRANSACTION;
UPDATE TEAMS SET COACH_NAME='RICKY POINTING' WHERE TEAM_NAME='SYDNEY SIXERS';
UPDATE MATCHES SET VENUE='MCG' WHERE MATCH_ID=2;
SELECT TEAM_NAME , COACH_NAME FROM TEAMS WHERE TEAM_NAME='SYDNEY SIXERS';
SELECT MATCH_ID , VENUE FROM MATCHES WHERE MATCH_ID=2;
COMMIT;

-- Q57. Create a STORED PROCEDURE GetTeamRoster(IN p_team_id INT) that returns all players of a given team, ordered by role. Call it for team_id = 1.
DELIMITER $$
CREATE PROCEDURE GetTeamRoster(IN P_TEAM_ID INT)
BEGIN
	SELECT PLAYER_ID , PLAYER_NAME , ROLE
    FROM PLAYERS
    WHERE TEAM_ID=P_TEAM_ID
    ORDER BY ROLE;
END $$
DELIMITER ;
CALL GetTeamRoster(1);

-- Q58. Create a TRIGGER trg_update_team_wins that automatically increments the winning team's total_wins whenever a new row is inserted into matches with a non-NULL winner_id. Demonstrate it by inserting a new match: Chennai Titans vs London Royals, venue Chepauk, date 2026-02-01, won by Chennai Titans.
DELIMITER $$
CREATE TRIGGER trg_update_team_wins1
AFTER INSERT ON MATCHES
FOR EACH ROW
BEGIN
	IF NEW.WINNER_ID IS NOT NULL THEN
		UPDATE TEAMS SET TOTAL_WINS=TOTAL_WINS+1 WHERE TEAM_ID=NEW.WINNER_ID;
	END IF;
END $$
DELIMITER ;
INSERT INTO MATCHES (TEAM1_ID, TEAM2_ID, MATCH_DATE, VENUE, WINNER_ID)
VALUES (3, 5, '2026-02-01', 'Chepauk', 3);

-- Q59. Create a STORED PROCEDURE RecordMatchResult(...) that inserts a new match row, relying on the Q58 trigger to update total_wins automatically. Use it to record: Delhi Strikers vs Sydney Sixers, venue MCG, date 2026-02-05, won by Sydney Sixers. Wrap the call in a transaction.
DELIMITER $$
CREATE PROCEDURE RecordMatchResult(
IN p_team1_id   INT,
    IN p_team2_id   INT,
    IN p_match_date DATE,
    IN p_venue      VARCHAR(50),
    IN p_winner_id  INT
)
BEGIN
	INSERT INTO MATCHES (TEAM1_ID, TEAM2_ID, MATCH_DATE, VENUE, WINNER_ID)
    VALUES (p_team1_id, p_team2_id, p_match_date, p_venue, p_winner_id);
END $$
DELIMITER ;

START TRANSACTION;
CALL RecordMatchResult(2, 4, '2026-02-05', 'MCG', 4);
COMMIT;

-- Q60. Using a subquery, find the player with the second-highest total career runs (across all performances).
SELECT p.PLAYER_NAME, SUM(pf.RUNS_SCORED) AS total_runs
FROM PLAYERS p
JOIN PERFORMANCES pf ON p.PLAYER_ID = pf.PLAYER_ID
GROUP BY p.PLAYER_ID, p.PLAYER_NAME
HAVING SUM(pf.RUNS_SCORED) = (
    SELECT DISTINCT total_runs
    FROM (
        SELECT SUM(RUNS_SCORED) AS total_runs
        FROM PERFORMANCES
        GROUP BY PLAYER_ID
        ORDER BY total_runs DESC
        LIMIT 1 OFFSET 1
    ) second
);