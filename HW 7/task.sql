-- 1) Create the samsBills view
CREATE VIEW samsBills AS
SELECT 
    first_name, 
    surname, 
    bill_date, 
    cust_name, 
    bill_total
FROM 
    bills
WHERE 
    first_name = 'Sam' AND surname = 'Pitt';
---
-- 2) Query using the samsBills view to see bills over £400
SELECT *
FROM samsBills
WHERE bill_total > 400;
---
-- 3) Create the roomTotals view
CREATE VIEW roomTotals AS
SELECT 
    room_name, 
    SUM(bill_total) AS total_sum
FROM 
    rooms
JOIN 
    bills ON rooms.room_id = bills.room_id
GROUP BY 
    room_name;
---
-- 4) Create the teamTotals view
CREATE VIEW teamTotals AS
SELECT 
    CONCAT(first_name, ' ', surname) AS headwaiter_name, 
    SUM(bill_total) AS total_sum
FROM 
    waiters
JOIN 
    bills ON waiters.waiter_id = bills.waiter_id
GROUP BY 
    headwaiter_name;
