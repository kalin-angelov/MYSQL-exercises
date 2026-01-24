-- 1 Managers

select employee_id,
concat_ws(' ', first_name, last_name) as full_name,
d.department_id,
name as department_name
from employees as e
join departments as d
on e.employee_id = d.manager_id
order by employee_id
limit 5;

-- 2 Towns Addresses

select t.town_id,
t.name as town_name , 
a.address_text
from towns as t
join addresses as a
on t.town_id = a.town_id
where t.name in ('San Francisco', 'Sofia', 'Carnation')
order by t.town_id, a.address_id;

-- 3 Employees Without Managers

select employee_id, first_name, last_name, department_id, salary
from employees
where manager_id is null;

-- 4 Higher Salary

select count(*) as count
from employees
where salary > (select avg(salary) from employees);