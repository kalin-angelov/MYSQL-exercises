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