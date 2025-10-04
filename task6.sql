use ecommercedb;

-- selecting avg price using subquery
select name as Product_Name, Price, (select avg(price) from products) as Avg_Price
from products;

-- selecting second highest price from the product price
select  max(price) from products where price < (select max(price) from products);

select name from customers where customer_id in (select customer_id from orders);

select name from customers 
where customer_id not in (select customer_id from orders);

-- correlated query
SELECT Name
FROM Customers c
WHERE EXISTS (
    SELECT 1 
    FROM Orders o
    WHERE o.Customer_ID = c.Customer_ID
      AND o.Total_Amount > 200
);

-- products name with highest price
select name, price from products 
where price = (select max(price) from products);

SELECT Name, TotalSpent
FROM (
    SELECT c.Name, SUM(o.Total_Amount) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.Customer_ID = o.Customer_ID
    GROUP BY c.Name
) AS CustomerTotals
ORDER BY TotalSpent DESC
LIMIT 3;

select c.name,o.total_amount from customers c
inner join orders o on c.customer_id = o.customer_id
order by total_amount desc
limit 3;

SELECT c.Name, SUM(o.Total_Amount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name
HAVING SUM(o.Total_Amount) > (
    SELECT AVG(Total_Amount) FROM Orders
);

