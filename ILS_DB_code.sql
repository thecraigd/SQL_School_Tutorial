
-- Creating the tables --

CREATE TABLE teacher (
  teacher_id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  language_1 VARCHAR(3) NOT NULL,
  language_2 VARCHAR(3),
  dob DATE,
  tax_id INT UNIQUE,
  phone_no VARCHAR(20)
  );

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40) NOT NULL,
  address VARCHAR(60) NOT NULL,
  industry VARCHAR(20)
);

CREATE TABLE participant (
  participant_id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name VARCHAR(40) NOT NULL,
  phone_no VARCHAR(20),
  client INT
);

CREATE TABLE course (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(40) NOT NULL,
  language VARCHAR(3) NOT NULL,
  level VARCHAR(2),
  course_length_weeks INT,
  start_date DATE,
  in_school BOOLEAN,
  teacher INT,
  client INT
);


-- Altering the tables to establish the relationships via FOREIGN KEYs

ALTER TABLE participant
ADD FOREIGN KEY(client)
REFERENCES client(client_id)
ON DELETE SET NULL;

ALTER TABLE course
ADD FOREIGN KEY(teacher)
REFERENCES teacher(teacher_id)
ON DELETE SET NULL;

ALTER TABLE course
ADD FOREIGN KEY(client)
REFERENCES client(client_id)
ON DELETE SET NULL;



CREATE TABLE takes_course (
  participant_id INT,
  course_id INT,
  PRIMARY KEY(participant_id, course_id),
  FOREIGN KEY(participant_id) REFERENCES participant(participant_id) ON DELETE CASCADE, -- it makes no sense to keep this rtelation when a participant or course is no longer in the system, hence why CASCADE this time
  FOREIGN KEY(course_id) REFERENCES course(course_id) ON DELETE CASCADE
);



/*
-- If needed to quickly delete and re-build the tables: 

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE client;
DROP TABLE course;
DROP TABLE participant;
DROP TABLE takes_course;
DROP TABLE teacher;

SET FOREIGN_KEY_CHECKS = 1;

*/

-- Populating the tables

INSERT INTO teacher VALUES
(1,  'James', 'Smith', 'ENG', NULL, '1985-04-20', 12345, '+491774553676'),
(2, 'Stefanie',  'Martin',  'FRA', NULL,  '1970-02-17', 23456, '+491234567890'), 
(3, 'Steve', 'Wang',  'MAN', 'ENG', '1990-11-12', 34567, '+447840921333'),
(4, 'Friederike',  'Müller-Rossi', 'DEU', 'ITA', '1987-07-07',  45678, '+492345678901'),
(5, 'Isobel', 'Ivanova', 'RUS', 'ENG', '1963-05-30',  56789, '+491772635467'),
(6, 'Niamh', 'Murphy', 'ENG', 'IRI', '1995-09-08',  67890, '+491231231232');


INSERT INTO client VALUES
(101, 'Big Business Federation', '123 Falschungstraße, 10999 Berlin', 'NGO'),
(102, 'eCommerce GmbH', '27 Ersatz Allee, 10317 Berlin', 'Retail'),
(103, 'AutoMaker AG',  '20 Künstlichstraße, 10023 Berlin', 'Auto'),
(104, 'Banko Bank',  '12 Betrugstraße, 12345 Berlin', 'Banking'),
(105, 'WeMoveIt GmbH', '138 Arglistweg, 10065 Berlin', 'Logistics');


INSERT INTO participant VALUES
(101, 'Marina', 'Berg','491635558182', 101),
(102, 'Andrea', 'Duerr', '49159555740', 101),
(103, 'Philipp', 'Probst',  '49155555692', 102),
(104, 'René',  'Brandt',  '4916355546',  102),
(105, 'Susanne', 'Shuster', '49155555779', 102),
(106, 'Christian', 'Schreiner', '49162555375', 101),
(107, 'Harry', 'Kim', '49177555633', 101),
(108, 'Jan', 'Nowak', '49151555824', 101),
(109, 'Pablo', 'Garcia',  '49162555176', 101),
(110, 'Melanie', 'Dreschler', '49151555527', 103),
(111, 'Dieter', 'Durr',  '49178555311', 103),
(112, 'Max', 'Mustermann', '49152555195', 104),
(113, 'Maxine', 'Mustermann', '49177555355', 104),
(114, 'Heiko', 'Fleischer', '49155555581', 105);


INSERT INTO course VALUES
(12, 'English for Logistics', 'ENG', 'A1', 10, '2020-02-01', TRUE,  1, 105),
(13, 'Beginner English', 'ENG', 'A2', 40, '2019-11-12',  FALSE, 6, 101),
(14, 'Intermediate English', 'ENG', 'B2', 40, '2019-11-12', FALSE, 6, 101),
(15, 'Advanced English', 'ENG', 'C1', 40, '2019-11-12', FALSE, 6, 101),
(16, 'Mandarin für Autoindustrie', 'MAN', 'B1', 15, '2020-01-15', TRUE, 3, 103),
(17, 'Français intermédiaire', 'FRA', 'B1',  18, '2020-04-03', FALSE, 2, 101),
(18, 'Deutsch für Anfänger', 'DEU', 'A2', 8, '2020-02-14', TRUE, 4, 102),
(19, 'Intermediate English', 'ENG', 'B2', 10, '2020-03-29', FALSE, 1, 104),
(20, 'Fortgeschrittenes Russisch', 'RUS', 'C1',  4, '2020-04-08',  FALSE, 5, 103);


