<%--
  Created by IntelliJ IDEA.
  User: HoangVu
  Date: 12/16/2022
  Time: 6:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>List</title>
</head>
<body>
<h1>Trang danh sach sinh vien</h1>

<table class="table table-striped">
    <tr>
        <th>STT</th>
        <th>Name</th>
        <th>Birthday</th>
        <th>Address</th>
        <th>Image</th>
    </tr>
    <c:forEach var="student" items="${studentList}" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${student.getName()}</td>
            <td>${student.getBirthday()}</td>
            <td>${student.getAddress()}</td>
            <td><img style="width: 20%" src="${student.addressImage}"></td>
        </tr>
    </c:forEach>

</table>
</body>
</html>
