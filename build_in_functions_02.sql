-- 1 Find Names of All Employees by First Name

select first_name, last_name
from employees
where first_name like 'Sa%'
order by employee_id;

-- 2 Find Names of All Employees by Last Name

select first_name, last_name
from employees
where last_name like '%ei%'
order by employee_id;

-- 3 Find First Names of All Employees

select first_name
from employees
where extract(YEAR from hire_date) between 1995 and 2005
and department_id in (3, 10)
order by employee_id;

-- 4 Find All Employees Except Engineers

select first_name, last_name
from employees
where not locate('engineer', job_title)
order by employee_id;

-- 5 Find Towns with Name Length

select name
from towns
where char_length(name) in (5, 6)
order by name;

-- 6 Find Towns Starting With

select *
from towns
-- where name like 'M%'
-- or name like 'K%'
-- or name like 'B%'
-- or name like 'E%'
where name regexp '^[M, K, B, E].*'
order by name;

-- 7 Find Towns Not Starting With

select * 
from towns
where name regexp '^[^R, B, D].*'
order by name;

-- 8 Create View Employees Hired After 2000 Year

create view `v_employees_hired_after_2000` as
select first_name, last_name 
from employees
where extract(year from hire_date) > 2000;

select * from v_employees_hired_after_2000;

-- 9 Length of Last Name

select first_name, last_name
from employees
-- where last_name like '_____';
where char_length(last_name) = 5;

-- 10 Countries Holding 'A' 3 or More Times

select country_name, iso_code
from countries
where country_name like '%a%a%a%'
order by iso_code;

-- 11 Mix of Peak and River Names

select peak_name, river_name,
lower(concat(peak_name, substring(river_name, 2))) as mix
from peaks, rivers
where lower(right(peak_name, 1)) = lower(left(river_name, 1))
order by mix;

-- 12 Games from 2011 and 2012 Year

select name, 
date_format(start, '%Y-%m-%d') as start
from games
where extract(year from start) in (2011, 2012)
order by start, name
limit 50;

-- 13 User Email Providers

select user_name,
substring_index(email, '@', -1) as `email provider`
from users
order by `email provider`, user_name;

-- 14 Get Users with IP Address Like Pattern

select user_name, ip_address
from users
where ip_address like '___.1%.%.___'
order by user_name;

-- 15 Show All Games with Duration and Part of the Day

select name as game,
case
when extract(hour from start) between 0 and 11 then 'Morning'
when extract(hour from start) between 12 and 17 then 'Afternoon'
when extract(hour from start) between 18 and 24 then 'Evening'
end as 'Part of the Day',
case
	when duration <= 3 then 'Extra Short'
    when duration between 3 and 6 then 'Short'
    when duration between 6 and 10 then 'Long'
    else 'Extra Long'
end as 'Duration'
from games;

-- 16 Orders Table

select product_name, order_date,
date_add(order_date, interval 3 day) as pay_due,
date_add(order_date, interval 1 month) as deliver_due
from orders;
