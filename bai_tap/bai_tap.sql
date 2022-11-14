create database if not exists a0622i1;
use a0622i1;

-- Tao bang teacher 
create table teacher(
id int not null,
`name` varchar(45) null,
age int not null,
country varchar(45) null,
primary key(`id`, `age`)
);

-- Tao bang class
create table class(
id int not null,
`name` varchar(45) null,
primary key(`id`)
);

-- Them du lieu cho teacher, class
insert into teacher values (1,'chanh',38,'Kontum');
insert into teacher values (2,'quang',25,'DaNang');
insert into teacher(id, name, age) values (1,'cong', 28);
insert into class values (1,'a0622i1');

-- Doc bang tat ca cot
select * from teacher; 
select * from class; 

-- xoa bang
drop table class, teacher ;
drop database a0622i1;