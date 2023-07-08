
# Analyzing eCommerce Business Performance with SQL

Analyzing eCommerce Business Performance with SQL merupakan salah satu project yang harus dikerjakan oleh student di Rakamin Academy untuk melatih kemampuan student untuk menjadi seorang data analyst atau data scientist. Project yang dikerjakan terdiri dari 4 pertanyaan bisnis dan terdiri dari 4 - 5 sub pertanyaan bisnis.

Adapun informasi singkat terkait dengan tools dari project ini:
1. Tools : PostgreSQL
2. Data Visualization : Tableau

## Background
Seorang data analyst yang dibrikan tanggung jawab untuk menganalisis 3 aspek yang berkaitan dengan performa bisnis dari salah satu marketplace eCommerse terbesar di Amerika Selatan. Adapun tiga aspek tersebut adalah kualitas produk, pertumbuhan pelanggan dan tipe pembayaran. Berdasaran 3 metrik tersebut diharapkan tim data analyst bisa menemukan menganalisis dan menemukan insight untuk menunjang performa bisnis tersebut.

#### Objective:
1. Annual Customer Activity Growth Analysis
2. Annual Product Category Quality Analysis
3. Annual Payment Type Usage Analysis
## Task 1 - Data Preparation
Dataset yang digunakan adalah dataset sebuah perusahaan eCommerce Brasil dengan jumlah data 99441 dari tahun 2016 hingga 2018. Dataset ini juga terdiri dari beberapa table yaitu 
1. customers_dataset
2. golocation_dataset
3. order_items_dataset
4. order_payments_dataset
5. order_reviews_dataset
6. order_items_dataset
7. product_dataset
8. sellers_dataset

#### Create Database, Create Table, Import File dan ERD 
Adapun langkah -langkahnya yaitu:

#### Create Database:

1. Membuka PostgreSQL
2. Klik kanan pada Database
3. pilih create database
4. Masukan nama database yang diinginkan pada tab general
5. klik save

#### Create Table

1. Klik kanan pada table, lalu pilih Query Tool
2. Membuat table menggunakan Create Table statement
3. Masukan nama kolom dan tipe data untuk masing-masing kolom serta menentukan primary key
4. Jalankan Query
5. Klik kanan pada table, lalu klik refresh

#### Import File CSV

1. Klik kanan pada table yang sudah dibuat
2. Pilih import/Export
3. Pilih import
4. Pilih file yang sudah ada di local komputer
5. Pilih headers = Yes (jika baris pertama merupakan nama kolom)
6. Pilih delimiter yang sesuai dengan file
7. Klik ok

#### ERD

1. Klik kanan pada database yang ingin dibuatkan ERD
2. Klik Generate ERD
3. Klik table yang diinginkan dan pilih hubungan one to many atau Many to Many, serta menentukan foreign key pada table.
4. Klik save
## Task 2 - Annual Customers Activity Growth Analyst
Menganalisis beberapa metrik yang berhubungan dengan aktivitas customer
seperti jumlah customer aktif, jumlah customer baru, jumlah customer yang melakukan repeat
order dan juga rata-rata transaksi yang dilakukan customer setiap tahun.

Adapun langkah-langkahnya yaitu:


1. Menampilkan rata-rata jumlah customer aktif bulanan (monthly active user) untuk
setiap tahun

2. Menampilkan jumlah customer baru pada masing-masing tahun

3. Menampilkan jumlah customer yang melakukan pembelian lebih dari satu kali (repeat
order) pada masing-masing tahun

4. Menampilkan rata-rata jumlah order yang dilakukan customer untuk masing-masing
tahun

5. Menggabungkan keempat metrik yang telah berhasil ditampilkan menjadi satu tampilan
tabel

## Task 3 - Annual Product Category Quality Analysis
Melihat dan menganalisis kategori-kategori produk yang memberikan dampak positif (dilihat
dari metrik pendapatan/revenue) dan juga kategori produk yang memberikan dampak negatif
(dilihat dari metrik jumlah cancel order) bagi perusahaan setiap tahunnya.

Adapun langkah-langkahnya yaitu:

1. Membuat tabel yang berisi informasi pendapatan/revenue perusahaan total untuk
masing-masing tahun

2. Membuat tabel yang berisi informasi jumlah cancel order total untuk masing-masing
tahun

3. Membuat tabel yang berisi nama kategori produk yang memberikan pendapatan total
tertinggi untuk masing-masing tahun

4. Membuat tabel yang berisi nama kategori produk yang memiliki jumlah cancel order
terbanyak untuk masing-masing tahun

5. Menggabungkan informasi-informasi yang telah didapatkan ke dalam satu tampilan
tabel

## Task 4 - Analysis of Annual Payment Type Usage
Melihat dan menganalisis tipe pembayaran yang menjadi favorit customer secara all time dan
juga menganalisis perubahan tren yang terjadi dari tahun ke tahun untuk masing-masing tipe
pembayaran yang ada.

Adapun langkah-langkahnya yaitu:

1. Menampilkan jumlah penggunaan masing-masing tipe pembayaran secara all time
diurutkan dari yang terfavorit

2. Menampilkan detail informasi jumlah penggunaan masing-masing tipe pembayaran
untuk setiap tahun

