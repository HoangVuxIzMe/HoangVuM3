USE quanlysinhvien;

-- Hiển thị tất cả sinh viên có tên bắt đầu bằng 'h'
select StudentName from Student where StudentName like 'H%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select ClassName, StartDate from Class where startdate between '2008-12-1 00:00:00'and '2008-12-30 23:59:59';
											-- month(StartDate)=12;
                                            
-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select SubName, Credit from subject where Credit between 3 and 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
set SQL_safe_updates = 0;
update Student set ClassId = 2 where StudentName = 'Hung';

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select StudentName, SubName, Mark from Mark m join subject Sub on m.SubId = sub.SubId 
join Student s on m.StudentId = s.StudentId
order by Mark desc, s.StudentName asc;