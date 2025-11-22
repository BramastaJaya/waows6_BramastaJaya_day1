
create table role_user (
	RoleId int auto_increment primary key,
    RoleName varchar(10) not null,
    RoleDef varchar(255) not null
);

insert into role_user (RoleName, RoleDef) values ('admin', 'Administrator sistem');
insert into role_user (RoleName, RoleDef) values ('customer', 'Pengguna sistem');

CREATE TABLE users (
    UserId INT AUTO_INCREMENT PRIMARY KEY,
    Name varchar(255) not null,
    DateofBirth date,
	Gender ENUM('Male', 'Female', 'Prefer Not to Say') NOT NULL default 'Prefer Not to Say',
    Email VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    RoleId int not null default 2,
    Created_At datetime DEFAULT CURRENT_TIMESTAMP,
	foreign key (RoleId) references role_user(RoleId)
);

insert into users (Name, RoleId, Email, Password, Gender, DateofBirth) values ('Bramasta Jaya' , 1 , 'BramdAdmin@waows6.com', 'admin123', 'Male', '1964-12-12');
select * from users;
CREATE TABLE mall_customer (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  UserId int not null,
  Annual_Income int NOT NULL,
  Spending_Score INT NOT NULL default 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  foreign key (UserId) references users(UserId)
  );
insert into mall_customer (UserId, Annual_Income, Spending_Score) values (1, 89, 122);
insert into mall_customer (UserId, Annual_Income, Spending_Score) values (1, 50, 88);
select * from mall_customer;


CREATE TABLE product_categories (
  CategoryID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Description TEXT NULL
);

select * from product_categories;

insert into product_categories (Name, Description) values ("Elektronik", "Barang yang membutuhkan tenaga listrik untuk digunakan");
INSERT INTO product_categories (Name, Description) VALUES ('Clothing', 'Men and women fashion');
INSERT INTO product_categories (Name, Description) VALUES ('Groceries', 'Daily needs and fresh food');
INSERT INTO product_categories (Name, Description) VALUES ('Home', 'Furniture and home decor');
INSERT INTO product_categories (Name, Description) VALUES ('Beauty', 'Cosmetics and skincare products');


CREATE TABLE products (
  ProductID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryID INT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  Stock INT NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (CategoryID) REFERENCES product_categories(CategoryID)
);

select *  from products;
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


CREATE TABLE transactions (
  TransactionID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT NOT NULL,
  TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  TotalAmount DECIMAL(12,2) NOT NULL,
  PaymentMethod VARCHAR(50) NULL,
  FOREIGN KEY (CustomerID) REFERENCES mall_customer(CustomerID)
);
select * from transactions;
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (1, '2025-10-07 13:43:31', 51, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (1, '2025-10-07 13:43:31', 550, 'e-wallet');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (3, '2025-09-26 13:43:31', 60, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (1, '2025-10-29 13:43:31', 74, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (3, '2025-09-13 13:43:31', 32, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (3, '2025-10-20 13:43:31', 20, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (3, '2025-09-25 13:43:31', 66, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (1, '2025-10-05 13:43:31', 26, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (1, '2025-10-15 13:43:31', 77, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (1, '2025-11-05 13:43:31', 84, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (3, '2025-10-20 13:43:31', 80, 'cash');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (3, '2025-11-02 13:43:31', 44, 'credit');
INSERT INTO transactions (CustomerID, TransactionDate, TotalAmount, PaymentMethod) VALUES (3, '2025-10-05 13:43:31', 13, 'e-wallet');


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


select * from mall_customer;
select * from users;
      SELECT 
    c.CustomerID,
    u.Gender,
    TIMESTAMPDIFF(YEAR, u.DateofBirth, CURDATE()) AS Age,
    c.Annual_Income,
    COUNT(t.TransactionID) AS total_transactions,
    SUM(t.TotalAmount) AS total_spent
FROM mall_customer c
LEFT JOIN users u ON c.UserId = u.UserId
LEFT JOIN transactions t ON c.CustomerID = t.CustomerID
GROUP BY 
    c.CustomerID, 
    u.Gender, 
    u.DateofBirth,
    c.Annual_Income
ORDER BY total_spent DESC
LIMIT 10;


