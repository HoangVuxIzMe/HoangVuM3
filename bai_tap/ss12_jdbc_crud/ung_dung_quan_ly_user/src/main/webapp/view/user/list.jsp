<%--
  Created by IntelliJ IDEA.
  User: HoangVu
  Date: 12/22/2022
  Time: 12:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Management Application</title>
</head>
<body>
<center>
    <h1>User Management</h1>
    <form action="/users" method="get">
        <input type="text" name="action" value="search" hidden>
        <input type="text" name="countrySearch" placeholder="nhap quoc gia">
        <button type="submit">Tìm kiếm</button>
    </form>
    <h2>
        <a href="/users?action=create">
            Add New User
        </a>
    </h2>
</center>
<div align="center">
    <table border="1" cellpadding="5">
        <caption>
            <h2>List Of Users</h2>
        </caption>
        <tr>
            <td>ID</td>
            <td>Name</td>
            <td>Email</td>
            <td>Country</td>
            <td colspan="2">Actions</td>
        </tr>
        <c:forEach var="user" items="${listUser}">
            <tr>
                <td><c:out value="${user.id}"/></td>
                <td><c:out value="${user.name}"/></td>
                <td><c:out value="${user.email}"/></td>
                <td><c:out value="${user.country}"/></td>
                <td>
                    <a href="/users?action=edit&id=${user.id}">Edit</a>
                </td>
                <td>
                    <a href="/users?action=delete&id=${user.id}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>

