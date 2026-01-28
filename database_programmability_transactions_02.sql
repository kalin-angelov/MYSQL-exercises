-- 1 Employees with Salary Above 35000

delimiter //
create procedure usp_get_employees_salary_above_35000()
begin
	select first_name, last_name
    from employees
    where salary > 35000
    order by first_name, last_name, employee_id;
end //

delimiter ;

call usp_get_employees_salary_above_35000;

-- 2 Employees with Salary Above Number

delimiter //
create procedure usp_get_employees_salary_above(in check_this_salary decimal(19,4))
begin
	select first_name, last_name 
    from employees
    where salary >= check_this_salary
    order by first_name, last_name, employee_id;
end //

delimiter ;

call usp_get_employees_salary_above(45000);

-- 3 Town Names Starting With

delimiter //
create procedure usp_get_towns_starting_with(input varchar(50))
begin

	select name as town_name 
    from towns
    where name like concat(input, '%')
    order by town_name;

end //

delimiter //

call usp_get_towns_starting_with('b');

-- 4 Employees from Town

delimiter //

create procedure usp_get_employees_from_town(in input varchar(50))
begin
	select first_name, last_name
    from employees as e
    join addresses as a
    on e.address_id = a.address_id
    join towns as t
    on t.town_id = a.town_id
    where t.name = input
    order by first_name, last_name, employee_id;
end//

delimiter ;

call usp_get_employees_from_town('Sofia');

-- 5 Salary Level Function

delimiter //

create function ufn_get_salary_level(input decimal(19,4)) returns varchar(50)
deterministic
begin
	
    return (
        case
			when input < 30000 then 'Low'
            when input between 30000 and 50000 then 'Average'
            when input > 50000 then 'High'
		end
    );

end//

delimiter ;

select ufn_get_salary_level(13500.00) as slary;

-- 6 Employees by Salary Level

delimiter //

create procedure usp_get_employees_by_salary_level(input varchar(50))
begin
	select first_name, last_name
    from employees as e
    where (
		case
			when salary < 30000 then 'Low'
			when salary between 30000 and 50000 then 'Average'
			when salary > 50000 then 'High'
		end 
    ) = input
    order by first_name desc, last_name desc;
end//

delimiter ;

call usp_get_employees_by_salary_level('High');