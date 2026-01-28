-- 1 Count Employees by Town

delimiter //
create function ufn_count_employees_by_town(town_name varchar(50))
returns int
deterministic
begin
    return (
		select count(*)
        from employees as e
        join addresses as a
        on e.address_id = a.address_id
        join towns as t
        on t.town_id = a.town_id
        where t.name = town_name
    );
end //

delimiter ;

select ufn_count_employees_by_town('Sofia') as count;

-- 2 Employees Promotion

delimiter //
create procedure usp_raise_salaries(department_name varchar(50))
begin
	update employees as e
    join departments as d
    on e.department_id = d.department_id
    set e.salary = e.salary * 1.05
    where d.name = department_name;
end //

delimiter ;

call usp_raise_salaries('Finance');

-- 3 Employees Promotion by ID

delimiter //

create procedure usp_raise_salary_by_id(id int)
begin
	start transaction;
    if (
			(select count(employee_id) from employees
			where employee_id like id) <> 1
		) 
	then rollback;
    else
		update employees
		set salary = salary * 1.05
		where employee_id = id;
	end if;
end //

delimiter ;

call usp_raise_salary_by_id(9);

-- 4 Triggered

create table deleted_employees(
	employee_id int auto_increment primary key, 
	first_name varchar(50),
	last_name varchar(50),
	middle_name varchar(50),
	job_title varchar(50),
	department_id int,
	salary decimal(10,2)
);

delimiter //
create trigger tr_after_delete_employees
after delete on employees
for each row
begin
	insert into deleted_employees (first_name,last_name,middle_name,job_title,department_id,salary)
    values(
		old.first_name,
		old.last_name,
		old.middle_name,
		old.job_title,
		old.department_id,
		old.salary
    );
end //

delimiter ;
