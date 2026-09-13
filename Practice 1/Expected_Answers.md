# Cricket League SQL Practice — Expected Answers (Q1–Q60)

These outputs were produced by actually loading the 5 base files into a
fresh MySQL/MariaDB-compatible database and running every query below,
in order, so each answer reflects the cumulative effect of every
data-changing question before it (Q4–Q7, Q14–Q17 in Basic; Q46, Q48, Q49
in Advanced Set-1 portion; Q56, Q58, Q59 in Advanced Set-2 portion).

---

## BASIC

**Q1.** Team name, country, coach name of all teams from India.

| TEAM_NAME | COUNTRY | COACH_NAME |
|---|---|---|
| MUMBAI WARRIORS | INDIA | RAHUL SHARMA |
| DELHI STRIKERS | INDIA | ANIL KAPOOR |
| CHENNAI TITANS | INDIA | VIJAY KUMAR |

**Q2.** Player names and roles, sorted alphabetically.

| PLAYER_NAME | ROLE |
|---|---|
| ANAND PILLAI | ALL-ROUNDER |
| ARUN NAIR | BATSMAN |
| CHRIS ADAMS | ALL-ROUNDER |
| DEEPAK CHAHAR | WICKET-KEEPER |
| GANESH IYER | WICKET-KEEPER |
| HARRY STILES | BOWLER |
| JAMES COOK | BATSMAN |
| KARAN MEHTA | WICKET-KEEPER |
| LIAM GRANT | WICKET-KEEPER |
| MANOJ TIWARI | BOWLER |
| MARK WOOD | BOWLER |
| OLIVER BROWN | ALL-ROUNDER |
| PRAKASH RAJ | BOWLER |
| RAJESH KUMAR | ALL-ROUNDER |
| ROHIT VERMA | BATSMAN |
| SANJAY DUTT | ALL-ROUNDER |
| STEVE WALKER | BATSMAN |
| SURESH IYER | BOWLER |
| TOM BAKER | WICKET-KEEPER |
| VIKRAM SINGH | BATSMAN |

(20 rows — run before the Q4 insert.)

**Q3.** Matches at Wankhede Stadium.

| MATCH_ID | MATCH_DATE | VENUE |
|---|---|---|
| 1 | 2026-01-05 | WANKHEDE STADIUM |
| 6 | 2026-01-18 | WANKHEDE STADIUM |

**Q4.** Insert YUVRAJ RATHORE — `Query OK, 1 row affected`. Verification:

| PLAYER_ID | PLAYER_NAME | TEAM_ID | ROLE | DATE_OF_BIRTH |
|---|---|---|---|---|
| 21 | YUVRAJ RATHORE | 1 | BATSMAN | 2000-05-10 |

**Q5.** Update Sydney Sixers' coach — `Rows matched: 1  Changed: 1`. Verification:

| TEAM_ID | TEAM_NAME | COUNTRY | COACH_NAME | TOTAL_WINS |
|---|---|---|---|---|
| 4 | SYDNEY SIXERS | AUSTRALIA | Michael Clarke | 0 |

**Q6.** Delete performance (match 8, player 2) — `Query OK, 1 row affected`. Remaining rows for match 8:

| PERFORMANCE_ID | MATCH_ID | PLAYER_ID | RUNS_SCORED | BALLS_FACED | WICKETS_TAKEN | CATCHES |
|---|---|---|---|---|---|---|
| 29 | 8 | 13 | 28 | 30 | 0 | 0 |
| 30 | 8 | 15 | 10 | 12 | 2 | 1 |
| 31 | 8 | 1 | 100 | 65 | 0 | 0 |

**Q7.** Add `jersey_number` column — `Query OK, 0 rows affected`. New structure (relevant part):

| Field | Type | Null | Default |
|---|---|---|---|
| jersey_number | int(11) | YES | NULL |

**Q8.** Player count per team (reflects the Q4 insert — Mumbai Warriors now has 5).

| TEAM_NAME | player_count |
|---|---|
| CHENNAI TITANS | 4 |
| DELHI STRIKERS | 4 |
| LONDON ROYALS | 4 |
| MUMBAI WARRIORS | 5 |
| SYDNEY SIXERS | 4 |

**Q9.** Players born after 1995.

