create database if not exists a0622i1;
use a0622i1;

create table Customer(
cId int primary key,
cName varchar(45),
cAge int
);

create table cOrder(
oId int primary key,
cId_order int,
oDate date,
oTotalPrice int
);

alter table cOrder add foreign key (cId_order) references Customer(cId);

create table Product(
pId int auto_increment primary key,
pName varchar(45),
pPrice int
);

create table OrderDetail(
oId_detail int,
pId_detail int,
odQTY int,
primary key(oId_detail, pId_detail),
foreign key(oId_detail) references cOrder(oId),
foreign key(pId_detail) references Product(pId)
);

-- Xoa database
-- drop database a0622i1