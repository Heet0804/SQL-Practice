-- =========================================================
-- CRICKET LEAGUE PRACTICE DATABASE
-- schema.sql -> database + table structure ONLY (no data)
-- =========================================================

DROP DATABASE IF EXISTS cricket_league;
CREATE DATABASE cricket_league;
USE cricket_league;

-- TABLE: teams
CREATE TABLE teams (
    team_id      INT AUTO_INCREMENT PRIMARY KEY,
    team_name    VARCHAR(50) NOT NULL,
    country      VARCHAR(50) NOT NULL,
    coach_name   VARCHAR(50),
    total_wins   INT DEFAULT 0
);

-- TABLE: players
CREATE TABLE players (
    player_id      INT AUTO_INCREMENT PRIMARY KEY,
    player_name    VARCHAR(50) NOT NULL,
    team_id        INT,
    role           VARCHAR(20),
    date_of_birth  DATE,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- TABLE: matches
CREATE TABLE matches (
    match_id     INT AUTO_INCREMENT PRIMARY KEY,
    team1_id     INT,
    team2_id     INT,
    match_date   DATE,
    venue        VARCHAR(100),
    winner_id    INT,
    FOREIGN KEY (team1_id) REFERENCES teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES teams(team_id),
    FOREIGN KEY (winner_id) REFERENCES teams(team_id)
);

-- TABLE: performances
-- one row = one player's stats in one match
CREATE TABLE performances (
    performance_id  INT AUTO_INCREMENT PRIMARY KEY,
    match_id        INT,
    player_id       INT,
    runs_scored     INT DEFAULT 0,
    balls_faced     INT DEFAULT 0,
    wickets_taken   INT DEFAULT 0,
    catches         INT DEFAULT 0,
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);