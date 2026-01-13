-- 1 Find Book Titles

select title
from books
where substring(title, 1, 3) = 'The'
order by id;

-- 2 Replace Titles

select replace(title, 'The', '***') as title
from books
where substring(title, 1, 3) = 'The'
order by id;

-- 3 Sum Cost of All Books

select round(sum(cost), 2) as cost
from books;

-- 4 Days Lived

select concat_ws(' ', first_name, last_name) as 'Full Name',
timestampdiff(DAY, born, died) as 'Days Lived'
from authors;

-- 5 Harry Potter Books

select title
from books
where title like 'Harry Potter%'
order by id;