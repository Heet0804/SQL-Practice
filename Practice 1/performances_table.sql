USE CRICKET_LEAGUE;

CREATE TABLE IF NOT EXISTS PERFORMANCES(
PERFORMANCE_ID INT AUTO_INCREMENT PRIMARY KEY,
MATCH_ID INT,
PLAYER_ID INT,
RUNS_SCORED INT DEFAULT 0,
BALLS_FACED INT DEFAULT 0,
WICKETS_TAKEN INT DEFAULT 0,
CATCHES INT DEFAULT 0,
FOREIGN KEY (MATCH_ID) REFERENCES MATCHES(MATCH_ID),
FOREIGN KEY (PLAYER_ID) REFERENCES PLAYERS(PLAYER_ID)
);

INSERT INTO PERFORMANCES ( MATCH_ID,PLAYER_ID,RUNS_SCORED , BALLS_FACED, WICKETS_TAKEN , CATCHES) VALUES
-- Match 1: Mumbai Warriors vs Delhi Strikers
(1, 1,  75, 50, 0 ,1),
(1, 2,  10, 15, 2, 0),
(1, 5,  45, 40, 0, 0),
(1, 6,  5,  8, 3, 1),

-- Match 2: Chennai Titans vs Sydney Sixers
(2, 9,  88, 60, 0, 0),
(2, 10,  2,  5, 4, 0),
(2, 13, 55, 45, 0, 1),
(2, 14,  0,  2, 1, 0),

-- Match 3: London Royals vs Mumbai Warriors
(3, 17, 60, 48, 0, 0),
(3, 18,  8, 10, 2, 1),
(3, 1,  30, 35, 0, 0),
(3, 3,  40, 30, 1, 1),

-- Match 4: Delhi Strikers vs Chennai Titans
(4, 5,  70, 55, 0, 0),
(4, 7,  25, 20, 2, 0),
(4, 9,  20, 25, 0, 1),
(4, 10,  1,  3, 1, 0),

-- Match 5: Sydney Sixers vs London Royals (no result)
(5, 13, 42, 38, 0, 0),
(5, 15, 33, 28, 1, 1),
(5, 17, 50, 44, 0, 0),
(5, 19, 15, 12, 2, 0),

-- Match 6: Mumbai Warriors vs Chennai Titans
(6, 1,  15, 20, 0, 1),
(6, 3,  22, 18, 1, 0),
(6, 9,  65, 50, 0, 0),
(6, 11, 18, 15, 3, 1),

-- Match 7: Delhi Strikers vs London Royals
(7, 5,  90, 62, 0, 0),
(7, 6,   3,  6, 2, 0),
(7, 17, 35, 40, 0, 1),
(7, 18, 12, 14, 1, 0),

-- Match 8: Sydney Sixers vs Mumbai Warriors
(8, 13, 28, 30, 0, 0),
(8, 15, 10, 12, 2, 1),
(8, 1, 100, 65, 0, 0),
(8, 2,   6, 10, 3, 0);

SELECT * FROM PERFORMANCES;