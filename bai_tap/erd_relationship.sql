create database if not exists a0622i1;
use a0622i1;

create table phieuxuat(
sopx int auto_increment primary key,
ngayxuat date
);

create table vattu(
mavtu varchar(50) primary key,
tenvtu varchar(50)
);

-- Bang chi tiet phieu xuat 
create table phieuxuat_vattu(
sopx_chitiet int auto_increment,
mavtu_chitiet varchar(50),
dgxuat float,
slxuat int,
primary key(sopx_chitiet, mavtu_chitiet),
foreign key(sopx_chitiet) references phieuxuat(sopx),
foreign key(mavtu_chitiet) references vattu(mavtu) 
);

create table phieunhap(
sopn int auto_increment primary key,
ngaynhap date
);

-- Bang chi tiet phieu nhap
create table phieunhap_vattu(
sopn_chitiet int auto_increment,
mavtu_chitiet varchar(50),
dgxuat float,
slxuat int,
primary key(sopn_chitiet, mavtu_chitiet),
foreign key(sopn_chitiet) references phieunhap(sopn),
foreign key(mavtu_chitiet) references vattu(mavtu) 
);

create table dondh(
sodh int auto_increment primary key,
ngaydh date
);

-- Chi tiet don hang
create table dondh_vattu(
sodh_chitiet int auto_increment,
mavtu_chitiet varchar(50),
primary key(sodh_chitiet, mavtu_chitiet),
foreign key(sodh_chitiet) references dondh(sodh),
foreign key(mavtu_chitiet) references vattu(mavtu)
);

create table nhacc(
mancc int auto_increment primary key,
tenncc varchar(50),
diachi varchar(50)
);

-- Cung cap
create table sdt_nhacc(
ma_sdt int auto_increment primary key,
sdt int,
foreign key(ma_sdt) references nhacc(mancc)
);

alter table dondh add foreign key (sodh) references nhacc(mancc);

-- Xoa database
-- drop database a0622i1