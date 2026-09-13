# Cricket League SQL Practice — Combined Questions (Q1–Q60)

All questions from Set 1 and Set 2 combined into one list, grouped by
difficulty (Basic → Intermediate → Advanced) instead of by set. Solve
strictly in order — Q4, Q5, Q6, Q7 (Basic) and Q46, Q48, Q49, Q56, Q58,
Q59 (Advanced) permanently change the data, and every later question
reflects that changed state.

---

## BASIC (Q1–Q20)

**Q1.** List the team name, country, and coach name of all teams from India.

**Q2.** List all player names and their roles, sorted alphabetically by player name.

**Q3.** List the match ID, date, and venue of all matches played at "Wankhede Stadium".

**Q4.** Insert a new player: `YUVRAJ RATHORE`, team_id 1, role `BATSMAN`, DOB `2000-05-10`.

**Q5.** Update the coach name of "Sydney Sixers" to `Michael Clarke`.

**Q6.** Delete the performance record for match_id 8, player_id 2.

**Q7.** Add a new column `jersey_number` (INT, nullable) to the `players` table.

**Q8.** Find the number of players in each team (team name + player count).

**Q9.** Find all players born after the year 1995 (use a date/year function).

**Q10.** Find all distinct roles that exist in the `players` table.

**Q11.** List the match date and venue for all matches played at "SCG".

**Q12.** List all team names and coach names, sorted alphabetically by team name.

**Q13.** List the player name and role for all players belonging to team_id 3 (Chennai Titans).

**Q14.** Insert a new player: `DEV PATEL`, team_id 2, role `BOWLER`, date_of_birth `2001-07-20`.

**Q15.** Update the venue of match_id 5 from "SCG" to "The Gabba".

**Q16.** Delete the performance record where match_id = 6 and player_id = 11.

**Q17.** Add a new column `is_captain` (TINYINT(1), default 0) to the `players` table.

**Q18.** Count the number of players for each role.

**Q19.** Find all players whose date_of_birth is NULL.

**Q20.** Find all distinct venues used across matches.

---

## INTERMEDIATE (Q21–Q40)

**Q21.** Using an INNER JOIN, list every player's name, role, and team name.

**Q22.** Using a LEFT JOIN, find every player who has no performance record at all.

**Q23.** Using a SELF JOIN on `players`, list every unique pair of players who play for the same team.

**Q24.** Using JOIN + GROUP BY, calculate total runs scored by each player who has played at least one match.

**Q25.** Find every instance of a player scoring more than 50 runs in a single match — show player name, match_id, runs.

**Q26.** Using GROUP BY and HAVING, find teams with more than 3 players.

**Q27.** Using UNION, produce one combined list of names of all Batsmen and all Wicket-Keepers.

**Q28.** Using a subquery, find the (distinct) names of players who, in at least one match, scored more runs than the average runs scored across all performance records.

**Q29.** Create a VIEW called `player_stats` showing player_id, player_name, total_runs, total_wickets, and matches_played for every player. Then query it.

**Q30.** Create an INDEX called `idx_team_id` on `players(team_id)`.

**Q31.** Using an INNER JOIN, list match_id, team1's name, and team2's name for every match.

**Q32.** Using a LEFT JOIN, find any team that has never won a match.

**Q33.** Using a SELF JOIN, find pairs of players who were born in the same year.

**Q34.** Using JOIN + GROUP BY + HAVING, find the total wickets taken by each player who has taken at least 1 wicket.

**Q35.** Find every performance where a player took at least 1 catch — show player name, match_id, catches.

**Q36.** Using GROUP BY and HAVING, find roles where the average runs scored (across all performances by players of that role) is greater than 20.

**Q37.** Using UNION, combine the list of team names with `total_wins > 0` and the list of team names from `country = 'India'` into one deduplicated list.

**Q38.** Using a subquery, find the match_id and winning team name for every match won by whichever team(s) currently have the highest `total_wins`.

**Q39.** Create a VIEW called `team_summary` showing team_id, team_name, total_wins, and total_matches_played (a team's matches counted whether they were team1 or team2).

**Q40.** Create an INDEX called `idx_match_venue` on `matches(venue)`.

---

## ADVANCED (Q41–Q60)

**Q41.** Using a correlated subquery, find the highest run-scorer in each match.

**Q42.** Using multiple JOINs, list match_id, date, team1 name, team2 name, and winner's team name (NULL if no result).

**Q43.** Using UNION ALL, combine (a) all performance rows with runs_scored > 50 and (b) all performance rows with wickets_taken >= 2 — duplicates allowed. Show player name, runs, wickets.

**Q44.** Using JOIN + GROUP BY + HAVING, find teams with `total_wins` greater than 1.

**Q45.** Using a subquery with MAX(), find the team(s) with the highest `total_wins`.

**Q46.** Demonstrate a TRANSACTION: move `MANOJ TIWARI` (player_id 6) from Delhi Strikers to Chennai Titans, verify with a SELECT, then COMMIT. Then explain what ROLLBACK would have done instead.

**Q47.** Create a STORED PROCEDURE `GetPlayerPerformances(IN p_player_id INT)` that returns all performance rows for a given player. Call it for player_id = 1.

**Q48.** Create a TRIGGER `trg_update_team_wins` that automatically increments the winning team's `total_wins` whenever a new row is inserted into `matches` with a non-NULL `winner_id`. Demonstrate it with a new match insert.

**Q49.** Create a STORED PROCEDURE `AddMatchResult(...)` that inserts a new match row, relying on the trigger from Q48 to update `total_wins` automatically. Wrap the call in a transaction.

**Q50.** Using JOIN + subquery + GROUP BY, find the top run-scorer for each team (team name, player name, total runs).

**Q51.** Using a correlated subquery, find the lowest run-scorer in each match.

**Q52.** Using multiple JOINs, list player name, team name, match date, venue, and runs scored — for every performance recorded at "Wankhede Stadium".

**Q53.** Using UNION ALL, combine (a) all performance rows with `runs_scored = 0` and (b) all performance rows with `wickets_taken = 0` — duplicates allowed. Show player name, match_id, runs, wickets.

**Q54.** Using JOIN + GROUP BY + HAVING, find teams whose players' combined total runs scored (summed across all performances) exceeds 250.

**Q55.** Using a subquery with MIN(), find the team(s) with the lowest `total_wins`.

**Q56.** Demonstrate a multi-statement TRANSACTION: update Sydney Sixers' coach_name to `Ricky Ponting` AND update match_id 2's venue to `MCG`, in the same transaction. Verify both with SELECTs, then COMMIT. Explain what ROLLBACK would have done instead.

**Q57.** Create a STORED PROCEDURE `GetTeamRoster(IN p_team_id INT)` that returns all players of a given team, ordered by role. Call it for team_id = 1.

**Q58.** Create a TRIGGER `trg_update_team_wins` that automatically increments the winning team's `total_wins` whenever a new row is inserted into `matches` with a non-NULL `winner_id`. Demonstrate it by inserting a new match: Chennai Titans vs London Royals, venue `Chepauk`, date `2026-02-01`, won by Chennai Titans.

**Q59.** Create a STORED PROCEDURE `RecordMatchResult(...)` that inserts a new match row, relying on the Q58 trigger to update `total_wins` automatically. Use it to record: Delhi Strikers vs Sydney Sixers, venue `MCG`, date `2026-02-05`, won by Sydney Sixers. Wrap the call in a transaction.

**Q60.** Using a subquery, find the player with the second-highest total career runs (across all performances).