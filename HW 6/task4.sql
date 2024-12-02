-- 1. List the names of customers who spent more than 450.00 on a single bill on occasions when ‘Charles’ was their Headwaiter.
SELECT DISTINCT rb.cust_name
FROM restBill rb
WHERE rb.bill_total > 450.00
  AND rb.table_no IN (
      SELECT rt.table_no
      FROM restRest_table rt
      WHERE rt.room_name IN (
          SELECT rrm.room_name
          FROM restRoom_management rrm
          JOIN restStaff rs ON rrm.headwaiter = rs.staff_no
          WHERE rs.first_name = 'Charles'
      )
  );

-- 2. A customer called Nerida has complained that a waiter was rude to her when she dined at the restaurant on the 11th January 2016. 
-- What is the name and surname of the Headwaiter who will have to deal with the matter?
SELECT rs.first_name, rs.surname
FROM restStaff rs
WHERE rs.staff_no = (
    SELECT rrm.headwaiter
    FROM restRoom_management rrm
    JOIN restRest_table rt ON rrm.room_name = rt.room_name
    WHERE rt.table_no IN (
        SELECT table_no
        FROM restBill
        WHERE cust_name = 'Nerida Smith' AND bill_date = 160111
    )
);

-- 3. What are the names of customers with the smallest bill?
SELECT cust_name
FROM restBill
WHERE bill_total = (
    SELECT MIN(bill_total)
    FROM restBill
);

-- 4. List the names of any waiters who have not taken any bills.
SELECT rs.first_name, rs.surname
FROM restStaff rs
WHERE rs.staff_no NOT IN (
    SELECT DISTINCT waiter_no
    FROM restBill
);

-- 5. Which customers had the largest single bill? 
-- List the customer name, the name and surname of headwaiters, and the room name where they were served on that occasion.
SELECT rb.cust_name, rs.first_name AS headwaiter_first_name, rs.surname AS headwaiter_surname, rt.room_name
FROM restBill rb
JOIN restRest_table rt ON rb.table_no = rt.table_no
JOIN restRoom_management rrm ON rt.room_name = rrm.room_name AND rb.bill_date = rrm.room_date
JOIN restStaff rs ON rrm.headwaiter = rs.staff_no
WHERE rb.bill_total = (
    SELECT MAX(bill_total)
    FROM restBill
);
