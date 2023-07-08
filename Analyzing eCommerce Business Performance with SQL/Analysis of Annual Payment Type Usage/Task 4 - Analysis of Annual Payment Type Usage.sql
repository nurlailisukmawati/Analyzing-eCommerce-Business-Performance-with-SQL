--jumlah penggunaan masing-masing tipe pembayaran secara all time diurutkan dari yang terfavorit--

SELECT payment_type, count(payment_type) AS Total
FROM order_payments_dataset
GROUP BY payment_type
ORDER BY 2 DESC;

--detail informasi jumlah penggunaan masing-masing tipe pembayaran untuk setiap tahun--

SELECT
	payment_type,
	SUM(CASE WHEN year = 2016 THEN total ELSE 0 END) AS "2016",
	SUM(CASE WHEN year = 2017 THEN total ELSE 0 END) AS "2017",
	SUM(CASE WHEN year = 2018 THEN total ELSE 0 END) AS "2018",
	SUM(total) AS sum_payment_type_usage
FROM (
	SELECT 
		date_part('year', od.order_purchase_timestamp) as year,
		opd.payment_type,
		COUNT(opd.payment_type) AS total
	FROM orders_dataset AS od
	JOIN order_payments_dataset AS opd 
		ON od.order_id = opd.order_id
	GROUP BY 1, 2
	) AS sub
GROUP BY 1
ORDER BY 2 DESC;

