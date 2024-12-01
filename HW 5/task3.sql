-- 1. List the names of the waiters who have served the customer Tanya Singh.
SELECT DISTINCT rs.first_name, rs.surname
FROM restBill rb
JOIN restStaff rs ON rb.waiter_no = rs.staff_no
WHERE rb.cust_name = 'Tanya Singh';

-- 2. On which dates in February 2016 did the Headwaiter 'Charles' manage the 'Green' room?
SELECT rrm.room_date
FROM restRoom_management rrm
JOIN restStaff rs ON rrm.headwaiter = rs.staff_no
WHERE rs.first_name = 'Charles' AND rrm.room_name = 'Green'
  AND rrm.room_date BETWEEN 160201 AND 160229;

-- 3. List the names and surnames of the waiters with the same headwaiter as the waiter Zoe Ball.
SELECT DISTINCT rs.first_name, rs.surname
FROM restStaff rs
WHERE rs.headwaiter = (
    SELECT headwaiter
    FROM restStaff
    WHERE first_name = 'Zoe' AND surname = 'Ball'
);

-- 4. List the customer name, the amount they spent, and the waiter’s name for all bills. Order the list by the amount spent, highest bill first.
SELECT rb.cust_name, rb.bill_total, rs.first_name || ' ' || rs.surname AS waiter_name
FROM restBill rb
JOIN restStaff rs ON rb.waiter_no = rs.staff_no
ORDER BY rb.bill_total DESC;

-- 5. List the names and surnames of the waiters who serve tables that worked in the same team that served bills 00014 and 00017.
SELECT DISTINCT rs.first_name, rs.surname
FROM restStaff rs
WHERE rs.staff_no IN (
    SELECT rb.waiter_no
    FROM restBill rb
    WHERE rb.bill_no IN (14, 17)
)
OR rs.staff_no IN (
    SELECT headwaiter
    FROM restStaff
    WHERE staff_no IN (
        SELECT waiter_no
        FROM restBill
        WHERE bill_no IN (14, 17)
    )
);

-- 6. List the names and surnames of the waiters in the team (including the headwaiter) that served Blue room on 160312.
SELECT DISTINCT rs.first_name, rs.surname
FROM restStaff rs
WHERE rs.staff_no IN (
    SELECT rb.waiter_no
    FROM restBill rb
    JOIN restRest_table rt ON rb.table_no = rt.table_no
    WHERE rt.room_name = 'Blue' AND rb.bill_date = 160312
)
OR rs.staff_no IN (
    SELECT headwaiter
    FROM restRoom_management
    WHERE room_name = 'Blue' AND room_date = 160312
);
