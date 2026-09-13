# Cricket League SQL Practice (Q1–Q60)

A set of 60 SQL practice problems built around a small "Cricket League"
database, progressing from basic `SELECT`/`INSERT`/`UPDATE` statements
through joins and subqueries to stored procedures, triggers, and
transactions.

## Contents

| File | Description |
|---|---|
| `questions.md` | All 60 questions in plain English, grouped by difficulty (Basic → Intermediate → Advanced). |
| `query.md` | The SQL solution for each question. |
| `expected_answers.md` | The actual result set produced by running every query, in order, against a fresh MySQL/MariaDB database — including row counts, affected-row messages, and table snapshots after data-changing statements. |

> Table/column names are used exactly as created (`CRICKET_LEAGUE`,
> `TEAMS`, `PLAYERS`, `MATCHES`, `PERFORMANCES`, all uppercase).
> `USE CRICKET_LEAGUE;` is assumed before every query. For
> `CREATE PROCEDURE` / `CREATE TRIGGER` blocks, remember to switch the
> client delimiter (e.g. `DELIMITER //`) so semicolons inside the
> routine body don't end the statement early.

## Schema

- **TEAMS** — team_id, team_name, country, coach_name, total_wins
- **PLAYERS** — player_id, player_name, team_id, role, date_of_birth
  (plus `jersey_number` and `is_captain`, added in Q7/Q17)
- **MATCHES** — match_id, team1_id, team2_id, match_date, venue, winner_id
- **PERFORMANCES** — performance_id, match_id, player_id, runs_scored,
  balls_faced, wickets_taken, catches

## Topics covered

**Basic (Q1–Q20)** — `SELECT`/`WHERE`/`ORDER BY`, `INSERT`, `UPDATE`,
`DELETE`, `ALTER TABLE`, `GROUP BY`, date functions, `DISTINCT`.

**Intermediate (Q21–Q40)** — `INNER`/`LEFT JOIN`, self-joins, `GROUP BY`
+ `HAVING`, `UNION`, scalar subqueries, `VIEW`s, `INDEX`es.

**Advanced (Q41–Q60)** — correlated subqueries, multi-table joins,
`UNION ALL`, nested subqueries for top-N-per-group, `TRANSACTION`s
(`COMMIT`/`ROLLBACK`), `STORED PROCEDURE`s, and `TRIGGER`s.

## ⚠️ Important: solve strictly in order

This is **not** a bag of independent queries — it's a single running
database. The following questions **permanently change the data**, and
every later question reflects that changed state:

- **Basic:** Q4, Q5, Q6, Q7 (insert player, update coach, delete a
  performance, add a column) and Q14–Q17 (second insert, another
  update/delete, another column)
- **Advanced:** Q46 (transfers a player between teams), Q48 & Q49
  (create a trigger and insert new matches, incrementing `total_wins`),
  Q56 (multi-statement transaction), Q58 & Q59 (recreate the trigger,
  insert two more matches)

If you re-run the queries out of order, or skip a data-changing step,
your results will diverge from `expected_answers.md`.

## How to use this

1. Load the five base setup files
   (`teams_table.sql`, `players_table.sql`, `matches_table.sql`,
   `performances_table.sql`) into a fresh MySQL/MariaDB-compatible
   database.
2. Run `USE CRICKET_LEAGUE;`.
3. Work through `questions.md` in order (Q1 → Q60), writing your own
   query for each before checking it against `query.md`.
4. Compare your output to the corresponding section in
   `expected_answers.md` to confirm correctness.

## Notable milestones

- **Q29 / Q39** create the `player_stats` and `team_summary` views.
- **Q30 / Q40** create indexes on `PLAYERS(TEAM_ID)` and
  `MATCHES(VENUE)`.
- **Q47 / Q57** create the `GetPlayerPerformances` and `GetTeamRoster`
  stored procedures.
- **Q48 / Q58** create (and recreate) the `trg_update_team_wins`
  trigger, which auto-increments a team's `total_wins` whenever a
  match with a non-NULL `winner_id` is inserted.
- **Q49 / Q59** create procedures (`AddMatchResult`,
  `RecordMatchResult`) that insert matches inside a transaction and
  rely on the trigger to keep `total_wins` in sync.
- By Q60, ROHIT VERMA leads all-time runs with 220, followed by
  VIKRAM SINGH with 205.