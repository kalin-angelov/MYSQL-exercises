-- 1 One-To-One Relationship

create table people (
	person_id int,
    first_name varchar(50),
    salary decimal(7,2),
    passport_id int
);

create table passports (
	passport_id int auto_increment primary key,
    passport_number varchar(100) not null unique
);

insert into passports
values
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

insert into people
values
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

alter table people
add constraint
primary key(person_id);

alter table people
add constraint
foreign key (passport_id) references passports(passport_id);

-- 2 One-To-Many Relationship

create table manufacturers (
	manufacturer_id int primary key auto_increment,
    name varchar(100),
    established_on date
);

insert into manufacturers
values
(1, 'BMW', '1916-03-01'),
(2, 'Tesla', '2003-01-01'),
(3, 'Lada', '1966-05-01');

create table models (
	model_id int auto_increment primary key,
    name varchar(100),
    manufacturer_id int,
    foreign key (manufacturer_id) references manufacturers(manufacturer_id)
);

insert into models
values
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

-- 3 Many-To-Many Relationship

create table students (
	student_id int auto_increment primary key,
    name varchar(100)
);

create table exams (
	exam_id int auto_increment primary key,
    name varchar(100)
);

create table students_exams (
	student_id int,
    foreign key fk_student (student_id) references students(student_id),
    exam_id int,
    foreign key fk_exam (exam_id) references exams(exam_id)
);

insert into students
values
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron');

insert into exams
values
(101, 'Spring MVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');

insert into students_exams
values
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

-- 4 Self-Referencing

create table teachers (
	teacher_id  int auto_increment primary key,
    name varchar(100),
    manager_id int,
    foreign key (manager_id) references teachers(teacher_id)
);

insert into teachers
values (101, 'John', null);

insert into teachers 
values (105, 'Mark', 101), (106, 'Greta',101);

insert into teachers
values (104, 'Ted', 105);

insert into teachers 
values (102, 'Maya', 106), (103, 'Silvia',106);

-- 5 Online Store Database

create database demo;
use demo;

create table item_types (
	item_type_id int auto_increment primary key,
    name varchar(50)
);

create table items (
	item_id int auto_increment primary key,
    name varchar(50),
    item_type_id int,
    foreign key (item_type_id) references item_types(item_type_id)
);

create table cities (
	city_id int auto_increment primary key,
    name varchar(50)
);

create table customers (
	customer_id int auto_increment primary key,
    name varchar(50),
    birthday date,
    city_id int,
    foreign key (city_id) references cities(city_id)
);

create table orders (
	order_id int auto_increment primary key,
    customer_id int,
    foreign key (customer_id) references customers(customer_id)
);

create table order_items (
	order_id int,
    item_id int,
    primary key (order_id, item_id),
    foreign key (order_id) references orders(order_id),
    foreign key (item_id) references items(item_id)
);

-- 6 University Database

create database university;
use university;

create table subjects (
	subject_id int auto_increment primary key,
    subject_name varchar(50)
);

create table majors (
	major_id int primary key auto_increment,
    name varchar(50)
);

create table students (
	student_id int primary key auto_increment,
    student_number varchar(12),
    student_name varchar(50),
    major_id int,
    foreign key (major_id) references majors(major_id)
);

create table payments (
	payment_id int primary key auto_increment,
    payment_date date,
    payment_amount decimal(8, 2),
    student_id int,
    foreign key (student_id) references students(student_id)
);

create table agenda (
	student_id int,
    subject_id int,
    primary key (student_id, subject_id),
    foreign key (student_id) references students(student_id),
    foreign key (subject_id) references subjects(subject_id)
);

-- 9 Peaks in Rila