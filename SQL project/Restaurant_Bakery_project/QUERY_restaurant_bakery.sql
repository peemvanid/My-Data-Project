--Question1_The owner wants to know customer who hold 'Gold Card' membership and who are not, order them by membership status

SELECT 
	cus.customer_id AS ID
    , firstname || ' ' || lastname AS Name
    , CAST(STRFTIME('%Y', 'now') - STRFTIME('%Y', cus.DoB) AS INT) AS Age
    , COALESCE(mem.member_type, 'Member') AS Member_Type
    , mem.member_id As MemberCard_ID
    , mem.date_expired AS Membership_Expire
FROM customers AS cus
LEFT JOIN membership AS mem
    ON cus.customer_id = mem.customer_id
ORDER BY mem.member_type DESC;

------------------------------------------------------------------------------------------------

--Question2_Which dish has highest calories, ranking them from highest to lowest.

SELECT
	menu.menu_id AS Menu_ID
    , menu.menu_name AS Dish
    , ca.kcal 
FROM 
	menu
    , calories AS ca
WHERE menu.menu_id = ca.menu_id
ORDER BY ca.kcal DESC;

------------------------------------------------------------------------------------------------

--Question3_The Manager plans to make a promotion of the Set Menu. The manager wants to know all of the set menu, the dishes that are contained in each set, the calories of each set, and the sale price 10% off.

SELECT 
	sb.set_id AS Set_ID
    , sm.set_name AS Set_Name
    , GROUP_CONCAT(me.menu_name) aS Dishes
    , COUNT(me.menu_name) AS Quantity
    , SUM(ca.kcal) AS 'Total_kcal'
    , SUM(me.price) AS Price
    , SUM(me.price)-(SUM(me.price)*0.10) 
        AS 'Sales_10%_off'
FROM set_bridge AS sb
JOIN set_menu AS sm
    ON sm.set_id = sb.set_id
JOIN menu AS me
    ON me.menu_id = sb.menu_id
JOIN calories AS ca
    ON me.menu_id = ca.menu_id
GROUP BY sm.set_id;

------------------------------------------------------------------------------------------------

--Question4_The manager wants to know the top 5 menu sales from the opening time to lunch. (subquery)

SELECT
	inv.menu_id AS Menu_ID
	, m.menu_name AS Menu_Name
	, sum(inv.quantity) AS Sum_Quantity
    , sum(inv.quantity)*(m.price) AS Revenue
FROM 
	(SELECT * FROM invoice
	    WHERE STRFTIME('%H:%M:%S', invoice_date) 
        BETWEEN '07:00:00' AND '12:59:59') 
        AS inv
JOIN menu AS m
    ON m.menu_id = inv.menu_id
GROUP by inv.menu_id
ORDER BY Revenue DESC
Limit 5;

------------------------------------------------------------------------------------------------

--Question5_The manager wants to know the top 5 menu sales from the afternoon to closing time. (WITH clause)

WITH afternoon_inv AS (SELECT * FROM invoice
	WHERE STRFTIME('%H:%M:%S', invoice_date) 
    BETWEEN '13:00:00' AND '18:00:00')    
SELECT
	af_inv.menu_id AS Menu_ID
	, m.menu_name AS Menu_Name
	, sum(af_inv.quantity) AS Sum_Quantity
    , sum(af_inv.quantity)*(m.price) AS Revenue
FROM afternoon_inv AS af_inv
JOIN menu AS m
    ON m.menu_id = af_inv.menu_id
GROUP by af_inv.menu_id
ORDER BY Revenue desc
LIMIT 5;

------------------------------------------------------------------------------------------------