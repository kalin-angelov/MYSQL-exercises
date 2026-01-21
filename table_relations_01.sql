-- 1 Mountains and Peaks

create table mountains (
    id int auto_increment primary key,
    name varchar(100)
);

create table peaks (
	id int auto_increment primary key,
    name varchar(100),
    mountain_id int,
    foreign key fk_mountain_and_peaks (mountain_id) references mountains(id)
);


-- 2 Trip Organization

select driver_id, vehicle_type,
concat(first_name, ' ', last_name) as driver_name
from vehicles v
join campers c on v.driver_id = c.id;

-- 3 SoftUni Hiking

select starting_point as route_starting_point,
end_point as route_ending_point,
leader_id,
concat(first_name, ' ', last_name) as leader_name
from campers c
join routes r on r.leader_id = c.id;

-- 4 Delete Mountains

drop table mountains, peaks;

create table mountains (
    id int auto_increment primary key,
    name varchar(100)
);

create table peaks (
	id int auto_increment primary key,
    name varchar(100),
    mountain_id int,
    foreign key fk_mountain_and_peaks (mountain_id) references mountains(id)
    on delete cascade
);