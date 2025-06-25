# 🍕 Pizza Sales SQL Project

## 📌 About the Project
This project is a SQL-based analysis of a fictional pizza restaurant's sales data. Using MySQL, I explored the dataset to answer over 13 real-world business questions, including revenue analysis, customer order behavior, category trends, and performance of different pizza types and sizes.

## 🗂 Dataset Structure
The project uses four related CSV files imported into MySQL:

| Table Name       | Description                                         |
|------------------|-----------------------------------------------------|
| `orders`         | Contains order ID, date, and time of each order     |
| `order_details`  | Links orders to specific pizzas and quantities      |
| `pizzas`         | Includes pizza ID, size, and price                  |
| `pizza_types`    | Contains pizza names, categories, and ingredients   |

## 📊 Business Questions Answered
This project answers the following SQL questions:

1. Total number of orders placed
2. Total revenue generated from pizza sales
3. Highest priced pizza
4. Most common pizza size ordered
5. Top 5 most ordered pizza types by quantity
6. Total quantity of pizzas ordered per category
7. Distribution of orders by hour of the day
8. Count of pizzas by category
9. Average number of pizzas ordered per day
10. Top 3 most ordered pizza types based on revenue
11. Percentage revenue contribution by each pizza type
12. Cumulative revenue over time
13. Top 3 revenue-generating pizzas in each category

## 🧠 SQL Concepts Used
- JOINs across multiple tables
- Aggregation functions (`SUM`, `COUNT`, `AVG`, `ROUND`)
- `GROUP BY`, `ORDER BY`, `LIMIT`
- Common Table Expressions (CTEs)
- Window functions (`RANK`, `OVER`)
- Date and time functions (`HOUR`, `DATE`)

## 🛠 Tools Used
- **MySQL Workbench**: for SQL queries and database management
- **CSV files**: imported as base tables
- **GitHub**: version control and project sharing

## 📎 Files Included
- `orders.csv` – raw order data
- `order_details.csv` – order line items
- `pizzas.csv` – pizza details with size and price
- `pizza_types.csv` – pizza names and categories
- `Queries.sql` – all 13+ business queries used in the project
- `README.md` – this project documentation

## 📌 How to Use
1. Import the 4 CSVs into MySQL
2. Run the table creation and data insertion scripts
3. Execute the queries in `Queries.sql` to explore insights

## 📈 Sample Output
Example:  
Top 3 Pizzas by Revenue
| Pizza Name      | Revenue |
|------------------|---------|
| BBQ Chicken Pizza | ₹5,200 |
| Pepperoni Pizza   | ₹4,890 |
| Margherita Pizza  | ₹4,560 |


---

## 📬 Contact
For questions or collaboration:
**Krishnaveni**  
Email: [mkveni27@gmail.com]  
LinkedIn: [www.linkedin.com/in/
mandala-krishnaveni-53576b240/
]

---
