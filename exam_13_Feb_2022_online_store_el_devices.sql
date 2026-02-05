create database online_store;
use online_store;

-- 1 Table Design

create table brands (
	id int primary key auto_increment,
    name varchar(40) not null unique
);

create table categories (
	id int primary key auto_increment,
    name varchar(40) not null unique
);

create table reviews (
	id int primary key auto_increment,
    content text,
    rating decimal(10,2) not null,
    picture_url varchar(80) not null,
    published_at datetime not null
);

create table products (
	id int primary key auto_increment,
    name varchar(40) not null,
    price decimal(19,2) not null,
    quantity_in_stock int,
    description text,
    brand_id int not null,
    category_id int not null,
    review_id int,
    foreign key (brand_id) references brands(id),
	foreign key (category_id) references categories(id),
	foreign key (review_id) references reviews(id)
);

create table customers(
	id int primary key auto_increment,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    phone varchar(30) not null unique,
    address varchar(60) not null,
    discount_card bit(1) not null
);

create table orders (
	id int primary key auto_increment,
    order_datetime datetime not null,
    customer_id int not null,
    foreign key (customer_id) references customers(id)
);

create table orders_products (
	order_id int,
    product_id int,
    foreign key (order_id) references orders(id),
    foreign key (product_id) references products(id)
);


-- 2 Insert 

insert into reviews (content, picture_url, published_at, rating)
select 
(substring(description , 1, 15)) as content,
(reverse(name)) as picture_urlm,
('2010-10-10 00:00:00') as published_at,
(price / 8) as rating
from products
where id >= 5;

-- 3 Update

update products
set quantity_in_stock = quantity_in_stock - 5
where quantity_in_stock between 60 and 70;

-- 4 Delete

delete c
from customers as c
left join orders as o
on o.customer_id = c.id
where o.customer_id is null;

-- 5 Categories

select id, name
from categories
order by name desc;

-- 6 Quantity

select id, brand_id, name, quantity_in_stock
from products
where price > 1000
and quantity_in_stock < 30
order by quantity_in_stock, id;

-- 7 Review

select *
from reviews
where content like ('My%')
and char_length(content) > 61
order by rating desc;

-- 8 First customers

select
concat_ws(' ', first_name, last_name) as full_name,
address,
o.order_datetime as order_date
from customers as c
join orders as o
on o.customer_id = c.id
where year(o.order_datetime) <= 2018
order by full_name desc;

-- 9 Best categories

select 
count(c.id) as items_count,
c.name,
sum(p.quantity_in_stock) as total_quantity
from products as p
join categories as c
on c.id = p.category_id
group by c.id
order by items_count desc, total_quantity
limit 5;

-- 10 Extract client cards count

delimiter //

create function udf_customer_products_count(name VARCHAR(30))
returns int deterministic
begin
	
    return (
		select count(o.customer_id)
		from customers as c
		join orders as o
		on o.customer_id = c.id
		join orders_products as op
		on op.order_id = o.id
		where first_name = name
    );
    
end///

delimiter ;

select c.first_name,c.last_name, udf_customer_products_count('Shirley') as `total_products` from customers c
where c.first_name = 'Shirley';


-- 11 Reduce price

delimiter //

create procedure udp_reduce_price(category_name VARCHAR(50))
begin
	
    update products as p
	join categories as c
	on c.id = p.category_id
	join reviews as r
	on r.id = p.review_id
	set p.price = p.price - (p.price * 0.3)
	where r.rating < 4
	and c.name = category_name;
    
end//

delimiter ;

call udp_reduce_price ('Phones and tablets');