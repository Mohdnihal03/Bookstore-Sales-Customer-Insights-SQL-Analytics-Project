/*
========================================================
  Bookstore Database Project
  Author: [Your Name]
  Description:
    This SQL project simulates a bookstore system 
    with tables for Books, Customers, and Orders.
    It includes queries for sales analysis, 
    customer insights, and inventory tracking.

  Skills demonstrated:
    - Database design (CREATE TABLE, ALTER TABLE)
    - Data aggregation (SUM, AVG, COUNT, GROUP BY, HAVING)
    - Table joins (INNER, RIGHT JOIN)
    - Window functions (RANK)
    - Data formatting with TO_CHAR
========================================================
*/

-- ==============================
-- SECTION 1: DROP IF EXISTS
-- ==============================
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS books;

-- ==============================
-- SECTION 2: CREATE TABLES (DDL)
-- ==============================
CREATE TABLE books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10,2),
    Stock INT
);

CREATE TABLE customer (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(150),
    Phone VARCHAR(20),
    City VARCHAR(50),
    Country VARCHAR(100)
);

CREATE TABLE orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES customer(Customer_ID),
    Book_ID INT REFERENCES books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
);

-- ==============================
-- SECTION 3: SAMPLE SELECTS
-- ==============================
SELECT * FROM books;
SELECT * FROM customer;
SELECT * FROM orders;

-- ==============================
-- SECTION 4: ANALYTICAL QUERIES
-- ==============================

-- 1. Retrieve all books in the Fiction genre
SELECT title 
FROM books
WHERE genre = 'Fiction';

-- 2. Find books published after 1950
SELECT title, published_year
FROM books
WHERE published_year > 1950
ORDER BY published_year;

-- 3. List all customers from Canada
SELECT *
FROM customer
WHERE country = 'Canada';

-- 4. Show orders placed in November 2023
SELECT b.title, TO_CHAR(o.order_date, 'YYYY-MM') AS order_month
FROM books b
RIGHT JOIN orders o
    ON b.book_id = o.book_id
WHERE TO_CHAR(o.order_date, 'YYYY-MM') = '2023-11';

-- 5. Find the most expensive book
SELECT *
FROM books
ORDER BY price DESC
LIMIT 1;

-- 6. Total number of books sold per genre
SELECT SUM(o.quantity) AS total_books, b.genre
FROM orders o
JOIN books b
    ON o.book_id = b.book_id
GROUP BY b.genre;

-- 7. Average price of books in Fantasy genre
SELECT ROUND(AVG(price), 2) AS average_price, genre
FROM books
WHERE genre = 'Fantasy'
GROUP BY genre;

-- 8. Customers with at least 2 orders
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customer c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) >= 2;

-- 9. Most frequently ordered book
SELECT book_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY book_id
ORDER BY order_count DESC
LIMIT 1;

-- 10. Top 3 most expensive Fantasy books
SELECT title, genre, price
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

-- 11. Total quantity of books sold by each author
SELECT SUM(o.quantity) AS total_quantity, b.author
FROM orders o
JOIN books b
    ON o.book_id = b.book_id
GROUP BY b.author;

-- 12. Cities where customers spent over $100
SELECT c.city, SUM(o.total_amount) AS total_spent
FROM customer c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 100;

-- 13. Customer who spent the most
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customer c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;
