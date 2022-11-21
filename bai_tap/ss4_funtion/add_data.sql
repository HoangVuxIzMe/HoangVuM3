use QuanLySinhVien;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from `subject` as s
where s.credit = (select max(credit) from `subject` s);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select * from `subject` as s
join mark as m on s.subid = m.subid
where m.mark = (select max(m.mark) from mark m);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần.
select s.*, avg(m.mark) as "AVG_Point" from student s
join mark m on m.studentid = s.studentid
group by s.studentid, s.studentname
order by AVG_Point desc;