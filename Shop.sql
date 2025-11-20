
-- SCHEMA DEFINITION FOR MALL CUSTOMER TRANSACTION SYSTEM

CREATE TABLE mall_customer (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  Gender VARCHAR(10) NOT NULL,
  Age INT NOT NULL,
  Annual_Income INT NOT NULL,
  Spending_Score INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_categories (
  CategoryID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Description TEXT NULL
);

CREATE TABLE products (
  ProductID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryID INT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  Stock INT NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (CategoryID) REFERENCES product_categories(CategoryID)
);

CREATE TABLE transactions (
  TransactionID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT NOT NULL,
  TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  TotalAmount DECIMAL(12,2) NOT NULL,
  PaymentMethod VARCHAR(50) NULL,
  FOREIGN KEY (CustomerID) REFERENCES mall_customer(CustomerID)
);

CREATE TABLE transaction_details (
  DetailID INT AUTO_INCREMENT PRIMARY KEY,
  TransactionID INT NOT NULL,
  ProductID INT NOT NULL,
  Quantity INT NOT NULL DEFAULT 1,
  UnitPrice DECIMAL(10,2) NOT NULL,
  Subtotal DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (TransactionID) REFERENCES transactions(TransactionID),
  FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);


-- INSERT DATA INTO TABLES

-- mall_customer
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 19, 15, 39);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 21, 15, 81);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 20, 16, 6);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 23, 16, 77);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 31, 17, 40);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 22, 17, 76);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 35, 18, 6);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 23, 18, 94);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 64, 19, 3);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 30, 19, 72);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 67, 19, 14);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 35, 19, 99);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 58, 20, 15);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 24, 20, 77);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 37, 20, 13);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 22, 20, 79);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 35, 21, 35);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 20, 21, 66);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 52, 23, 29);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 35, 23, 98);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 35, 24, 35);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 25, 24, 73);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 46, 25, 5);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 31, 25, 73);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 54, 28, 14);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 29, 28, 82);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 45, 28, 32);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 35, 28, 61);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 40, 29, 31);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 23, 29, 87);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 60, 30, 4);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 21, 30, 73);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 53, 33, 4);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 18, 33, 92);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 49, 33, 14);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 21, 33, 81);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 42, 34, 17);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 30, 34, 73);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 36, 37, 26);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 20, 37, 75);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 65, 38, 35);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 24, 38, 92);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 48, 39, 36);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 31, 39, 61);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 49, 39, 28);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 24, 39, 65);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 50, 40, 55);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 27, 40, 47);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 29, 40, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 31, 40, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 49, 42, 52);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 33, 42, 60);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 31, 43, 54);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 59, 43, 60);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 50, 43, 45);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 47, 43, 41);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 51, 44, 50);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 69, 44, 46);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 27, 46, 51);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 53, 46, 46);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 70, 46, 56);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 19, 46, 55);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 67, 47, 52);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 54, 47, 59);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 63, 48, 51);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 18, 48, 59);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 43, 48, 50);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 68, 48, 48);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 19, 48, 59);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 32, 48, 47);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 70, 49, 55);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 47, 49, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 60, 50, 49);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 60, 50, 56);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 59, 54, 47);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 26, 54, 54);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 45, 54, 53);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 40, 54, 48);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 23, 54, 52);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 49, 54, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 57, 54, 51);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 38, 54, 55);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 67, 54, 41);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 46, 54, 44);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 21, 54, 57);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 48, 54, 46);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 55, 57, 58);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 22, 57, 55);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 34, 58, 60);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 50, 58, 46);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 68, 59, 55);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 18, 59, 41);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 48, 60, 49);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 40, 60, 40);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 32, 60, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 24, 60, 52);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 47, 60, 47);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 27, 60, 50);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 48, 61, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 20, 61, 49);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 23, 62, 41);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 49, 62, 48);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 67, 62, 59);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 26, 62, 55);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 49, 62, 56);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 21, 62, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 66, 63, 50);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 54, 63, 46);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 68, 63, 43);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 66, 63, 48);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 65, 63, 52);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 19, 63, 54);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 38, 64, 42);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 19, 64, 46);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 18, 65, 48);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 19, 65, 50);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 63, 65, 43);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 49, 65, 59);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 51, 67, 43);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 50, 67, 57);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 27, 67, 56);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 38, 67, 40);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 40, 69, 58);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 39, 69, 91);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 23, 70, 29);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 31, 70, 77);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 43, 71, 35);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 40, 71, 95);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 59, 71, 11);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 38, 71, 75);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 47, 71, 9);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 39, 71, 75);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 25, 72, 34);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 31, 72, 71);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 20, 73, 5);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 29, 73, 88);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 44, 73, 7);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 32, 73, 73);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 19, 74, 10);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 35, 74, 72);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 57, 75, 5);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 32, 75, 93);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 28, 76, 40);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 32, 76, 87);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 25, 77, 12);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 28, 77, 97);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 48, 77, 36);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 32, 77, 74);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 34, 78, 22);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 34, 78, 90);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 43, 78, 17);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 39, 78, 88);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 44, 78, 20);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 38, 78, 76);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 47, 78, 16);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 27, 78, 89);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 37, 78, 1);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 30, 78, 78);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 34, 78, 1);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 30, 78, 73);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 56, 79, 35);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 29, 79, 83);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 19, 81, 5);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 31, 81, 93);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 50, 85, 26);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 36, 85, 75);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 42, 86, 20);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 33, 86, 95);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 36, 87, 27);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 32, 87, 63);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 40, 87, 13);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 28, 87, 75);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 36, 87, 10);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 36, 87, 92);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 52, 88, 13);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 30, 88, 86);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 58, 88, 15);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 27, 88, 69);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 59, 93, 14);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 35, 93, 90);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 37, 97, 32);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 32, 97, 86);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 46, 98, 15);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 29, 98, 88);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 41, 99, 39);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 30, 99, 97);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 54, 101, 24);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 28, 101, 68);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 41, 103, 17);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 36, 103, 85);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 34, 103, 23);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 32, 103, 69);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 33, 113, 8);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 38, 113, 91);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 47, 120, 16);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 35, 120, 79);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Female', 45, 126, 28);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 32, 126, 74);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 32, 137, 18);
INSERT INTO mall_customer (Gender, Age, Annual_Income, Spending_Score) VALUES ('Male', 30, 137, 83);