| PLAYER_NAME | ROLE | DATE_OF_BIRTH |
|---|---|---|
| KARAN MEHTA | WICKET-KEEPER | 1997-08-25 |
| RAJESH KUMAR | ALL-ROUNDER | 1996-07-18 |
| DEEPAK CHAHAR | WICKET-KEEPER | 1998-02-28 |
| GANESH IYER | WICKET-KEEPER | 1999-01-15 |
| CHRIS ADAMS | ALL-ROUNDER | 1996-10-10 |
| TOM BAKER | WICKET-KEEPER | 1998-03-03 |
| OLIVER BROWN | ALL-ROUNDER | 1997-12-12 |
| YUVRAJ RATHORE | BATSMAN | 2000-05-10 |

**Q10.** Distinct roles.

| ROLE |
|---|
| BATSMAN |
| BOWLER |
| ALL-ROUNDER |
| WICKET-KEEPER |

**Q11.** Match date/venue at SCG (before Q15 renames match 5's venue).

| MATCH_DATE | VENUE |
|---|---|
| 2026-01-15 | SCG |
| 2026-01-22 | SCG |

**Q12.** Team names and coaches, sorted alphabetically (reflects Q5).

| TEAM_NAME | COACH_NAME |
|---|---|
| CHENNAI TITANS | VIJAY KUMAR |
| DELHI STRIKERS | ANIL KAPOOR |
| LONDON ROYALS | DAVID SMITH |
| MUMBAI WARRIORS | RAHUL SHARMA |
| SYDNEY SIXERS | Michael Clarke |

**Q13.** Players of team_id 3 (Chennai Titans).

| PLAYER_NAME | ROLE |
|---|---|
| ARUN NAIR | BATSMAN |
| PRAKASH RAJ | BOWLER |
| SANJAY DUTT | ALL-ROUNDER |
| GANESH IYER | WICKET-KEEPER |

**Q14.** Insert DEV PATEL — `Query OK, 1 row affected`. Verification:

| PLAYER_ID | PLAYER_NAME | TEAM_ID | ROLE | DATE_OF_BIRTH | jersey_number |
|---|---|---|---|---|---|
| 22 | DEV PATEL | 2 | BOWLER | 2001-07-20 | NULL |

**Q15.** Update match 5's venue — `Rows matched: 1  Changed: 1`. Verification:

| MATCH_ID | TEAM1_ID | TEAM2_ID | MATCH_DATE | VENUE | WINNER_ID |
|---|---|---|---|---|---|
| 5 | 4 | 5 | 2026-01-15 | The Gabba | NULL |

**Q16.** Delete performance (match 6, player 11) — `Query OK, 1 row affected`. Remaining rows for match 6:

| PERFORMANCE_ID | MATCH_ID | PLAYER_ID | RUNS_SCORED | BALLS_FACED | WICKETS_TAKEN | CATCHES |
|---|---|---|---|---|---|---|
| 21 | 6 | 1 | 15 | 20 | 0 | 1 |
| 22 | 6 | 3 | 22 | 18 | 1 | 0 |
| 23 | 6 | 9 | 65 | 50 | 0 | 0 |

**Q17.** Add `is_captain` column — `Query OK, 0 rows affected`. New structure (relevant part):

| Field | Type | Null | Default |
|---|---|---|---|
| is_captain | tinyint(1) | YES | 0 |

**Q18.** Player count per role (22 players total after both inserts).

| ROLE | role_count |
|---|---|
| ALL-ROUNDER | 5 |
| BATSMAN | 6 |
| BOWLER | 6 |
| WICKET-KEEPER | 5 |

**Q19.** Players with NULL date_of_birth.

| PLAYER_ID | PLAYER_NAME | TEAM_ID |
|---|---|---|
| 20 | LIAM GRANT | 5 |

**Q20.** Distinct venues (reflects Q15's rename — match 8 still shows "SCG").

| VENUE |
|---|
| WANKHEDE STADIUM |
| MA CHIDAMBARAM STADIUM |
| LORDS |
| ARUN JAITLEY STADIUM |
| The Gabba |
| SCG |

---

## INTERMEDIATE

**Q21.** Player, role, team name (INNER JOIN) — 22 rows.

| PLAYER_NAME | ROLE | TEAM_NAME |
|---|---|---|
| ANAND PILLAI | ALL-ROUNDER | MUMBAI WARRIORS |
| ARUN NAIR | BATSMAN | CHENNAI TITANS |
| CHRIS ADAMS | ALL-ROUNDER | SYDNEY SIXERS |
| DEEPAK CHAHAR | WICKET-KEEPER | DELHI STRIKERS |
| DEV PATEL | BOWLER | DELHI STRIKERS |
| GANESH IYER | WICKET-KEEPER | CHENNAI TITANS |
| HARRY STILES | BOWLER | LONDON ROYALS |
| JAMES COOK | BATSMAN | LONDON ROYALS |
| KARAN MEHTA | WICKET-KEEPER | MUMBAI WARRIORS |
| LIAM GRANT | WICKET-KEEPER | LONDON ROYALS |
| MANOJ TIWARI | BOWLER | DELHI STRIKERS |
| MARK WOOD | BOWLER | SYDNEY SIXERS |
| OLIVER BROWN | ALL-ROUNDER | LONDON ROYALS |
| PRAKASH RAJ | BOWLER | CHENNAI TITANS |
| RAJESH KUMAR | ALL-ROUNDER | DELHI STRIKERS |
| ROHIT VERMA | BATSMAN | MUMBAI WARRIORS |
| SANJAY DUTT | ALL-ROUNDER | CHENNAI TITANS |
| STEVE WALKER | BATSMAN | SYDNEY SIXERS |
| SURESH IYER | BOWLER | MUMBAI WARRIORS |
| TOM BAKER | WICKET-KEEPER | SYDNEY SIXERS |
| VIKRAM SINGH | BATSMAN | DELHI STRIKERS |
| YUVRAJ RATHORE | BATSMAN | MUMBAI WARRIORS |

**Q22.** Players with no performance record at all — 8 rows.

| PLAYER_ID | PLAYER_NAME |
|---|---|
| 4 | KARAN MEHTA |
| 8 | DEEPAK CHAHAR |
| 11 | SANJAY DUTT |
| 12 | GANESH IYER |
| 16 | TOM BAKER |
| 20 | LIAM GRANT |
| 21 | YUVRAJ RATHORE |
| 22 | DEV PATEL |

**Q23.** Unique same-team player pairs (SELF JOIN) — 38 rows.

| PLAYER_1 | PLAYER_2 | TEAM_ID |
|---|---|---|
| ANAND PILLAI | KARAN MEHTA | 1 |
| ANAND PILLAI | YUVRAJ RATHORE | 1 |
| KARAN MEHTA | YUVRAJ RATHORE | 1 |
| ROHIT VERMA | ANAND PILLAI | 1 |
| ROHIT VERMA | KARAN MEHTA | 1 |
| ROHIT VERMA | SURESH IYER | 1 |
| ROHIT VERMA | YUVRAJ RATHORE | 1 |
| SURESH IYER | ANAND PILLAI | 1 |
| SURESH IYER | KARAN MEHTA | 1 |
| SURESH IYER | YUVRAJ RATHORE | 1 |
| DEEPAK CHAHAR | DEV PATEL | 2 |
| MANOJ TIWARI | DEEPAK CHAHAR | 2 |
| MANOJ TIWARI | DEV PATEL | 2 |
| MANOJ TIWARI | RAJESH KUMAR | 2 |
| RAJESH KUMAR | DEEPAK CHAHAR | 2 |
| RAJESH KUMAR | DEV PATEL | 2 |
| VIKRAM SINGH | DEEPAK CHAHAR | 2 |
| VIKRAM SINGH | DEV PATEL | 2 |
| VIKRAM SINGH | MANOJ TIWARI | 2 |
| VIKRAM SINGH | RAJESH KUMAR | 2 |
| ARUN NAIR | GANESH IYER | 3 |
| ARUN NAIR | PRAKASH RAJ | 3 |
| ARUN NAIR | SANJAY DUTT | 3 |
| PRAKASH RAJ | GANESH IYER | 3 |
| PRAKASH RAJ | SANJAY DUTT | 3 |
| SANJAY DUTT | GANESH IYER | 3 |
| CHRIS ADAMS | TOM BAKER | 4 |
| MARK WOOD | CHRIS ADAMS | 4 |
| MARK WOOD | TOM BAKER | 4 |
| STEVE WALKER | CHRIS ADAMS | 4 |
| STEVE WALKER | MARK WOOD | 4 |
| STEVE WALKER | TOM BAKER | 4 |
| HARRY STILES | LIAM GRANT | 5 |
| HARRY STILES | OLIVER BROWN | 5 |
| JAMES COOK | HARRY STILES | 5 |
| JAMES COOK | LIAM GRANT | 5 |
| JAMES COOK | OLIVER BROWN | 5 |
| OLIVER BROWN | LIAM GRANT | 5 |

**Q24.** Total runs by player who has played ≥1 match — 14 rows.

| PLAYER_NAME | total_runs |
|---|---|
| ROHIT VERMA | 220 |
| VIKRAM SINGH | 205 |
| ARUN NAIR | 173 |
| JAMES COOK | 145 |
| STEVE WALKER | 125 |
| ANAND PILLAI | 62 |
| CHRIS ADAMS | 43 |
| RAJESH KUMAR | 25 |
| HARRY STILES | 20 |
| OLIVER BROWN | 15 |
| SURESH IYER | 10 |
| MANOJ TIWARI | 8 |
| PRAKASH RAJ | 3 |
| MARK WOOD | 0 |

**Q25.** Innings of 50+ runs.

| PLAYER_NAME | MATCH_ID | RUNS_SCORED |
|---|---|---|
| ROHIT VERMA | 8 | 100 |
| VIKRAM SINGH | 7 | 90 |
| ARUN NAIR | 2 | 88 |
| ROHIT VERMA | 1 | 75 |
| VIKRAM SINGH | 4 | 70 |
| ARUN NAIR | 6 | 65 |
| JAMES COOK | 3 | 60 |
| STEVE WALKER | 2 | 55 |

**Q26.** Teams with more than 3 players.

| TEAM_NAME | player_count |
|---|---|
| CHENNAI TITANS | 4 |
| DELHI STRIKERS | 5 |
| LONDON ROYALS | 4 |
| MUMBAI WARRIORS | 5 |
| SYDNEY SIXERS | 4 |

**Q27.** Batsmen ∪ Wicket-Keepers.

| PLAYER_NAME |
|---|
| ARUN NAIR |
| DEEPAK CHAHAR |
| GANESH IYER |
| JAMES COOK |
| KARAN MEHTA |
| LIAM GRANT |
| ROHIT VERMA |
| STEVE WALKER |
| TOM BAKER |
| VIKRAM SINGH |
| YUVRAJ RATHORE |

**Q28.** Players who scored more than the overall average runs per performance.

| PLAYER_NAME |
|---|
| ANAND PILLAI |
| ARUN NAIR |
| JAMES COOK |
| ROHIT VERMA |
| STEVE WALKER |
| VIKRAM SINGH |

**Q29.** `player_stats` VIEW — all 22 rows.

| PLAYER_ID | PLAYER_NAME | total_runs | total_wickets | matches_played |
|---|---|---|---|---|
| 1 | ROHIT VERMA | 220 | 0 | 4 |
| 2 | SURESH IYER | 10 | 2 | 1 |
| 3 | ANAND PILLAI | 62 | 2 | 2 |
| 4 | KARAN MEHTA | 0 | 0 | 0 |
| 5 | VIKRAM SINGH | 205 | 0 | 3 |
| 6 | MANOJ TIWARI | 8 | 5 | 2 |
| 7 | RAJESH KUMAR | 25 | 2 | 1 |
| 8 | DEEPAK CHAHAR | 0 | 0 | 0 |
| 9 | ARUN NAIR | 173 | 0 | 3 |
| 10 | PRAKASH RAJ | 3 | 5 | 2 |
| 11 | SANJAY DUTT | 0 | 0 | 0 |
| 12 | GANESH IYER | 0 | 0 | 0 |
| 13 | STEVE WALKER | 125 | 0 | 3 |
| 14 | MARK WOOD | 0 | 1 | 1 |
| 15 | CHRIS ADAMS | 43 | 3 | 2 |
| 16 | TOM BAKER | 0 | 0 | 0 |
| 17 | JAMES COOK | 145 | 0 | 3 |
| 18 | HARRY STILES | 20 | 3 | 2 |
| 19 | OLIVER BROWN | 15 | 2 | 1 |
| 20 | LIAM GRANT | 0 | 0 | 0 |
| 21 | YUVRAJ RATHORE | 0 | 0 | 0 |
| 22 | DEV PATEL | 0 | 0 | 0 |

**Q30.** `idx_team_id` index created on `PLAYERS(TEAM_ID)` — `Query OK, 0 rows affected`. Confirmed via `SHOW INDEX`: one BTREE index named `idx_team_id` on column `TEAM_ID`.

**Q31.** match_id, team1 name, team2 name.

| MATCH_ID | TEAM1_NAME | TEAM2_NAME |
|---|---|---|
| 1 | MUMBAI WARRIORS | DELHI STRIKERS |
| 2 | CHENNAI TITANS | SYDNEY SIXERS |
| 3 | LONDON ROYALS | MUMBAI WARRIORS |
| 4 | DELHI STRIKERS | CHENNAI TITANS |
| 5 | SYDNEY SIXERS | LONDON ROYALS |
| 6 | MUMBAI WARRIORS | CHENNAI TITANS |
| 7 | DELHI STRIKERS | LONDON ROYALS |
| 8 | SYDNEY SIXERS | MUMBAI WARRIORS |

**Q32.** Team that has never won a match.

| TEAM_ID | TEAM_NAME |
|---|---|
| 4 | SYDNEY SIXERS |

**Q33.** Player pairs born in the same year.

| PLAYER_1 | PLAYER_2 | BIRTH_YEAR |
|---|---|---|
| ROHIT VERMA | STEVE WALKER | 1990 |
| VIKRAM SINGH | JAMES COOK | 1991 |
| SURESH IYER | MARK WOOD | 1993 |
| MANOJ TIWARI | HARRY STILES | 1994 |
| ANAND PILLAI | SANJAY DUTT | 1995 |
| RAJESH KUMAR | CHRIS ADAMS | 1996 |
| KARAN MEHTA | OLIVER BROWN | 1997 |
| DEEPAK CHAHAR | TOM BAKER | 1998 |

**Q34.** Total wickets by player who has taken ≥1 wicket.

| PLAYER_NAME | total_wickets |
|---|---|
| PRAKASH RAJ | 5 |
| MANOJ TIWARI | 5 |
| CHRIS ADAMS | 3 |
| HARRY STILES | 3 |
| OLIVER BROWN | 2 |
| RAJESH KUMAR | 2 |
| ANAND PILLAI | 2 |
| SURESH IYER | 2 |
| MARK WOOD | 1 |

**Q35.** Performances with ≥1 catch.

| PLAYER_NAME | MATCH_ID | CATCHES |
|---|---|---|
| MANOJ TIWARI | 1 | 1 |
| ROHIT VERMA | 1 | 1 |
| STEVE WALKER | 2 | 1 |
| ANAND PILLAI | 3 | 1 |
| HARRY STILES | 3 | 1 |
| ARUN NAIR | 4 | 1 |
| CHRIS ADAMS | 5 | 1 |
| ROHIT VERMA | 6 | 1 |
| JAMES COOK | 7 | 1 |
| CHRIS ADAMS | 8 | 1 |

**Q36.** Roles where average runs per performance > 20.

| ROLE | avg_runs |
|---|---|
| ALL-ROUNDER | 24.1667 |
| BATSMAN | 54.2500 |

**Q37.** Teams with total_wins > 0, unioned with teams from India.

| TEAM_NAME |
|---|
| CHENNAI TITANS |
| DELHI STRIKERS |
| LONDON ROYALS |
| MUMBAI WARRIORS |

**Q38.** Matches won by the team(s) with the highest total_wins (Mumbai Warriors, Delhi Strikers, Chennai Titans — all on 2 at this point).

| MATCH_ID | WINNING_TEAM |
|---|---|
| 1 | MUMBAI WARRIORS |
| 2 | CHENNAI TITANS |
| 4 | DELHI STRIKERS |
| 6 | CHENNAI TITANS |
| 7 | DELHI STRIKERS |
| 8 | MUMBAI WARRIORS |

**Q39.** `team_summary` VIEW.

| TEAM_ID | TEAM_NAME | TOTAL_WINS | total_matches_played |
|---|---|---|---|
| 1 | MUMBAI WARRIORS | 2 | 4 |
| 2 | DELHI STRIKERS | 2 | 3 |
| 3 | CHENNAI TITANS | 2 | 3 |
| 4 | SYDNEY SIXERS | 0 | 3 |
| 5 | LONDON ROYALS | 1 | 3 |

**Q40.** `idx_match_venue` index created on `MATCHES(VENUE)` — `Query OK, 0 rows affected`. Confirmed via `SHOW INDEX`: one BTREE index named `idx_match_venue` on column `VENUE`.

---

## ADVANCED

**Q41.** Highest run-scorer per match.

| MATCH_ID | PLAYER_NAME | RUNS_SCORED |
|---|---|---|
| 1 | ROHIT VERMA | 75 |
| 2 | ARUN NAIR | 88 |
| 3 | JAMES COOK | 60 |
| 4 | VIKRAM SINGH | 70 |
| 5 | JAMES COOK | 50 |
| 6 | ARUN NAIR | 65 |
| 7 | VIKRAM SINGH | 90 |
| 8 | ROHIT VERMA | 100 |

**Q42.** Match_id, date, team1, team2, winner.

| MATCH_ID | MATCH_DATE | TEAM1_NAME | TEAM2_NAME | WINNER_NAME |
|---|---|---|---|---|
| 1 | 2026-01-05 | MUMBAI WARRIORS | DELHI STRIKERS | MUMBAI WARRIORS |
| 2 | 2026-01-07 | CHENNAI TITANS | SYDNEY SIXERS | CHENNAI TITANS |
| 3 | 2026-01-10 | LONDON ROYALS | MUMBAI WARRIORS | LONDON ROYALS |
| 4 | 2026-01-12 | DELHI STRIKERS | CHENNAI TITANS | DELHI STRIKERS |
| 5 | 2026-01-15 | SYDNEY SIXERS | LONDON ROYALS | NULL |
| 6 | 2026-01-18 | MUMBAI WARRIORS | CHENNAI TITANS | CHENNAI TITANS |
| 7 | 2026-01-20 | DELHI STRIKERS | LONDON ROYALS | DELHI STRIKERS |
| 8 | 2026-01-22 | SYDNEY SIXERS | MUMBAI WARRIORS | MUMBAI WARRIORS |

**Q43.** UNION ALL of >50 runs and ≥2 wickets performances — 16 rows.

| PLAYER_NAME | RUNS_SCORED | WICKETS_TAKEN |
|---|---|---|
| ROHIT VERMA | 75 | 0 |
| ARUN NAIR | 88 | 0 |
| STEVE WALKER | 55 | 0 |
| JAMES COOK | 60 | 0 |
| VIKRAM SINGH | 70 | 0 |
| ARUN NAIR | 65 | 0 |
| VIKRAM SINGH | 90 | 0 |
| ROHIT VERMA | 100 | 0 |
| SURESH IYER | 10 | 2 |
| MANOJ TIWARI | 5 | 3 |
| PRAKASH RAJ | 2 | 4 |
| HARRY STILES | 8 | 2 |
| RAJESH KUMAR | 25 | 2 |
| OLIVER BROWN | 15 | 2 |
| MANOJ TIWARI | 3 | 2 |
| CHRIS ADAMS | 10 | 2 |

**Q44.** Teams with total_wins > 1.

| TEAM_NAME | TOTAL_WINS |
|---|---|
| MUMBAI WARRIORS | 2 |
| DELHI STRIKERS | 2 |
| CHENNAI TITANS | 2 |

**Q45.** Team(s) with the highest total_wins.

| TEAM_NAME | TOTAL_WINS |
|---|---|
| MUMBAI WARRIORS | 2 |
| DELHI STRIKERS | 2 |
| CHENNAI TITANS | 2 |

**Q46.** Transaction moving MANOJ TIWARI to Chennai Titans.

Mid-transaction SELECT and post-COMMIT SELECT both show:

| PLAYER_ID | PLAYER_NAME | TEAM_ID |
|---|---|---|
| 6 | MANOJ TIWARI | 3 |

The COMMIT makes the change permanent. **Had ROLLBACK been used instead**, the `UPDATE` would be discarded and Manoj Tiwari's `TEAM_ID` would revert to `2` (Delhi Strikers) — as though the UPDATE had never run.

**Q47.** `GetPlayerPerformances(1)` — all performance rows for player_id 1.

| PERFORMANCE_ID | MATCH_ID | PLAYER_ID | RUNS_SCORED | BALLS_FACED | WICKETS_TAKEN | CATCHES |
|---|---|---|---|---|---|---|
| 1 | 1 | 1 | 75 | 50 | 0 | 1 |
| 11 | 3 | 1 | 30 | 35 | 0 | 0 |
| 21 | 6 | 1 | 15 | 20 | 0 | 1 |
| 31 | 8 | 1 | 100 | 65 | 0 | 0 |

**Q48.** Trigger demonstration — Mumbai Warriors' total_wins before and after inserting match (1 vs 5, Wankhede, won by 1):

| Before | After |
|---|---|
| TOTAL_WINS = 2 | TOTAL_WINS = 3 |

New match row (match_id 9):

| MATCH_ID | TEAM1_ID | TEAM2_ID | MATCH_DATE | VENUE | WINNER_ID |
|---|---|---|---|---|---|
| 9 | 1 | 5 | 2026-01-25 | WANKHEDE STADIUM | 1 |

**Q49.** `AddMatchResult(3, 5, '2026-01-27', 'MA CHIDAMBARAM STADIUM', 3)` inside a transaction.

New match row (match_id 10):

| MATCH_ID | TEAM1_ID | TEAM2_ID | MATCH_DATE | VENUE | WINNER_ID |
|---|---|---|---|---|---|
| 10 | 3 | 5 | 2026-01-27 | MA CHIDAMBARAM STADIUM | 3 |

Chennai Titans' total_wins: **2 → 3** after COMMIT (trigger fired automatically).

**Q50.** Top run-scorer per team.

| TEAM_NAME | PLAYER_NAME | total_runs |
|---|---|---|
| CHENNAI TITANS | ARUN NAIR | 173 |
| DELHI STRIKERS | VIKRAM SINGH | 205 |
| LONDON ROYALS | JAMES COOK | 145 |
| MUMBAI WARRIORS | ROHIT VERMA | 220 |
| SYDNEY SIXERS | STEVE WALKER | 125 |

**Q51.** Lowest run-scorer per match.

| MATCH_ID | PLAYER_NAME | RUNS_SCORED |
|---|---|---|
| 1 | MANOJ TIWARI | 5 |
| 2 | MARK WOOD | 0 |
| 3 | HARRY STILES | 8 |
| 4 | PRAKASH RAJ | 1 |
| 5 | OLIVER BROWN | 15 |
| 6 | ROHIT VERMA | 15 |
| 7 | MANOJ TIWARI | 3 |
| 8 | CHRIS ADAMS | 10 |

**Q52.** Performances at Wankhede Stadium.

| PLAYER_NAME | TEAM_NAME | MATCH_DATE | VENUE | RUNS_SCORED |
|---|---|---|---|---|
| MANOJ TIWARI | CHENNAI TITANS | 2026-01-05 | WANKHEDE STADIUM | 5 |
| ROHIT VERMA | MUMBAI WARRIORS | 2026-01-05 | WANKHEDE STADIUM | 75 |
| SURESH IYER | MUMBAI WARRIORS | 2026-01-05 | WANKHEDE STADIUM | 10 |
| VIKRAM SINGH | DELHI STRIKERS | 2026-01-05 | WANKHEDE STADIUM | 45 |
| ANAND PILLAI | MUMBAI WARRIORS | 2026-01-18 | WANKHEDE STADIUM | 22 |
| ARUN NAIR | CHENNAI TITANS | 2026-01-18 | WANKHEDE STADIUM | 65 |
| ROHIT VERMA | MUMBAI WARRIORS | 2026-01-18 | WANKHEDE STADIUM | 15 |

*(Note: by this point MANOJ TIWARI's team shows as CHENNAI TITANS because of the Q46 transfer earlier in the Advanced tier.)*

**Q53.** UNION ALL of runs=0 and wickets=0 — 17 rows.

| PLAYER_NAME | MATCH_ID | RUNS_SCORED | WICKETS_TAKEN |
|---|---|---|---|
| VIKRAM SINGH | 1 | 45 | 0 |
| ROHIT VERMA | 1 | 75 | 0 |
| MARK WOOD | 2 | 0 | 1 |
| STEVE WALKER | 2 | 55 | 0 |
| ARUN NAIR | 2 | 88 | 0 |
| ROHIT VERMA | 3 | 30 | 0 |
| JAMES COOK | 3 | 60 | 0 |
| ARUN NAIR | 4 | 20 | 0 |
| VIKRAM SINGH | 4 | 70 | 0 |
| JAMES COOK | 5 | 50 | 0 |
| STEVE WALKER | 5 | 42 | 0 |
| ARUN NAIR | 6 | 65 | 0 |
| ROHIT VERMA | 6 | 15 | 0 |
| VIKRAM SINGH | 7 | 90 | 0 |
| JAMES COOK | 7 | 35 | 0 |
| ROHIT VERMA | 8 | 100 | 0 |
| STEVE WALKER | 8 | 28 | 0 |

**Q54.** Teams whose combined runs exceed 250.

| TEAM_NAME | combined_runs |
|---|---|
| MUMBAI WARRIORS | 292 |

**Q55.** Team(s) with the lowest total_wins.

| TEAM_NAME | TOTAL_WINS |
|---|---|
| SYDNEY SIXERS | 0 |

**Q56.** Multi-statement transaction (Sydney Sixers coach → Ricky Ponting; match_id 2 venue → MCG).

Both mid-transaction and post-COMMIT SELECTs show:

| TEAM_NAME | COACH_NAME |
|---|---|
| SYDNEY SIXERS | Ricky Ponting |

| MATCH_ID | VENUE |
|---|---|
| 2 | MCG |

**Had ROLLBACK been used instead of COMMIT**, both changes would be undone together (it's one transaction): the coach name would revert to "Michael Clarke" and match_id 2's venue would revert to "MA CHIDAMBARAM STADIUM". ROLLBACK undoes every statement since `START TRANSACTION`, not just one of them.

**Q57.** `GetTeamRoster(1)` — Mumbai Warriors' roster ordered by role.

| PLAYER_ID | PLAYER_NAME | ROLE | DATE_OF_BIRTH |
|---|---|---|---|
| 3 | ANAND PILLAI | ALL-ROUNDER | 1995-01-10 |
| 1 | ROHIT VERMA | BATSMAN | 1990-04-15 |
| 21 | YUVRAJ RATHORE | BATSMAN | 2000-05-10 |
| 2 | SURESH IYER | BOWLER | 1993-06-20 |
| 4 | KARAN MEHTA | WICKET-KEEPER | 1997-08-25 |

**Q58.** Trigger demonstration (recreated, same name) — Chennai Titans vs London Royals, Chepauk, won by Chennai Titans.

| Before | After |
|---|---|
| TOTAL_WINS = 3 | TOTAL_WINS = 4 |

New match row (match_id 11):

| MATCH_ID | TEAM1_ID | TEAM2_ID | MATCH_DATE | VENUE | WINNER_ID |
|---|---|---|---|---|---|
| 11 | 3 | 5 | 2026-02-01 | Chepauk | 3 |

**Q59.** `RecordMatchResult(2, 4, '2026-02-05', 'MCG', 4)` inside a transaction — Delhi Strikers vs Sydney Sixers, won by Sydney Sixers.

New match row (match_id 12):

| MATCH_ID | TEAM1_ID | TEAM2_ID | MATCH_DATE | VENUE | WINNER_ID |
|---|---|---|---|---|---|
| 12 | 2 | 4 | 2026-02-05 | MCG | 4 |

Sydney Sixers' total_wins: **0 → 1** after COMMIT (trigger fired automatically).

**Q60.** Player with the second-highest total career runs.

| PLAYER_NAME | total_runs |
|---|---|
| VIKRAM SINGH | 205 |

(ROHIT VERMA has the highest, at 220 runs; VIKRAM SINGH is second.)