INSERT INTO takes_course VALUES
(101, 15),
(101, 17),
(102, 17),
(103, 18),
(104, 18),
(105, 18),
(106, 13),
(107, 13),
(108, 13),
(109, 14),
(109, 15),
(110, 16),
(110, 20),
(111, 16),
(114, 12),
(112, 19),
(113, 19);


-- ---------------------------------------------------------------------------------------------------------


-- Now for some fun! It's query-time.

-- Get all the details from the teachers table.
SELECT *
FROM teacher;

-- Get the last names and birthdays of all the teachers.
SELECT last_name, dob
FROM teacher;


-- Find all courses in English
SELECT *
FROM course
WHERE language = 'ENG';

SELECT *
FROM course
WHERE language = 'ENG'
ORDER BY start_date DESC;


-- Find all courses in English at B2 level
SELECT *
FROM course
WHERE language = 'ENG' AND level = 'B2';


-- Find all courses in English and all courses at B2 level
SELECT *
FROM course
WHERE language = 'ENG' OR level = 'C1';


-- Find all courses where the language is not English and the level is not C1
SELECT *
FROM course
WHERE NOT language = 'ENG' OR level = 'C1';


-- Get the names and phone numbers of all teachers born before 1990.
SELECT first_name, last_name, phone_no
FROM teacher
WHERE dob < '1990-01-01';

-- Do the same as before but use aliasing.
SELECT first_name AS First Name, last_name AS 'Last Name', phone_no AS Telephone
FROM teacher
WHERE dob < '1990-01-01';


-- Find all courses which start in January
SELECT *
FROM course
WHERE start_date BETWEEN '2020-01-01' AND '2020-01-31';


-- Find some intermediate courses
SELECT course_name
FROM course
WHERE course_name LIKE '%interm%';


-- Find participants whose last names are Garcia, Nowak or Mustermann
SELECT first_name, last_name
FROM participant
WHERE last_name IN ('Garcia', 'Nowak', 'Mustermann');


-- Identify teachers who only teach one or two languages
SELECT * 
FROM teacher
WHERE language_2 IS NULL;


SELECT * 
FROM teacher
WHERE language_2 IS NOT NULL;


-- Find the average length of a course
SELECT AVG(course_length_weeks)
FROM course;


-- Find the average length of a course, grouped by client
SELECT client, AVG(course_length_weeks)
FROM course
GROUP BY client;


-- Count the number of courses
SELECT COUNT(*)
FROM course;


-- Count the number of courses in English
SELECT COUNT(*)
FROM course
WHERE language = 'Eng';


-- How many courses does the school offer in each language?
SELECT language, COUNT(language)
FROM course
GROUP BY language;


-- Find all the teachers whose birthdate is above the average teacher's birthdate 
SELECT *
FROM teacher
WHERE dob > 
    (SELECT AVG(dob)
    FROM teacher);

-- Get the course details for all courses which take place at the client's offices.
SELECT course.course_id, course.course_name, course.language, client.client_name, client.address
FROM course
JOIN client
ON course.client = client.client_id
WHERE course.in_school = FALSE;


-- Get the course details for all courses which take place at the client's offices, which are taught
-- by Stefanie Martin (as above, but with added details).
SELECT course.course_id, course.course_name, course.language, client.client_name, client.address
FROM course
JOIN client
ON course.client = client.client_id
WHERE course.in_school = FALSE AND course.teacher = 2;


-- Get all particpants in classes taught by Niamh Murphy
SELECT participant.first_name, participant.last_name
FROM participant
JOIN takes_course ON takes_course.participant_id = participant.participant_id 
JOIN course ON takes_course.course_id = course.course_id
WHERE takes_course.course_id = 
    (SELECT takes_course.course_id 
    WHERE course.teacher = 6);


-- NEW TABLE ALERT!

CREATE TABLE industry_prospects (
  industry VARCHAR(20) PRIMARY KEY,
  outlook VARCHAR(20)
);

INSERT INTO industry_prospects VALUES
('Retail', 'Good'),
('Hospitality', 'Poor'),
('Logistics', 'Terrible'),
('Tourism', 'Great'),
('Events', 'Good');


SELECT client.client_name, client.industry, industry_prospects.outlook
FROM client
JOIN industry_prospects
ON client.industry = industry_prospects.industry;

SELECT client.client_name, client.industry, industry_prospects.outlook
FROM client
LEFT JOIN industry_prospects
ON client.industry = industry_prospects.industry;

SELECT client.client_name, client.industry, industry_prospects.outlook
FROM client
RIGHT JOIN industry_prospects
ON client.industry = industry_prospects.industry;

SELECT client.client_name, client.industry, industry_prospects.outlook
FROM client
FULL JOIN industry_prospects
ON client.industry = industry_prospects.industry;