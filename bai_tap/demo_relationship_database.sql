create database if not exists a0622i1;
use a0622i1;
create table jame (
username varchar(50) primary key,
`password` varchar(50)
);
create table class(
id int auto_increment primary key,
`name` varchar(20)
);
create table room(
id int primary key auto_increment,
name varchar(20),
class_id int,
foreign key(class_id) references class(id)
);
create table student(
 id int auto_increment primary key,
 `name` varchar(50),
 gender boolean,
 birthday date,
 `email` varchar(50),
 `point` float,
 username varchar(50) unique,
 class_id int
);
alter table student add foreign key(username) references jame(username);
alter table student add foreign key(class_id) references class(id);

create table instructor (
id int auto_increment primary key,
 `name` varchar(50),
 birthday date,
 salary float
);

create table instructor_class(
 instructor_id int,
 class_id int,
 start_time date,
 end_time date,
 primary key(instructor_id,class_id),
 foreign key(instructor_id) references instructor(id),
 foreign key(class_id) references class(id)
);
