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