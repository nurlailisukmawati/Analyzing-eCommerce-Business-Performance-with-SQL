--1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk setiap tahun--

SELECT year, FLOOR(AVG(total_customer)) as avg_monthly_active_user
FROM (
		SELECT
			date_part('year', od.order_purchase_timestamp) AS year,
			date_part('month', od.order_purchase_timestamp) AS month,
			COUNT(DISTINCT cd.customer_unique_id) AS total_customer
		FROM orders_dataset AS od
		JOIN customers_dataset AS cd
			ON cd.customer_id = od.customer_id
		GROUP BY 1, 2
) tmp
GROUP BY 1
ORDER BY 1
;


--2. Menampilkan jumlah customer baru pada masing-masing tahun--

SELECT year, COUNT(customer_unique_id) AS total_new_customer
FROM (
	SELECT 
		MIN(date_part('year', od.order_purchase_timestamp)) AS year,
		cd.customer_unique_id
	FROM orders_dataset AS od
	JOIN customers_dataset AS cd
		ON od.customer_id = cd.customer_id
	GROUP BY 2
) tmp
GROUP BY 1
ORDER BY 1;


--3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat order) pada masing-masing tahun--

SELECT year, COUNT(customer_unique_id) AS total_repeat_customer
FROM (
	SELECT 
		date_part('year', od. order_purchase_timestamp) AS year,
		cd.customer_unique_id,
		COUNT(od.order_id) AS total_customer_order
	FROM orders_dataset AS od
	JOIN customers_dataset AS cd
		ON od.customer_id = cd.customer_id
	GROUP BY 1,2
	HAVING COUNT(2) > 1
) tmp
GROUP BY 1
ORDER BY 1;


--4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing tahun--

SELECT year, ROUND(AVG(frequency_order),3) AS avg_frequency_order
FROM (
		SELECT
			date_part('year', od.order_purchase_timestamp) AS year,
			cd.customer_unique_id,
			COUNT(od.order_id) AS frequency_order
		FROM orders_dataset AS od
		JOIN customers_dataset AS cd
			ON cd.customer_id = od.customer_id
		GROUP BY 1,2	
) tmp
GROUP BY 1
ORDER BY 1;


--5. Menggabungkan keempat metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel--

with cte_monthly AS (
SELECT year, FLOOR(AVG(total_customer)) AS avg_monthly_active_user
FROM (
		SELECT
			date_part('year', od.order_purchase_timestamp) AS year,
			date_part('month', od.order_purchase_timestamp) AS month,
			COUNT(DISTINCT cd.customer_unique_id) AS total_customer
		FROM orders_dataset AS od
		JOIN customers_dataset AS cd
			ON cd.customer_id = od.customer_id
		GROUP BY 1, 2
) tmp
GROUP BY 1
),
cte_new_cst AS (
SELECT year, COUNT(customer_unique_id) AS total_new_customer
FROM (
	SELECT 
		MIN(date_part('year', od.order_purchase_timestamp)) AS year,
		cd.customer_unique_id
	FROM orders_dataset AS od
	JOIN customers_dataset AS cd
		ON od.customer_id = cd.customer_id
	GROUP BY 2
) tmp
GROUP BY 1
),
cte_repeat_or AS (
SELECT year, COUNT(customer_unique_id) AS total_repeat_customer
FROM (
	SELECT 
		date_part('year', od. order_purchase_timestamp) AS year,
		cd.customer_unique_id,
		COUNT(od.order_id) AS total_customer_order
	FROM orders_dataset AS od
	JOIN customers_dataset AS cd
		ON od.customer_id = cd.customer_id
	GROUP BY 1,2
	HAVING COUNT(2) > 1
) tmp
GROUP BY 1
),
cte_mean_order AS (
SELECT year, ROUND(AVG(frequency_order),3) AS avg_frequency_order
FROM (
		SELECT
			date_part('year', od.order_purchase_timestamp) AS year,
			cd.customer_unique_id,
			COUNT(od.order_id) AS frequency_order
		FROM orders_dataset AS od
		JOIN customers_dataset AS cd
			ON cd.customer_id = od.customer_id
		GROUP BY 1,2	
) tmp
GROUP BY 1
)
SELECT
	monthly.year AS year,
	avg_monthly_active_user,
	total_new_customer,
	total_repeat_customer,
	avg_frequency_order
FROM
	cte_monthly AS monthly
	JOIN cte_new_cst AS ncs
		ON monthly.year = ncs.year
	JOIN cte_repeat_or AS cro
		ON ncs.year = cro.year
	JOIN cte_mean_order AS freq
		ON cro.year = freq.year
GROUP BY 1, 2, 3, 4, 5
ORDER BY 1;