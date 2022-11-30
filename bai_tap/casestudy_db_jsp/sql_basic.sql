-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự. 
select * from nhan_vien where (ho_ten like "%H%_" or ho_ten like "%T%_" or ho_ten like "%K%_")  and LENGTH(ho_ten) <= 15;

-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * from khach_hang where 
(ROUND(DATEDIFF(CURDATE(), ngay_sinh) / 365, 0) between 18 and 50) 
and (dia_chi like "% Đà Nẵng" or dia_chi like "% Quảng Trị");

-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
select kh.ma_khach_hang, kh.ho_ten, lk.ten_loai_khach,count(kh.ho_ten) as "so_lan"from khach_hang kh
join loai_khach lk on kh.ma_loai_khach = lk.ma_loai_khach
join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
join loai_dich_vu ldv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
where lk.ten_loai_khach="Diamond"
group by(kh.ho_ten)
order by so_lan desc;

-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien 
create view tien_dvdk as
select hdct.*, sum(dvdk.gia * hdct.so_luong) as gia_tien from dich_vu_di_kem dvdk 
join hop_dong_chi_tiet hdct on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by hdct.ma_hop_dong;

select kh.ma_khach_hang, kh.ho_ten, lk.ten_loai_khach, hd.ma_hop_dong, dv.ten_dich_vu, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc,
(ifnull(dv.chi_phi_thue,0) + ifnull(tdvdk.gia_tien,0)) as tong_tien from khach_hang kh
left join loai_khach lk on lk.ma_loai_khach = kh.ma_loai_khach
left join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
left join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
left join tien_dvdk tdvdk on tdvdk.ma_hop_dong = hd.ma_hop_dong;

-- 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu 
-- của tất cả các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).
select dv.ma_dich_vu, dv.ten_dich_vu, dv.chi_phi_thue, hd.ngay_lam_hop_dong,ldv.ten_loai_dich_vu from dich_vu dv
join loai_dich_vu ldv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
join hop_dong hd on hd.ma_dich_vu = dv.ma_dich_vu
where dv.ma_dich_vu not in (select dv.ma_dich_vu from hop_dong hd
join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
where (year(hd.ngay_lam_hop_dong) = 2021 and month(hd.ngay_lam_hop_dong) in(1,2,3)))
group by dv.ma_dich_vu;

-- 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được khách hàng
--  đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
select dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.so_nguoi_toi_da, dv.chi_phi_thue, ldv.ten_loai_dich_vu from dich_vu dv
join loai_dich_vu ldv on ldv.ma_loai_dich_vu = dv.ma_loai_dich_vu
where dv.ma_dich_vu not in(select dv.ma_dich_vu from hop_dong hd
join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
where year(hd.ngay_lam_hop_dong) = 2021)
group by dv.ma_dich_vu;

--  8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
-- Cách 1:
select distinct kh.ho_ten as "Ho va ten" from khach_hang kh;
-- Cách 2:
select kh.ho_ten as "Ho va ten" from khach_hang kh 
group by kh.ho_ten;
-- Cách 3:
select distinct kh.ho_ten as "Ho va ten" from khach_hang kh
union
select kh.ho_ten from khach_hang kh;

--  9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
select month(ngay_lam_hop_dong) as "thang", count(ma_khach_hang) as so_luong_khach_hang from hop_dong 
where year(ngay_lam_hop_dong) = 2021
group by (month(ngay_lam_hop_dong))
order by month(ngay_lam_hop_dong);

--  10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem 
select hd.ma_hop_dong, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc, hd.tien_dat_coc, ifnull(sum(hdct.so_luong),0) as so_luong_dich_vu_di_kem from hop_dong hd
left join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
left join dich_vu_di_kem dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by hd.ma_hop_dong;

-- 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
select dvdk.ma_dich_vu_di_kem, dvdk.ten_dich_vu_di_kem from dich_vu_di_kem dvdk
join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
join loai_khach lk on lk.ma_loai_khach = kh.ma_loai_khach
where lk.ten_loai_khach = "Diamond" and (kh.dia_chi like "% Vinh" or kh.dia_chi like "% Quảng Ngãi");

-- 12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng), 
-- ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc 
-- của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.

select hd.ma_hop_dong, nv.ho_ten, kh.ho_tem, kh.so_dien_thoai, dv.ten_dich_vu, ifnull((hdct.so_luong),0) as so_luong_dich_vu_di_kem, hd.tien_dat_coc from hop_dong hd
left join nhan_vien nv on nv.ma_nhan_vien = hd.ma_nhan_vien
left join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
left join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
left join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
where dv.ten_dich_vu not in (select dv.ten_dich_vu from dich_vu dv
join hop_dong hd on hd.ma_dich_vu = dv.ma_dich_vu
where (month(hd.ngay_lam_hop_dong) not in (10,11,12) and year(hd.ngay_lam_hop_dong) = 2020) or 
(month(hd.ngay_lam_hop_dong) not in (7,8,9,10,11,12) and year(hd.ngay_lam_hop_dong) = 2021))
group by hd.ma_hop_dong;

-- 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).

drop view view_so_luong;
select sum(hdct.so_luong) as so_luong_dat from dich_vu_di_kem dvdk
join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
group by dvdk.ma_dich_vu_di_kem
order by so_luong_dat desc
limit 1;

