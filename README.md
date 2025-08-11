# Bookstore Database Project

## 📌 Project Overview
This project simulates a bookstore system with **Books**, **Customers**, and **Orders** tables.  
It includes SQL queries to analyze sales trends, track inventory, and identify high-value customers.

## 🎯 Business Use Case
- Monitor **sales performance** by genre, author, and book popularity
- Identify **top-spending customers**
- Track **monthly sales trends**
- Support **inventory and pricing decisions**

## 🛠 Skills Demonstrated
- **Database Design:** `CREATE TABLE`, `ALTER TABLE`
- **Data Aggregation:** `SUM`, `AVG`, `COUNT`, `GROUP BY`, `HAVING`
- **Joins:** `INNER JOIN`, `RIGHT JOIN`
- **Advanced SQL:** `RANK()` window function
- **Formatting:** `TO_CHAR()` for date manipulation

## 📊 Example Reports
- Top 3 most expensive Fantasy books
- Cities where customers spent over $100
- Most frequently ordered book
- Total books sold per genre
- Customers with at least 2 orders

## 🚀 How to Run
1. Create a PostgreSQL database.
2. Run `bookstore_project.sql` to create tables and execute queries.
3. Add sample data as needed for testing.

## Example :
- Find the top 3 most expensive book of 'Fantasy' genre 
- select * from (
- select title ,
- genre,
- Rank() over(partition by genre order by SUM(price) DESC)
- from books
- group by genre, title
-	) as ranked
-	where genre = 'Fantasy'
-	limit 3;

## 📄 Author
Your Name — [Mohammed Nihal](https://linkedin.com/in/Mohdnihal03)



