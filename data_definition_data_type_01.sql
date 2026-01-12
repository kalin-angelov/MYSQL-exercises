-- 1 Create Tables
CREATE TABLE `employees` 
(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE `categories` 
(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE `products` 
(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category_id INT NOT NULL
);

-- 2 Insert Data in Tables

INSERT INTO `employees` (first_name, last_name)
VALUES 
	('Georgi', 'Iliev'),
    ('Todor', 'Peev'),
    ('Ivan', 'Dimitrov');
    
-- 3 Alter Tables

ALTER TABLE `employees`
ADD middle_name VARCHAR(50); 

-- 4 Modifying Columns

ALTER TABLE `employees`
MODIFY COLUMN middle_name VARCHAR(100);