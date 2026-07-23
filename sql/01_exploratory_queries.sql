-- ==========================================
-- Exploratory SQL Queries
-- Dataset: Sample Superstore
-- ==========================================

--------------------------------------------------
-- Business Question 1
-- Which orders came from the East region with discounts greater than 40%?
--------------------------------------------------

SELECT "Order ID", "Customer Name", "Region", "Discount", "Profit"
FROM superstore_cleaned
WHERE Region = 'East' AND Discount > 0.4;

--------------------------------------------------
-- Business Question 2
-- Which product categories generate the highest total sales and profit?
--------------------------------------------------

SELECT Category, SUM(Sales) AS total_sales, SUM(Profit) AS total_profit
FROM superstore_cleaned
GROUP BY Category
ORDER BY total_profit DESC;

--------------------------------------------------
-- Business Question 3
-- Which sub-categories lose money on average?
--------------------------------------------------

SELECT [Sub-Category], AVG(Profit) AS avg_profit, COUNT(*) AS order_count
FROM superstore_cleaned
GROUP BY [Sub-Category]
HAVING AVG(Profit) < 0
ORDER BY avg_profit ASC;

--------------------------------------------------
-- Business Question 4
-- Which regions are meeting or missing their target profit?
--------------------------------------------------

DROP TABLE IF EXISTS region_targets;

CREATE TABLE region_targets (
    Region TEXT,
    profit_target REAL
);

INSERT INTO region_targets VALUES
('West', 50000), ('East', 45000), ('Central', 40000), ('South', 35000);

SELECT s.Region, SUM(s.Profit) AS actual_profit, r.profit_target,
       SUM(s.Profit) - r.profit_target AS variance
FROM superstore_cleaned s
JOIN region_targets r ON s.Region = r.Region
GROUP BY s.Region;

--------------------------------------------------
-- Business Question 5
-- Which regions generated above-average profit?
--------------------------------------------------

WITH regional_profit AS (
    SELECT Region, SUM(Profit) AS total_profit
    FROM superstore_cleaned
    GROUP BY Region
)
SELECT * FROM regional_profit
ORDER BY total_profit DESC;

--------------------------------------------------
-- Business Question 6
-- which regions/categories are underperforming?
--------------------------------------------------

SELECT Region, Category, 
       SUM(Sales) AS total_sales, 
       SUM(Profit) AS total_profit,
       ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore_cleaned
GROUP BY Region, Category
ORDER BY profit_margin_pct ASC;

--------------------------------------------------
-- Business Question 7
-- which segment has the best margin?
--------------------------------------------------

SELECT Segment, 
       SUM(Sales) AS total_sales, 
       SUM(Profit) AS total_profit,
       ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore_cleaned
GROUP BY Segment
ORDER BY profit_margin_pct DESC;

--------------------------------------------------
-- Business Question 8
-- what is the top performing sub-categories?
--------------------------------------------------

SELECT Region, [Sub-Category], SUM(Profit) AS total_profit,
       RANK() OVER (PARTITION BY Region ORDER BY SUM(Profit) DESC) AS profit_rank
FROM superstore_cleaned
GROUP BY Region, [Sub-Category]
ORDER BY Region, profit_rank;

--------------------------------------------------
-- Business Question 9
-- Cumulative sales over time.
--------------------------------------------------

SELECT strftime('%Y-%m', "Order Date") AS month,
       SUM(Sales) AS monthly_sales,
       SUM(SUM(Sales)) OVER (ORDER BY strftime('%Y-%m', "Order Date")) AS running_total
FROM superstore_cleaned
GROUP BY month
ORDER BY month;