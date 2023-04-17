CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

INSERT INTO
    students(name, age)
VALUES
    ('Ringo', 14),
    ('Cindy', 15);

SELECT
    *
FROM
    students;

UPDATE
    students
SET
    age = 16
WHERE
    name = 'Cindy';

SELECT
    *
FROM
    students;

DELETE FROM
    students
WHERE
    age = 14;

SELECT
    *
FROM
    students;