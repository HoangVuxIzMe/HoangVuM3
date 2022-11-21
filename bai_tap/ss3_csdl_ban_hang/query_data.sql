use a0622i1;

insert into customer
values (1,'Minh Quan',10),
		(2,'Ngoc Oanh',20),
		(3,'Hong Ha',50);

insert into `cOrder`values
(1,1,'2006-03-21',null),
(2,2,'2006-03-23',null),
(3,1,'2006-03-16',null);

insert into product values
(1,'May Giat',3),
(2,'Tu Lanh',5),
(3,'Dieu Hoa',7),
(4,'Quat',1),
(5,'Bep Dien',2);

insert into orderdetail values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select oId, oDate, oTotalPrice from `cOrder`;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select cus.cName, p.pName from 
customer cus join `cOrder` o on cus.cId = o.cId_order join
OrderDetail od on o.oId = od.oId_detail join
product p on od.pId_detail = p.pId;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select cus.cName from customer cus
where cus.cId not in (select cId from `cOrder`);

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn).
select o.oId, o.oDate, sum(p.pPrice*od.odQTY) as 'oTotalPrice' from `cOrder` o
join orderdetail od on o.oId = od.oId_detail join
product p on od.pId_detail = p.pId
group by o.oId;