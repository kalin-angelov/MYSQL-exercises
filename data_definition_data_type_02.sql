-- 0 Create Database

CREATE DATABASE minions;

-- 1 Create Tables
CREATE TABLE minions (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

CREATE TABLE towns (
	town_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

-- 2 Alter Minions Table
ALTER TABLE towns
CHANGE COLUMN town_id id INT AUTO_INCREMENT;

ALTER TABLE minions
ADD COLUMN town_id INT;

ALTER TABLE minions
ADD CONSTRAINT town_id FOREIGN KEY (town_id) REFERENCES towns(id);

-- 3 Insert Records in Both Tables

INSERT INTO towns 
VALUES(1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');

INSERT INTO minions
VALUES (1, 'Kevin', 22, 1), (2, 'Bob', 15, 3), (3, 'Steward', null, 2);

-- 4 Truncate Table Minions

TRUNCATE TABLE minions;

-- 5 Drop All Tables

DROP TABLE minions, towns;
DROP DATABASE minions;

-- 6 Create Table People

CREATE DATABASE demo;
use demo;

CREATE TABLE people (
	id BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(200) NOT NULL,
    picture BLOB NULL,
    height DECIMAL(5,2) NULL,
    weight DECIMAL(5,2) NULL,
    gender ENUM('m', 'f') NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT NULL
);

INSERT INTO people
VALUES (1, 'person 1', null, 121.11, 88.01, 'f', '1995-01-01', 'some text'),
(2, 'person 2', null, 122.22, 88.02, 'f', '1995-02-02', 'some text'),
(3, 'person 3', null, 123.33, 88.03, 'f', '1995-03-03', 'some text'),
(4, 'person 4', null, 124.44, 88.04, 'f', '1995-04-04', 'some text'),
(5, 'person 5', null, 125.55, 88.05, 'f', '1995-05-05', 'some text');

-- 7 Create Table Users

CREATE TABLE users (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    username VARCHAR(30) CHARACTER SET ASCII UNIQUE NOT NULL,
    password VARCHAR(26) CHARACTER SET ASCII NOT NULL,
    profile_picture BLOB NULL,
    last_login_time DATETIME NULL,
    is_deleted BOOLEAN
);

INSERT INTO users 
VALUES (1, 'username_1', 'pass', null, '2026-01-10 15:30:00', true),
(2, 'username_2', 'pass', null, '2026-01-10 15:30:00', false),
(3, 'username_3', 'pass', null, '2026-01-10 15:30:00', true),
(4, 'username_4', 'pass', null, '2026-01-10 15:30:00', false),
(5, 'username_5', 'pass', null, '2026-01-10 15:30:00', true);

-- 8 Change Primary Key

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id, username);

-- 9 Set Default Value of a Field
ALTER TABLE users
MODIFY COLUMN last_login_time DATETIME DEFAULT CURRENT_TIMESTAMP;

-- 10 Set Unique Field

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id),
ADD CONSTRAINT uq_username UNIQUE (username);

-- 11 Movies Database

CREATE DATABASE movies;

CREATE TABLE directors (
	id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(50) NOT NULL,
    notes TEXT NULL
);

CREATE TABLE genres (
	id INT PRIMARY KEY AUTO_INCREMENT,
    genre VARCHAR(50) NOT NULL,
    notes TEXT NULL
);

CREATE TABLE categories (
	id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    notes TEXT NULL
);

CREATE TABLE movies (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT,
    copyright_year YEAR NOT NULL,
    length SMALLINT NOT NULL,
    genre_id INT,
	category_id INT,
    rating DECIMAL(3,2) NULL,
    notes TEXT NULL
);

INSERT INTO directors
VALUES (1, 'director_1', NULL),
	(2, 'director_2', NULL),
	(3, 'director_3', NULL),
	(4, 'director_4', NULL),
	(5, 'director_5', NULL);

INSERT INTO genres
VALUES (1, 'genre_1', NULL),
	(2, 'genre_2', NULL),
	(3, 'genre_3', NULL),
	(4, 'genre_4', NULL),
	(5, 'genre_5', NULL);
    
INSERT INTO categories 
VALUES (1, 'category_1', NULL),
	(2, 'category_2', NULL),
	(3, 'category_3', NULL),
	(4, 'category_4', NULL),
	(5, 'category_5', NULL);
    
INSERT INTO movies
VALUES (1, 'title_1', 1, 2026, 110, 1, 1, NULL, NULL),
	(2, 'title_2', 2, 2026, 120, 2, 2, NULL, NULL),
	(3, 'title_3', 3, 2026, 130, 3, 3, NULL, NULL),
	(4, 'title_4', 4, 2026, 140, 4, 4, NULL, NULL),
	(5, 'title_5', 5, 2026, 150, 5, 5, NULL, NULL);
    
    -- 12 Car Rental Database
    
CREATE TABLE categories (
	id INT AUTO_INCREMENT PRIMARY KEY,
	category VARCHAR(50) NOT NULL,
	daily_rate DECIMAL(10,2) NOT NULL,
	weekly_rate DECIMAL(10,2) NOT NULL,
	monthly_rate DECIMAL(10,2) NOT NULL,
	weekend_rate DECIMAL(10,2) NOT NULL
);

CREATE TABLE cars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate_number VARCHAR(20) NOT NULL,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    car_year INT NOT NULL,
    category_id INT NOT NULL,
    doors INT NOT NULL,
    picture BLOB NULL,
    car_condition VARCHAR(50) NOT NULL,
    available TINYINT NOT NULL
);

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    notes TEXT NULL
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    driver_licence_number VARCHAR(30) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    notes TEXT NULL
);

