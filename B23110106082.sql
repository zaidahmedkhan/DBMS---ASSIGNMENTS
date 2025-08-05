-- Assignment bY ZAID AHMED KHAN, SEAT NUMBER : B23110106082

-- 1. Create database
CREATE DATABASE library_db;

-- 2. Create table
CREATE TABLE books(
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    year_published INT,
    isAvailable BOOLEAN,
    price NUMERIC(10, 2),
    publication VARCHAR(255)
);

-- 3. Insert 15 sample books
INSERT INTO books(title, author, year_published, isAvailable, price, publication)
VALUES
    ('Digital World', 'Ali Raza', 2005, TRUE, 420.00, 'XYZ'),
    ('Whispers of the Past', 'Sara Khan', 1998, FALSE, 375.00, 'Penguin'),
    ('The Final Horizon', 'Zain Malik', 2011, TRUE, 610.00, 'Nova Press'),
    ('The Lost Signal', 'Rida Ahmed', 2003, TRUE, 540.00, 'XYZ'),
    ('Echoes of Tomorrow', 'Ameer Ali', 2020, TRUE, 815.00, 'Future House'),
    ('Broken Compass', 'Lina Shah', 1995, FALSE, 280.00, 'Harper Books'),
    ('Code of Silence', 'Bilal Mehmood', 2015, TRUE, 599.00, 'TechSource'),
    ('Hidden Truths', 'Nida Saeed', 2001, TRUE, 560.00, 'XYZ'),
    ('Rise of the Machines', 'Hassan Qureshi', 1999, FALSE, 450.00, 'Cyber Books'),
    ('Frozen Reality', 'Yusra Khan', 2013, FALSE, 470.00, 'Iceberg Publishers'),
    ('Mindstorm', 'Jawad Rehman', 2018, TRUE, 570.00, 'Nova Press'),
    ('Skyline Dreams', 'Zoya Noor', 2022, TRUE, 380.00, 'XYZ'),
    ('Fragments of Hope', 'Asim Reza', 2008, FALSE, 630.00, 'Harper Books'),
    ('Chains of Logic', 'Kiran Abbas', 2006, TRUE, 310.00, 'Binary Press'),
    ('XYZ Handbook', 'Mariam Tariq', 2019, TRUE, 590.00, 'XYZ');

-- 4. Select books published after 2000
SELECT * FROM books
WHERE year_published > 2000;

-- 5. Select books with price < 599.00 ordered by price descending
SELECT * FROM books
WHERE price < 599.00
ORDER BY price DESC;

-- 6. Select top 3 most expensive books
SELECT * FROM books
ORDER BY price DESC
LIMIT 3;

-- 7. Select 2 books skipping first 2, ordered by year descending
SELECT * FROM books
ORDER BY year_published DESC
OFFSET 2
LIMIT 2;

-- 8. Select all books from publication 'XYZ' ordered alphabetically by title
SELECT * FROM books
WHERE publication = 'XYZ'
ORDER BY title ASC;
