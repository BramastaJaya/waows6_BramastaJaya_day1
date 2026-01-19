<div align="center">

# 🛒 Simple E-Commerce Platform

[![Flask](https://img.shields.io/badge/Flask-2.3.0-green?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![JavaScript](https://img.shields.io/badge/JavaScript-ES6+-yellow?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active%20Development-brightgreen?style=flat-square" alt="Status">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square" alt="License">
  <img src="https://img.shields.io/badge/Version-1.0.0-orange?style=flat-square" alt="Version">
</p>

---

**Platform e-commerce modern dengan sistem Role-Based Access Control (RBAC)**  
**yang dibangun menggunakan arsitektur MVP dan RESTful API**

[🚀 Quick Start]
[📖 Dokumentasi]
[🏗️ Arsitektur]

</div>

---

## Deskripsi Website

Aplikasi web e-commerce yang mengimplementasikan sistem manajemen toko online berbasis **Role-Based Access Control (RBAC)** yang memisahkan hak akses antara Administrator dan Customer. Sistem website bekerja dengan mengambil bagian administrasi saja, melakukan pemantauan transaksi yang sedang atau telah dilakukan oleh customer, memonitoring produk dan data customer secara penuh. Website ini bekerja dengan memeriksa email yang diterima dari user dan melakukan autentikasi pada backend untuk memastikan identitas user sebagai administrasi sistem. 

### Highlights

- **Autentikasi & Otorisasi** - Sistem login dengan session management
- **Multi-Role System** - Akses yang terbagi menjadi Admin dan Customer 
- **Dashboard Analytics** - Statistik untuk monitoring bisnis
- **CRUD Operations** - Manajemen untuk Customers, Products, dan Transactions
- **Modern UI/UX** - Antarmuka UI menggunakan Bootstrap 5
- **Async Operations** - Komunikasi client-server menggunakan Fetch API

---

## FITUR WEBSITE

<table>
<tr>
<td width="60%">

### Admin Features
-  Dashboard dengan statistik lengkap
-  Manajemen data Customer (CRUD)
-  Manajemen data Product (CRUD)
-  Monitoring data Transaction

</td>
</tr>
</table>

---

## GAMBARAN ARSITEKTUR

```
┌───────────────────────────────────────────────────────────────── ┐
│                        CLIENT LAYER                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐               │
│  │    HTML     │  │     CSS     │  │ JavaScript  │               │
│  │  (Views)    │  │ (Bootstrap) │  │ (Fetch API) │               │
│  └──────┬──────┘  └─────────────┘  └──────┬──────┘               │
│         │                                  │                     │
│         └──────────────┬───────────────────┘                     │
│                        │ HTTP Request/Response                   │
└────────────────────────┼─────────────────────────────────────────┘
                         │
┌────────────────────────┼─────────────────────────────────────────┐
│                        ▼                                         │
│                  SERVER LAYER                                    │
│  ┌─────────────────────────────────────────────────────────┐     │
│  │                    Flask Application                    │     │
│  │  ┌───────────┐  ┌───────────┐  ┌───────────────────┐    │     │
│  │  │  Routes   │  │Blueprints │  │   Middleware      │    │     │
│  │  │ (API)     │  │ (Modules) │  │ (Auth/Validation) │    │     │
│  │  └─────┬─────┘  └─────┬─────┘  └─────────┬─────────┘    │     │
│  │        │              │                  │              │     │
│  │        └──────────────┼──────────────────┘              │     │
│  │                       │                                 │     │
│  └───────────────────────┼─────────────────────────────────┘     │
│                          │                                       │
└──────────────────────────┼───────────────────────────────────────┘
                           │
┌──────────────────────────┼───────────────────────────────────────┐
│                          ▼                                       │
│                   DATABASE LAYER                                 │
│  ┌─────────────────────────────────────────────────────────┐     │
│  │                      MySQL                              │     │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐    │     │
│  │  │  users   │ │ products │ │customers │ │transacti.│    │     │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘    │     │
│  └─────────────────────────────────────────────────────────┘     │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### Design Pattern: Model-View-Presenter

| Layer | Teknologi | Deskripsi |
|-------|-----------|-----------|
| **Model** | MySQL + Python | Business logic & data access |
| **View** | HTML + Bootstrap | User interface components |
| **Presenter** | Flask + JavaScript | Penghubung antara Model dan View |

---

## Quick Start

### Prerequisites

Pastikan sistem Anda sudah terinstall:

- ![Python](https://img.shields.io/badge/Python-3.8+-blue?logo=python&logoColor=white) Python 3.8 atau lebih tinggi
- ![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql&logoColor=white) MySQL Server 8.0
- ![Git](https://img.shields.io/badge/Git-latest-red?logo=git&logoColor=white) Git (ini opsional)

### How to Install on Windows:

**1️ Clone Repository**

```bash
git clone https://github.com/BramastaJaya/waows6-BramastaJaya-day1.git
cd waows6-BramastaJaya-day1
```

**2 Buat Virtual Environment**

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

**3️ Install Dependencies**

```bash
pip install -r requirements.txt
```

**4️ Setup Database**

```bash
# Login ke MySQL
mysql -u root -p

# Buat database
CREATE DATABASE shop;
USE shop;

# Import schema
source MyShop.sql;
```

**5️ Konfigurasi Environment**

Buat file `config/database.py` atau sesuaikan konfigurasi dengan localhost dan root masing-masing:

```python
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'YourPassword',
    'database': 'shopDB'
}
```

**6️ Jalankan Aplikasi**

```bash
py app.py 
```
```or 
python app.py
```

**7️ Akses Aplikasi**

```
🌐 DEFAULT: http://127.0.0.1:5000
```

---

## Dokumentasi API

### Authentication Endpoints

<details>
<summary><code>POST</code> <code>/api/auth/register</code> - Registrasi User Baru</summary>

#### Request Body (inspect in Postman)

```json
{
    "Name": "Bramasta Jaya",
    "Email": "Bramasta@waows6.com",
    "Password": "customer123",
    "Gender": "Male",
    "DateofBirth": "2025-05-15"
}
```

#### Response

```json
{
    "success": true,
    "message": "User registered successfully",
    "user_id": 1
}
```

</details>

<details>
<summary><code>POST</code> <code>/api/auth/login</code> - Login User</summary>

#### Request Body

```json
{
    "Email": "Bramsta@waows6.com",
    "Password": "customer123"
}
```

#### Response (Success)

```json
{
    "success": true,
    "UserId": 1,
    "Name": "Bramasta Jaya",
    "Email": "Bramasta@waows6.com",
    "RoleId": 2
}
```

</details>

---

### Customer Endpoints

| Method | Endpoint | Deskripsi | Auth |
|--------|----------|-----------|------|
| `GET` | `/api/admin/customers/` | Ambil semua customer |  Admin |
| `GET` | `/api/admin/customers/:id` | Ambil customer by ID |  Admin |
| `POST` | `/api/admin/customers/` | Tambah customer baru |  Admin |
| `PUT` | `/api/admin/customers/:id` | Update customer |  Admin |
| `DELETE` | `/api/admin/customers/:id` | Hapus customer |  Admin |
| `GET` | `/api/admin/customers/stats` | Statistik customer |  Admin |

<details>
<summary><code>GET</code> <code>/api/admin/customers/</code> - Get All Customers</summary>

#### Response

```json
{
    "success": true,
    "data": [
        {
            "CustomerID": 1,
            "Name": "John Doe",
            "Gender": "Male",
            "Age": 28,
            "Annual_Income": 75,
            "Spending_Score": 85,
            "created_at": "2025-01-15T10:30:00"
        }
    ],
    "total": 1
}
```

</details>

<details>
<summary><code>POST</code> <code>/api/admin/customers/</code> - Create Customer</summary>

#### Request Body

```json
{
    "Name": "Jane Smith",
    "Email": "Jane@waows6.com",
    "Password": "password123",
    "Gender": "Female",
    "DateofBirth": "2005-03-20",
    "RoleId": 2,
    "Annual_Income": 65,
    "Spending_Score": 72
}
```

#### Response

```json
{
    "success": true,
    "message": "Customer created successfully",
    "user_id": 2,
    "customer_id": 2
}
```

</details>

<details>
<summary><code>PUT</code> <code>/api/admin/customers/:id</code> - Update Customer</summary>

#### Request Body

```json
{
    "Name": "Jane Doe",
    "Gender": "Female",
    "RoleId": 2,
    "DateofBirth": "1998-03-20",
    "Annual_Income": 70,
    "Spending_Score": 80
}
```

#### Response

```json
{
    "success": true,
    "message": "Customer updated successfully"
}
```

</details>

---

### Product Endpoints

| Method | Endpoint | Deskripsi | Auth |
|--------|----------|-----------|------|
| `GET` | `/api/admin/products/` | Ambil semua produk |  Admin |
| `GET` | `/api/admin/products/:id` | Ambil produk by ID |  Admin |
| `POST` | `/api/admin/products/` | Tambah produk baru |  Admin |
| `PUT` | `/api/admin/products/:id` | Update produk |  Admin |
| `DELETE` | `/api/admin/products/:id` | Hapus produk |  Admin |

---

### Transaction Endpoints

| Method | Endpoint | Deskripsi | Auth |
|--------|----------|-----------|------|
| `GET` | `/api/admin/transactions/` | Ambil semua transaksi |  Admin |
| `GET` | `/api/admin/transactions/:id` | Detail transaksi |  Admin |

---

## REVIEW DATABASE MYSQL SCHEMA 

```View:
┌─────────────────┐       ┌─────────────────┐
│    role_user    │       │      users      │
├─────────────────┤       ├─────────────────┤
│ RoleId (PK)     │◄──────│ UserId (PK)     │
│ RoleName        │       │ Name            │
│ RoleDef         │       │ Email           │
└─────────────────┘       │ Password        │
                          │ Gender          │
                          │ DateofBirth     │
                          │ RoleId (FK)     │
                          └────────┬────────┘
                                   │
                                   ▼
                          ┌─────────────────┐
                          │  mall_customer  │
                          ├─────────────────┤
                          │ CustomerID (PK) │
                          │ UserId (FK)     │
                          │ Annual_Income   │
                          │ Spending_Score  │
                          └────────┬────────┘
                                   │
                                   ┼───────────────────────────┐
                                   │                           │
                                   ▼                           ▼
┌──────────────┐          ┌─────────────────┐         ┌───────────────────┐
│  products    │          │  transactions   │         │transaction_details│
├──────────────┤          ├─────────────────┤         ├───────────────────┤
│ ProductID    │◄─────────│ TransactionID   │◄────────│ DetailID          │
│ CategoryID   │          │ CustomerID (FK) │         │ TransactionID(FK) │
│ Name         │          │ TransactionDate │         │ ProductID (FK)    │
│ Price        │          │ TotalAmount     │         │ Quantity          │
│ Stock        │          │ PaymentMethod   │         │ UnitPrice         │
└──────────────┘          └─────────────────┘         │ Subtotal          │
       |                                              └───────────────────┘
       |  
┌──────────────┐         
│Category Pro..│         
├──────────────┤         
│ CategoryID   │
│     Name     │
│ Description  |    
└──────────────┘

```