-- product_categories
INSERT INTO product_categories (Name, Description) VALUES ('Electronics', 'Electronic gadgets and devices');
INSERT INTO product_categories (Name, Description) VALUES ('Clothing', 'Men and women fashion');
INSERT INTO product_categories (Name, Description) VALUES ('Groceries', 'Daily needs and fresh food');
INSERT INTO product_categories (Name, Description) VALUES ('Home', 'Furniture and home decor');
INSERT INTO product_categories (Name, Description) VALUES ('Beauty', 'Cosmetics and skincare products');

-- products
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (1, 'Smartphone', 750.0, 67);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (1, 'Laptop', 1200.0, 37);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (2, 'T-shirt', 25.0, 16);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (2, 'Jeans', 40.0, 52);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (3, 'Milk', 2.5, 34);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (3, 'Bread', 1.2, 91);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (4, 'Sofa', 550.0, 95);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (4, 'Lamp', 45.0, 71);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (5, 'Lipstick', 15.0, 36);
INSERT INTO products (CategoryID, Name, Price, Stock) VALUES (5, 'Perfume', 60.0, 45);

-- transactions
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (111, '2025-10-07 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (130, '2025-10-07 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (78, '2025-09-26 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (58, '2025-10-29 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (34, '2025-09-13 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (2, '2025-10-20 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (79, '2025-09-25 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (178, '2025-10-05 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (64, '2025-10-15 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (170, '2025-11-05 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (64, '2025-10-20 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (165, '2025-11-02 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (116, '2025-10-05 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (60, '2025-09-23 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (134, '2025-10-08 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (62, '2025-09-29 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (86, '2025-10-04 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (101, '2025-09-13 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (23, '2025-10-10 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (93, '2025-09-17 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (19, '2025-11-06 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (110, '2025-10-06 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (17, '2025-10-12 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (55, '2025-09-28 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (21, '2025-10-24 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (124, '2025-10-31 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (185, '2025-11-01 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (25, '2025-11-02 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (75, '2025-10-02 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (159, '2025-10-17 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (11, '2025-11-08 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (183, '2025-09-26 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (23, '2025-10-01 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (175, '2025-10-02 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (73, '2025-10-17 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (65, '2025-10-25 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (82, '2025-09-24 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (125, '2025-10-27 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (173, '2025-11-12 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (111, '2025-09-14 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (163, '2025-10-16 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (173, '2025-10-14 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (91, '2025-11-08 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (8, '2025-10-30 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (165, '2025-10-16 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (130, '2025-10-10 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (133, '2025-10-12 13:43:31', 0, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (106, '2025-10-26 13:43:31', 0, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (19, '2025-10-21 13:43:31', 0, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (77, '2025-10-15 13:43:31', 0, 'cash');

-- transaction_details
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (1, 6, 1, 1.2, 1.2);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (1, 1, 3, 750.0, 2250.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (1, 9, 1, 15.0, 15.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (2, 3, 3, 25.0, 75.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (2, 4, 3, 40.0, 120.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (3, 5, 2, 2.5, 5.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (3, 3, 3, 25.0, 75.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (3, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (4, 5, 3, 2.5, 7.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (4, 2, 1, 1200.0, 1200.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (4, 3, 3, 25.0, 75.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (4, 5, 2, 2.5, 5.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (5, 5, 2, 2.5, 5.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (5, 6, 2, 1.2, 2.4);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (6, 6, 1, 1.2, 1.2);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (6, 7, 2, 550.0, 1100.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (6, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (7, 6, 2, 1.2, 2.4);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (7, 9, 2, 15.0, 30.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (7, 10, 1, 60.0, 60.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (7, 3, 3, 25.0, 75.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (8, 6, 1, 1.2, 1.2);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (8, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (9, 5, 3, 2.5, 7.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (9, 2, 3, 1200.0, 3600.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (9, 9, 1, 15.0, 15.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (10, 3, 2, 25.0, 50.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (10, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (10, 8, 3, 45.0, 135.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (10, 2, 1, 1200.0, 1200.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (11, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (12, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (12, 4, 3, 40.0, 120.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (12, 8, 3, 45.0, 135.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (13, 8, 2, 45.0, 90.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (13, 8, 1, 45.0, 45.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (14, 9, 3, 15.0, 45.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (14, 7, 2, 550.0, 1100.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (15, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (15, 6, 2, 1.2, 2.4);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (16, 6, 1, 1.2, 1.2);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (17, 8, 3, 45.0, 135.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (17, 5, 3, 2.5, 7.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (18, 9, 2, 15.0, 30.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (18, 4, 2, 40.0, 80.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (19, 8, 3, 45.0, 135.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (19, 4, 3, 40.0, 120.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (19, 10, 3, 60.0, 180.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (19, 9, 3, 15.0, 45.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (20, 6, 1, 1.2, 1.2);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (20, 2, 3, 1200.0, 3600.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (21, 3, 2, 25.0, 50.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (21, 5, 2, 2.5, 5.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (21, 7, 2, 550.0, 1100.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (22, 10, 1, 60.0, 60.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (22, 6, 3, 1.2, 3.5999999999999996);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (22, 10, 3, 60.0, 180.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (23, 2, 2, 1200.0, 2400.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (23, 5, 3, 2.5, 7.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (23, 5, 1, 2.5, 2.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (23, 6, 1, 1.2, 1.2);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (24, 3, 2, 25.0, 50.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (24, 5, 2, 2.5, 5.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (24, 4, 2, 40.0, 80.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (24, 9, 2, 15.0, 30.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (25, 1, 3, 750.0, 2250.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (25, 9, 1, 15.0, 15.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (25, 7, 2, 550.0, 1100.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (26, 9, 1, 15.0, 15.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (27, 8, 1, 45.0, 45.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (28, 8, 2, 45.0, 90.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (29, 2, 2, 1200.0, 2400.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (29, 10, 1, 60.0, 60.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (29, 5, 1, 2.5, 2.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (29, 2, 1, 1200.0, 1200.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (30, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (30, 1, 1, 750.0, 750.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (30, 1, 1, 750.0, 750.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (31, 4, 2, 40.0, 80.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (32, 2, 3, 1200.0, 3600.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (32, 3, 2, 25.0, 50.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (32, 8, 1, 45.0, 45.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (33, 2, 1, 1200.0, 1200.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (33, 7, 3, 550.0, 1650.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (33, 2, 3, 1200.0, 3600.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (34, 7, 1, 550.0, 550.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (34, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (35, 6, 2, 1.2, 2.4);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (36, 9, 2, 15.0, 30.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (36, 2, 2, 1200.0, 2400.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (36, 6, 3, 1.2, 3.5999999999999996);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (37, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (38, 4, 2, 40.0, 80.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (38, 2, 3, 1200.0, 3600.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (38, 4, 2, 40.0, 80.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (38, 8, 1, 45.0, 45.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (39, 5, 3, 2.5, 7.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (39, 3, 1, 25.0, 25.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (40, 7, 3, 550.0, 1650.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (40, 2, 3, 1200.0, 3600.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (40, 6, 2, 1.2, 2.4);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (40, 7, 2, 550.0, 1100.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (41, 5, 3, 2.5, 7.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (41, 5, 1, 2.5, 2.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (41, 1, 1, 750.0, 750.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (42, 5, 3, 2.5, 7.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (42, 3, 3, 25.0, 75.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (43, 5, 2, 2.5, 5.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (44, 6, 2, 1.2, 2.4);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (44, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (44, 6, 2, 1.2, 2.4);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (44, 7, 3, 550.0, 1650.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (45, 3, 1, 25.0, 25.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (45, 3, 3, 25.0, 75.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (45, 2, 3, 1200.0, 3600.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (45, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (46, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (46, 3, 1, 25.0, 25.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (46, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (47, 9, 2, 15.0, 30.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (47, 8, 3, 45.0, 135.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (47, 3, 3, 25.0, 75.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (48, 9, 1, 15.0, 15.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (48, 8, 2, 45.0, 90.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (48, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (48, 10, 2, 60.0, 120.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (49, 5, 1, 2.5, 2.5);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (49, 4, 3, 40.0, 120.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (49, 6, 1, 1.2, 1.2);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (50, 4, 1, 40.0, 40.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (50, 1, 2, 750.0, 1500.0);
INSERT INTO transaction_details (TransactionID, ProductID, Quantity, UnitPrice, Subtotal) VALUES (50, 8, 2, 45.0, 90.0);
