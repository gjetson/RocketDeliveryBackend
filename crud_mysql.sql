-- mysql version
DROP DATABASE IF EXISTS bonus_db;

CREATE DATABASE bonus_db;

CREATE TABLE bonus_db.students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

DESC bonus_db.students;

INSERT INTO
    bonus_db.students(name, age)
VALUES
    ('Ringo', 14),
    ('Cindy', 15);

SELECT
    *
FROM
    bonus_db.students;

UPDATE
    bonus_db.students
SET
    age = 16
WHERE
    name = 'Cindy';

SELECT
    *
FROM
    bonus_db.students;

DELETE FROM
    bonus_db.students
WHERE
    age = 14;

SELECT
    *
FROM
    bonus_db.students;