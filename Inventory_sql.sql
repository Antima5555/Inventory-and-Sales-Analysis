SELECT COUNT(*) AS total_rows
FROM inventory.final_inventory_eda;

-- Date range-- 
SELECT 
  MIN(OrderDate) AS start_date,
  MAX(OrderDate) AS end_date
FROM inventory.final_inventory_eda;

-- NULL check (important columns)-- 
SELECT 
  SUM(OrderDate IS NULL) AS null_orderdate,
  SUM(ProductName IS NULL) AS null_product,
  SUM(TotalRevenue IS NULL) AS null_revenue
FROM inventory.final_inventory_eda;


-- STEP 2: Sales & Revenue Analysis (CORE)
-- Total Revenue-- 
SELECT 
  ROUND(SUM(TotalRevenue),2) AS total_revenue
FROM inventory.final_inventory_eda;

SELECT 
  OrderYear,
  ROUND(SUM(TotalRevenue),2) AS yearly_revenue
FROM inventory.final_inventory_eda
GROUP BY OrderYear
ORDER BY OrderYear;

SELECT 
  OrderQuarter,
  ROUND(SUM(TotalRevenue),2) AS quarter_revenue
FROM inventory.final_inventory_eda
GROUP BY OrderQuarter
ORDER BY OrderQuarter;

SELECT 
  ProductName,
  ROUND(SUM(TotalRevenue),2) AS revenue
FROM inventory.final_inventory_eda
GROUP BY ProductName
ORDER BY revenue DESC
LIMIT 10;

SELECT 
  CategoryName,
  ROUND(SUM(TotalRevenue),2) AS revenue,
  ROUND(SUM(Profit),2) AS profit
FROM inventory.final_inventory_eda
GROUP BY CategoryName
ORDER BY revenue DESC;

SELECT 
  CustomerSegment,
  ROUND(SUM(TotalRevenue),2) AS revenue
FROM inventory.final_inventory_eda
GROUP BY CustomerSegment
ORDER BY revenue DESC;


SELECT 
  CustomerName,
  ROUND(SUM(TotalRevenue),2) AS revenue
FROM inventory.final_inventory_eda
GROUP BY CustomerName
ORDER BY revenue DESC
LIMIT 10;

SELECT 
  CountryName,
  ROUND(SUM(TotalRevenue),2) AS revenue
FROM inventory.final_inventory_eda
GROUP BY CountryName
ORDER BY revenue DESC;

SELECT 
  WarehouseName,
  ROUND(SUM(TotalRevenue),2) AS revenue
FROM inventory.final_inventory_eda
GROUP BY WarehouseName
ORDER BY revenue DESC;

SELECT 
  EmployeeName,
  ROUND(SUM(TotalRevenue),2) AS revenue
FROM inventory.final_inventory_eda
GROUP BY EmployeeName
ORDER BY revenue DESC;


SELECT 
  CustomerSegment,
  ROUND(AVG(ProfitMargin),4) AS avg_profit_margin
FROM inventory.final_inventory_eda
GROUP BY CustomerSegment;


SELECT 
  OrderYear,
  OrderMonth,
  ROUND(SUM(TotalRevenue),2) AS revenue,
  ROUND(
    SUM(TotalRevenue) 
    - LAG(SUM(TotalRevenue)) OVER (ORDER BY OrderYear, OrderMonth),
  2) AS growth
FROM inventory.final_inventory_eda
GROUP BY OrderYear, OrderMonth;

SELECT 
  OrderDate,
  ROUND(SUM(TotalRevenue),2) AS daily_revenue,
  ROUND(
    SUM(SUM(TotalRevenue)) OVER (ORDER BY OrderDate),
  2) AS running_total
FROM inventory.final_inventory_eda
GROUP BY OrderDate;

CREATE VIEW vw_sales_summary AS
SELECT 
  OrderYear,
  OrderQuarter,
  CategoryName,
  ROUND(SUM(TotalRevenue),2) AS revenue,
  ROUND(SUM(Profit),2) AS profit
FROM inventory.final_inventory_eda
GROUP BY OrderYear, OrderQuarter, CategoryName;



