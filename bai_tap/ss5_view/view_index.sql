create database ss5_demo;
use ss5_demo;

CREATE TABLE product (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode INT,
    productName NVARCHAR(50),
    productPrice DOUBLE,
    productAmount DOUBLE,
    productDescription NVARCHAR(50),
    productStatus NVARCHAR(50)
);

insert into product(productCode, 
productName, 
productPrice, 
productAmount, 
productDescription, 
productStatus) values
(1,'abc',5000000,60,'may','ok'),
(5,'ssss',5000000,60,'tinh','ng'),
(2,'aaaa',233223,60,'bo','ok'),
(7,'cccc',5000123123000,60,'tui','ng'),
(8,'asssbc',5000000,60,'cua','ng'),
(9,'aaaabc',5000000,60,'toi','ok');

SELECT 
    *
FROM
    product;

create index i_productCode on product(productCode);
create index i_product_name_price on product(productName, productPrice);
explain select * from product where productCode = 8;
explain select * from product where productName like '%ss' or productPrice = 233223 ;


CREATE VIEW w_product AS
    SELECT 
        productCode, productName, productPrice, productStatus
    FROM
        product;

SELECT 
    *
FROM
    w_product;
    
SELECT 
    *
FROM
    product;
    
UPDATE w_product 
SET 
    productName = 'update view'
WHERE
    productPrice < 5000000;
    
drop view w_product;


delimiter //
create procedure sp_show_product_info()
begin
select * from product;
end//
delimiter ;

delimiter //
create procedure sp_add_product_info(IN pcode int, pname nvarchar(50), pprice double,pamount double, pdescription nvarchar(50), pstatus nvarchar(50))
begin
insert into product(productCode, 
productName, 
productPrice, 
productAmount, 
productDescription, 
productStatus) values
(pcode, pname,pprice, pamount, pdescription, pstatus);
end//
delimiter ;

call sp_add_product_info(95, 'kjahgsdihsa', 50000066, 54, 'đồ chơi', 'fake');
select * from product where productname = 'kjahgsdihsa'

delimiter //
create procedure sp_edit_product_info_by_id(IN id_edit int, pcode int, pname nvarchar(50), pprice double,pamount double, pdescription nvarchar(50), pstatus nvarchar(50))
begin
update product set
productCode = pcode,
productName = pname,
productPrice = pprice,
productAmount = pamount,
productDescription = pdescription,
productStatus = pstatus
where id = id_edit ;
end//
delimiter ;

delimiter //
create procedure sp_delete_product_info_by_id(IN id_delete int)
begin
delete from product where id =  id_delete;
end//
delimiter ;