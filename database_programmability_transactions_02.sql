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

-- 7 Define Function

delimiter //

create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50)) returns int
deterministic
begin
	return (
		select word regexp concat('^[', set_of_letters, ']+$')
    );
end//

delimiter ;

select ufn_is_word_comprised('oistmiahf', 'halves');

-- 8 Find Full Name

delimiter //

create procedure usp_get_holders_full_name()
begin
	select concat_ws(' ', first_name, last_name) as full_name
	from account_holders
    order by full_name, id;
end//

delimiter ;

call usp_get_holders_full_name();

-- 9 People with Balance Higher Than

delimiter //

create procedure usp_get_holders_with_balance_higher_than(input int)
begin
	select ah.first_name, ah.last_name
	from account_holders as ah
	join accounts as a
	on ah.id = a.account_holder_id
	where (
		select sum(a.balance)
	) > input
    group by a.account_holder_id
	order by ah.id;
end//

delimiter ;

call usp_get_holders_with_balance_higher_than(50);

-- 10 Future Value Function

delimiter //

create function ufn_calculate_future_value(sum decimal(19,4), yearly_interest double, years int)
returns decimal(19,4) deterministic
begin
	return (
		select sum * (pow((1 + yearly_interest), years))
    );
end//

delimiter ;

select ufn_calculate_future_value(1000, 0.5, 5);

-- 11 Calculating Interest

delimiter //

create procedure usp_calculate_future_value_for_account(id int, interest_rate decimal(5,4))
begin
	select 
    a.id as acount_id,
    ah.first_name,
    ah.last_name,
    a.balance as current_balance,
    (
		select cast(round(a.balance * (pow((1 + interest_rate), 5)), 4) as decimal(19,4))
        -- select ufn_calculate_future_value(a.balance, interest_rate, 5)
    ) as balance_in_5_years
	from account_holders as ah
    join accounts as a
    on ah.id = a.account_holder_id
    where a.id = id;
end//

delimiter ;

call usp_calculate_future_value_for_account(1, 0.1);

-- 12 Deposit Money

delimiter //

create procedure usp_deposit_money(account_id int, money_amount decimal(19,4))
begin
	start transaction;
	if (
		(
			select count(*) 
			from accounts
			where id like account_id
		) = 1 and money_amount < 0
    )  then
    rollback;
    else
		update accounts
        set balance = balance + money_amount
		where id = account_id;
	end if;
end//

delimiter ;

call usp_deposit_money(1, 10);

select * from accounts where id = 1;

-- 13 Withdraw Money

delimiter //

create procedure usp_withdraw_money(account_id int, money_amount decimal(19,4))
begin
	start transaction;
	if (
		(
			select count(*) 
			from accounts as a
			where id like account_id
            and balance - money_amount > 0
            and money_amount > 0
		) = 0
    )  then
    rollback;
    else
		update accounts
        set balance = balance - money_amount
		where id = account_id;
	end if;
end//

delimiter ;

call usp_withdraw_money(1, -110);

select * from accounts where id = 1;

-- 14 Money Transfer

delimiter //

create procedure usp_transfer_money(from_account_id int, to_account_id int, amount decimal(19, 4)) 
begin
	start transaction;
	if (
		(
			select count(*) 
			from accounts as a
			where id like from_account_id
            and balance - amount > 0
            and amount > 0
		) = 0
        
		or 
        
        (
			select count(*) 
			from accounts as a
			where id like to_account_id
        ) = 0
        
        or 
        
        from_account_id = to_account_id
    )  then
    rollback;
    else
		update accounts
        set balance = case
			when id = from_account_id then balance - amount
            when id = to_account_id then balance + amount
		end
        where id in (from_account_id, to_account_id);
	end if;
end//

delimiter ;

call usp_transfer_money(1, 1 , 10);

select * from accounts where id between 1 and 2;