select dvdk.ten_dich_vu_di_kem, sum(hdct.so_luong) as so_luong_dat from dich_vu_di_kem dvdk
join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
group by dvdk.ma_dich_vu_di_kem
having so_luong_dat = (select sum(hdct.so_luong) as so_luong_dat from dich_vu_di_kem dvdk
join hop_dong_chi_tiet hdct on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
join hop_dong hd on hd.ma_hop_dong = hdct.ma_hop_dong
group by dvdk.ma_dich_vu_di_kem
order by so_luong_dat desc
limit 1);


-- 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất
-- . Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
create view so_lan_su_dung as
select hdct.*, count(ma_dich_vu_di_kem) as so_lan_su_dung from hop_dong_chi_tiet hdct
group by ma_dich_vu_di_kem;

select hd.ma_hop_dong, ldv.ten_loai_dich_vu, dvdk.ten_dich_vu_di_kem, slsd.so_lan_su_dung from so_lan_su_dung slsd 
join hop_dong hd on hd.ma_hop_dong = slsd.ma_hop_dong
join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
join loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
join dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = slsd.ma_dich_vu_di_kem
where slsd.so_lan_su_dung = 1
order by hd.ma_hop_dong;

-- 15.	Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi 
-- mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
create view lay_ra_ma_nhan_vien as
select hd.*, count(hd.ma_nhan_vien) as so_hop_dong from hop_dong hd
where year(hd.ngay_lam_hop_dong)=2020 or year(hd.ngay_lam_hop_dong)=2021
group by hd.ma_nhan_vien
having so_hop_dong <= 3;

select nv.ma_nhan_vien, nv.ho_ten, td.ten_trinh_do, bp.ten_bo_phan, nv.so_dien_thoai, nv.dia_chi from nhan_vien nv
join trinh_do td on td.ma_trinh_do = nv.ma_trinh_do
join bo_phan bp on bp.ma_bo_phan = nv.ma_bo_phan
where nv.ma_nhan_vien in (select ma_nhan_vien from lay_ra_ma_nhan_vien lrmvn);

-- 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021
-- danh sách các nhân viên đã ký hợp từ 2019 - 2021
select hd.ma_nhan_vien from hop_dong hd
where year(hd.ngay_lam_hop_dong) between 2019 and 2021
group by hd.ma_nhan_vien;

-- danh sách nhân viên sẽ bị xóa: 
select nv.ma_nhan_vien, nv.ho_ten from nhan_vien nv
where nv.ma_nhan_vien not in (select hd.ma_nhan_vien from hop_dong hd
where year(hd.ngay_lam_hop_dong) between 2019 and 2021
group by hd.ma_nhan_vien);

-- 17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond
-- , chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ. 

-- lấy ra bảng tổng tiền của khách hàng đã làm hợp đồng
create view tong_tien_khach_hang as
select kh.ma_khach_hang, kh.ho_tem, lk.ten_loai_khach, hd.ma_hop_dong, dv.ten_dich_vu, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc
, sum((ifnull(dv.chi_phi_thue,0) + ifnull(tdvdk.gia_tien,0))) as tong_tien from khach_hang kh
left join loai_khach lk on lk.ma_loai_khach = kh.ma_loai_khach
left join hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang
left join dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
left join tien_dvdk tdvdk on tdvdk.ma_hop_dong = hd.ma_hop_dong
group by kh.ma_khach_hang;

-- Khách hàng sẽ được cập nhật từ 'Platinum' lên 'Diamond':
select ttkh.ma_khach_hang, ttkh.ho_tem, ttkh.ten_loai_khach from tong_tien_khach_hang ttkh
where year(ttkh.ngay_lam_hop_dong) =2021 and ttkh.tong_tien > 1000000 and ttkh.ten_loai_khach = "Palatinium";


-- 18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
delete from khach_hang where ma_khach_hang in(
select hd.ma_khach_hang from hop_dong hd
where year(hd.ngay_lam_hop_dong) < 2021);

-- 19.	Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.
-- lấy ra mã các dịch vụ đi kèm có số lần sử dụng nhiều hơn 10 lần 
create view so_lan_sd_dvdk as
select hdct.ma_hop_dong,  hdct.ma_dich_vu_di_kem, sum(hdct.so_luong) as so_luong from hop_dong_chi_tiet hdct
group by hdct.ma_dich_vu_di_kem
having so_luong > 10;
-- lấy ra mã các dịch vụ đi kèm có số lần sử dụng nhiều hơn 10 lần trong năm 2020: 
create view ma_dvdk_tang_gia as
select hd.*,slsd.ma_dich_vu_di_kem, slsd.so_luong from hop_dong hd
join so_lan_sd_dvdk slsd on slsd.ma_hop_dong = hd.ma_hop_dong
where year(hd.ngay_lam_hop_dong) = 2020;
-- Cập nhật giá cho các dịch vụ đi kèm :
update dich_vu_di_kem set gia = gia * 2 where ma_dich_di_kem in (select ma_dich_vu_di_kem from ma_dvdk_tang_gia);

-- 20.	Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin hiển thị
-- bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.
select nv.ma_nhan_vien, nv.ho_ten,nv.so_dien_thoai,nv.ngay_sinh,nv.dia_chi from nhan_vien nv
union 
select kh.ma_khach_hang,kh.ho_tem,kh.so_dien_thoai,kh.ngay_sinh,kh.dia_chi from khach_hang kh;
