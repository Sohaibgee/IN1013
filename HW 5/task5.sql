-- 1. Which waiters have taken 2 or more bills on a single date? 
-- List the waiter names and surnames, the dates, and the number of bills they have taken.
SELECT rs.first_name, rs.surname, rb.bill_date, COUNT(rb.bill_no) AS num_bills
FROM restBill rb
JOIN restStaff rs ON rb.waiter_no = rs.staff_no
GROUP BY rs.first_name, rs.surname, rb.bill_date
HAVING COUNT(rb.bill_no) >= 2;

-- 2. List the rooms with tables that can serve more than 6 people and how many of such tables they have.
SELECT rt.room_name, COUNT(rt.table_no) AS num_tables
FROM restRest_table rt
WHERE rt.no_of_seats > 6
GROUP BY rt.room_name;

-- 3. List the names of the rooms and the total amount of bills in each room.
SELECT rt.room_name, SUM(rb.bill_total) AS total_bills
FROM restBill rb
JOIN restRest_table rt ON rb.table_no = rt.table_no
GROUP BY rt.room_name;

-- 4. List the headwaiter’s name and surname and the total bill amount their waiters have taken. 
-- Order the list by total bill amount, largest first.
SELECT h.first_name, h.surname, SUM(rb.bill_total) AS total_bill_amount
FROM restBill rb
JOIN restStaff w ON rb.waiter_no = w.staff_no
JOIN restStaff h ON w.headwaiter = h.staff_no
GROUP BY h.first_name, h.surname
ORDER BY total_bill_amount DESC;

-- 5. List any customers who have spent more than £400 on average.
SELECT rb.cust_name, AVG(rb.bill_total) AS avg_spent
FROM restBill rb
GROUP BY rb.cust_name
HAVING AVG(rb.bill_total) > 400;

-- 6. Which waiters have taken 3 or more bills on a single date? 
-- List the waiter names, surnames, and the number of bills they have taken.
SELECT rs.first_name, rs.surname, COUNT(rb.bill_no) AS num_bills
FROM restBill rb
JOIN restStaff rs ON rb.waiter_no = rs.staff_no
GROUP BY rs.first_name, rs.surname, rb.bill_date
HAVING COUNT(rb.bill_no) >= 3;
