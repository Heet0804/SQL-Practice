USE COMPANY_TRACKER;

CREATE TABLE EMPLOYEE_PROJECTS(
ASSIGNMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
EMP_ID INT,
PROJECT_ID INT,
HOURS_WORKED INT DEFAULT 0,
FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEES(EMP_ID),
FOREIGN KEY(PROJECT_ID) REFERENCES PROJECTS(PROJECT_ID)
);

INSERT INTO EMPLOYEE_PROJECTS(EMP_ID , PROJECT_ID , HOURS_WORKED) VALUES
-- Project 1: Website Revamp (Engineering)
(1, 1,  40),
(2, 1, 120),
(3, 1, 100),

-- Project 2: Mobile App (Engineering)
(2, 2, 150),
(3, 2, 140),
(4, 2,  60),
 
-- Project 3: Ad Campaign Q1 (Marketing)
(5, 3,  30),
(6, 3,  90),
(7, 3,  85),
 
-- Project 4: Product Launch (Sales)
(9, 4,  35),
(10, 4, 95),
(11, 4, 88),
 
-- Project 5: Onboarding Revamp (HR)
(13, 5, 25),
(14, 5, 70),
 
-- Project 6: Cloud Migration (Engineering)
(1, 6,  20),
(3, 6, 110),
(4, 6,  95);

SELECT * FROM EMPLOYEE_PROJECTS;