CREATE TABLE rental_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT null,
    customer_id INT NOT null,
    car_id INT NOT null,
    car_condition VARCHAR(50) NOT NULL,
    tank_level decimal(5,2) NOT NULL,
    kilometrage_start INT NOT NULL,
    kilometrage_end INT NOT NULL,
    total_kilometrage INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    rate_applied DECIMAL(10,2) NOT NULL,
    tax_rate DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    notes TEXT NULL
);

INSERT INTO categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES
    ('Economy', 35.00, 210.00, 750.00, 60.00),
    ('Compact', 45.00, 270.00, 950.00, 80.00),
    ('SUV', 75.00, 450.00, 1600.00, 130.00);

INSERT INTO cars (plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
VALUES
    ('CA1234AB', 'Toyota', 'Yaris', 2020, 1, 5, NULL, 'Excellent', 1),
    ('PB9876CD', 'VW', 'Golf', 2019, 2, 5, NULL, 'Good', 1),
    ('C7777KK', 'BMW', 'X3', 2021, 3, 5, NULL, 'Excellent', 0);

INSERT INTO employees (first_name, last_name, title, notes)
VALUES
    ('Ivan', 'Petrov', 'Agent', NULL),
    ('Maria', 'Georgieva', 'Manager', 'Corporate accounts'),
    ('Stoyan', 'Kolev', 'Mechanic', 'Checks on return');

INSERT INTO customers (driver_licence_number, full_name, address, city, zip_code, notes)
VALUES
    ('BG-123456789', 'Doncho Georgiev', '1 Vitosha Blvd', 'Sofia', '1000', NULL),
    ('BG-987654321', 'Nikolay Ivanov', '12 Shipka Str', 'Plovdiv', '4000', 'Prefers automatic'),
    ('BG-555666777', 'Elena Dimitrova', '5 Primorski Blvd', 'Varna', '9000', NULL);

INSERT INTO rental_orders (
    employee_id, customer_id, car_id, car_condition, tank_level,
    kilometrage_start, kilometrage_end, total_kilometrage,
    start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes
)
VALUES
    (1, 1, 1, 'Excellent', 90.00, 45200, 45410, 210, '2026-01-05', '2026-01-08', 3, 35.00, 20.00, 'CLOSED', 'Returned on time'),
    (2, 2, 2, 'Good', 70.00, 80350, 80520, 170, '2026-01-08', '2026-01-10', 2, 45.00, 20.00, 'CLOSED', 'No issues'),
    (1, 3, 3, 'Excellent', 100.00, 12000, 12180, 180, '2025-12-20', '2025-12-22', 2, 130.00, 20.00, 'CLOSED', 'Weekend rate applied');

-- 13 Basic Insert
    
CREATE DATABASE soft_uni;
USE soft_uni;
    
CREATE TABLE towns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO towns
VALUES(1,'Sofia'),(2,'Plovdiv'),(3,'Varna'),(4,'Burgas');

CREATE TABLE addresses (
	id INT AUTO_INCREMENT PRIMARY KEY,
    address_text TEXT NULL,
	town_id INT,
    CONSTRAINT fk_town FOREIGN KEY (town_id) REFERENCES towns(id) 
);

INSERt INTO addresses 
VALUES   (1, '1 Vitosha Blvd', 1),
    (2, '15 Tsar Simeon Str', 2),
    (3, '8 Primorski Blvd', 3),
    (4, '22 Aleksandrovska Str', 4),
    (5, '10 Dondukov Blvd', 1);

CREATE TABLE departments (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO departments
VALUES (1, 'Engineering'),(2, 'Sales'),(3, 'Marketing'),(4, 'Software Development'),(5, 'Quality Assurance');

CREATE TABLE employees (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    department_id INT,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(id),
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    address_id INT,
    CONSTRAINT fk_addres FOREIGN KEY (address_id) REFERENCES addresses(id)
);

INSERT INTO employees
VALUES(1, 'Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, 1),
    (2, 'Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, 2),
    (3, 'Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, 3),
    (4, 'Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, 4),
    (5, 'Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, 5);
    
    -- 14 Basic Select All Fields
    
    SELECT * FROM towns;
	SELECT * FROM departments;
	SELECT * FROM employees;
    
    -- 15 Basic Select All Fields and Order Them
    
	SELECT * FROM towns
	ORDER BY name;
     
	SELECT * FROM departments
	ORDER BY name;
     
	SELECT * FROM employees 
	ORDER BY salary DESC;
    
    -- 16 Basic Select Some Fields
    
	SELECT name FROM towns
    ORDER BY name;
    
	SELECT name FROM departments
    ORDER BY name;
    
	SELECT first_name, last_name, job_title, salary FROM employees
    ORDER BY salary DESC;
    
    -- 17 Increase Employees Salary
    
    UPDATE employees
    SET salary = salary + salary * 0.1;
    
    SELECT salary FROM employees;