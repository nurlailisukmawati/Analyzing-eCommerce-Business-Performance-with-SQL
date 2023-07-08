--Create Table--

CREATE TABLE order_items_dataset (
order_id varchar,
	order_item_id int,
	product_id varchar,
	seller_id varchar,
	shipping_limit_date timestamp,
	price float8,
	freight_value float8
);


CREATE TABLE order_review_dataset (
review_id varchar,
	order_id varchar,
	review_score int,
	review_comment_title varchar,
	review_comment_message varchar,
	review_creation_date timestamp,
	review_answer_timestamp timestamp
);


CREATE TABLE sellers_dataset (
	seller_id varchar primary key,
	seller_zip_code_prefix int,
	seller_city varchar,
	seller_state varchar
);

CREATE TABLE customers_dataset (
	customer_id varchar primary key,
	customer_unique_id varchar,
	customer_zip_code_prefix int,
	customer_city varchar,
	customer_state varchar
);

CREATE TABLE order_items_dataset (
	order_id varchar,
	order_item_id int primary key,
	product_id varchar,
	seller_id varchar,
	shipping_limit_date timestamp,
	price float8,
	freight_value float8
);

CREATE TABLE order_payments_dataset (
	order_id varchar,
	payment_sequential int,
	payment_type varchar,
	payment_installments int,
	payment_value float8
);

CREATE TABLE order_review_dataset (
	review_id varchar primary key,
	order_id varchar,
	review_score int,
	review_comment_title varchar,
	review_comment_message varchar,
	review_creation_date timestamp,
	review_answer_timestamp timestamp
);

CREATE TABLE order_review_dataset (
	nomor int,
	product_id varchar primary key,
	product_category_name varchar,
	product_name_lenght float8,
	product_description_lenght float8,
	product_photos_qty float8,
	product_weight_g float8,
	product_length_cm float8,
	product_height_cm float8,
	product_width_cm float8
);