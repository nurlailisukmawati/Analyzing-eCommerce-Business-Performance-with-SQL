--1. Tabel yang berisi informasi pendapatan/revenue perusahaan total untuk masing-masing tahun--

CREATE TABLE total_revenue AS 
	SELECT 
		date_part('year', od.order_purchase_timestamp) AS year,
		SUM(oid.price + oid.freight_value) AS revenue
	FROM order_items_dataset AS oid
	JOIN orders_dataset AS od
		ON oid.order_id = od.order_id
	WHERE od.order_status = 'delivered'
	GROUP BY 1
	ORDER BY 1;
	
	
--2.Tabel yang berisi informasi jumlah cancel order total untuk masing-masing tahun--

CREATE TABLE canceled_order_dataset AS
	SELECT
		date_part('year', od.order_purchase_timestamp) AS YEAR,
		COUNT(order_status) AS canceled_order_status
	FROM orders_dataset AS od
	WHERE order_status = 'canceled'
	GROUP BY 1
	ORDER BY 1;


--3. Tabel yang berisi nama kategori produk yang memberikan pendapatan total tertinggi untuk masing-masing tahun--

CREATE TABLE product_category_dataset AS
	SELECT 
		year,
		top_category,
		product_revenue
	FROM (
		SELECT
			date_part('year', shipping_limit_date) AS year,
			pd.product_category_name AS top_category,
			SUM(oid.price + oid.freight_value) AS product_revenue,
			RANK() OVER (PARTITION BY date_part('year', shipping_limit_date)
					 ORDER BY SUM(oid.price + oid.freight_value) DESC) AS ranking
		FROM orders_dataset AS od 
		JOIN order_items_dataset AS oid
			ON od.order_id = oid.order_id
		JOIN product_dataset AS pd
			ON oid.product_id = pd.product_id
		WHERE od.order_status like 'delivered'
		GROUP BY 1, 2
		ORDER BY 1
		) AS sub
	WHERE ranking = 1;
DELETE FROM product_category_dataset WHERE year = 2020;


--4.Tabel yang berisi nama kategori produk yang memiliki jumlah cancel order terbanyak untuk masing-masing tahun--

CREATE TABLE canceled_category_dataset AS
	SELECT 
		year,
		most_canceled,
		total_canceled
	FROM (
		SELECT
			date_part('year', shipping_limit_date) AS year,
			pd.product_category_name AS most_canceled,
			COUNT(od.order_id) AS total_canceled,
			RANK() OVER (PARTITION BY date_part('year', shipping_limit_date)
					 ORDER BY COUNT(od.order_id) DESC) AS ranking
		FROM orders_dataset AS od 
		JOIN order_items_dataset AS oid
			ON od.order_id = oid.order_id
		JOIN product_dataset AS pd
			ON oid.product_id = pd.product_id
		WHERE od.order_status like 'canceled'
		GROUP BY 1, 2
		ORDER BY 1
		) AS sub
	WHERE ranking = 1;
DELETE FROM canceled_category_dataset WHERE year = 2020;

--5. Master tabel--

SELECT
	tr.year,
	tr.revenue AS total_revenue,
	pcd.top_category AS top_product,
	pcd.product_revenue AS total_revenue_top_product,
	cod.canceled_order_status AS total_canceled,
	ccd.most_canceled AS top_canceled_product,
	ccd.total_canceled AS total_top_canceled_product
FROM total_revenue AS tr
JOIN product_category_dataset AS pcd
	ON tr.year = pcd.year
JOIN canceled_order_dataset AS cod
	ON pcd.year = cod.year
JOIN canceled_category_dataset AS ccd
	ON cod.year = ccd.year
GROUP BY 1,2,3,4,5,6,7;
	
