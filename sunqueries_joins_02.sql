-- 1 Employee Address

select e.employee_id, e.job_title, e.address_id, a.address_text
from employees as e
join addresses as a
on e.address_id = a.address_id
order by a.address_id
limit 5;

-- 2 Addresses with Towns

select e.first_name,
e.last_name, 
t.name as town, 
a.address_text
from employees as e
join addresses as a
on e.address_id = a.address_id
join towns as t
on a.town_id = t.town_id
order by first_name, last_name
limit 5;

-- 3 Sales Employee

select e.employee_id, 
e.first_name, 
e.last_name,
d.name as department_name
from employees as e
join departments as d
on e.department_id = d.department_id
where d.name = 'Sales'
order by e.employee_id desc;

-- 4 Employee Departments

select e.employee_id, e.first_name, e.salary, d.name as department_name
from employees as e
join departments as d
on e.department_id = d.department_id
where e.salary > 15000
order by d.department_id desc
limit 5;

-- 5 Employees Without Project

select e.employee_id, e.first_name
from employees as e
left join employees_projects as ep
on e.employee_id = ep.employee_id
where ep.project_id is null
order by e.employee_id desc
limit 3;

-- 6 Employees Hired After

select e.first_name, e.last_name, e.hire_date, d.name as dept_name
from employees as e
join departments as d
on e.department_id = d.department_id
where date_format(e.hire_date, '%Y-%m-%d') > '1999-01-01'
and d.name in ('Sales', 'Finance')
order by e.hire_date;

-- 7 Employees with Project

select e.employee_id,
e.first_name, 
p.name as project_name
from employees as e
join employees_projects as ep
on e.employee_id = ep.employee_id
join projects as p
on ep.project_id = p.project_id
where date_format(p.start_date, '%Y-%m-%d') > '2002-08-13'
and p.end_date is null
order by e.first_name, p.name
limit 5;

-- 8 Employee 24

select e.employee_id, e.first_name,
if (extract(year from p.start_date) >= 2005, NULL, p.name) as project_name
from employees as e
join employees_projects as ep
on e.employee_id = ep.employee_id and e.employee_id = 24
join projects as p
on ep.project_id = p.project_id
order by p.name;

-- 9 Employee Manager

-- select employee_id, first_name, manager_id,
-- case 
-- 	when manager_id = 3 then (select first_name from employees where employee_id = 3)
--     when manager_id = 7 then (select first_name from employees where employee_id = 7)
--     end
-- as manager_name
-- from employees
-- where manager_id in (3, 7)
-- order by first_name;

select e.employee_id, e.first_name, e.manager_id,
m.first_name as manager_name
from employees as e
join employees as m
on e.manager_id = m.employee_id
where e.manager_id in (3, 7)
order by e.first_name;

-- 10 Employee Summary

select e.employee_id,
concat_ws(' ', e.first_name, e.last_name) as employee_name,
concat_ws(' ', m.first_name, m.last_name) as manager_name,
d.name as department_name
from employees as e
join employees as m
on e.manager_id = m.employee_id
join departments as d
on e.department_id = d.department_id
where e.manager_id is not null
order by e.employee_id
limit 5;


-- 11 Min Average Salary

select avg(salary) as min_average_salary
from employees
group by department_id
order by min_average_salary
limit 1;

-- 12 Highest Peaks in Bulgaria

select c.country_code, m.mountain_range, p.peak_name, p.elevation
from countries as c
join mountains_countries as mc
on c.country_code = mc.country_code
join mountains as m
on mc.mountain_id = m.id
join peaks as p
on p.mountain_id = m.id
where c.country_code = 'BG'
and p.elevation > 2835
order by p.elevation desc;

-- 13 Count Mountain Ranges

select c.country_code,
count(m.mountain_range) as mountain_range
from countries as c
join mountains_countries as mc
on c.country_code = mc.country_code
join mountains as m
on mc.mountain_id = m.id
where c.country_code in ('BG', 'RU', 'US')
group by c.country_code
order by mountain_range desc;

-- 14 Countries with Rivers

select c.country_name, r.river_name
from countries as c
join continents as ct
on c.continent_code = ct.continent_code
left join countries_rivers as cr
on c.country_code = cr.country_code
left join rivers as r
on cr.river_id = r.id
where ct.continent_name = 'Africa'
order by c.country_name
limit 5;

-- 15 Continents and Currencies

select
continent_code,
currency_code,
currency_usage
from(
	select continent_code,
	currency_code,
	count(*) as currency_usage,
	dense_rank() over (
		partition by continent_code
		order by count(*) desc
	) as rnk
	from countries
	where currency_code is not null
	group by continent_code, currency_code
	having count(*) > 1
) as t
where rnk = 1
order by continent_code, currency_code;

-- 16 Countries Without Any Mountains

select count(*) as country_count
from countries as c
left join mountains_countries as mc
on c.country_code = mc.country_code
where mc.country_code is null; 

-- 17 Highest Peak and Longest River by Country

select c.country_name,
max(p.elevation) as highest_peak_elevation,
max(r.length) as longest_river_length
from countries as c
left join mountains_countries as mc
on c.country_code = mc.country_code
left join peaks as p
on mc.mountain_id = p.mountain_id
left join countries_rivers as cr
on c.country_code = cr.country_code
left join rivers as r
on cr.river_id = r.id
group by c.country_name
order by highest_peak_elevation desc, 
longest_river_length desc,
c.country_name
limit 5;