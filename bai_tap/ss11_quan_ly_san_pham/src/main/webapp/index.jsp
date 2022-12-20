
<%--
  Created by IntelliJ IDEA.
  User: HoangVu
  Date: 12/19/2022
  Time: 8:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>Quan ly san pham</title>
  </head>
  <body>
  <h1>Quan ly san pham</h1>
  <a href="/ProductServlet"> Quay lai trang san pham</a>
  <p >${mess}</p>
  <form method="post">
    <input name="id" placeholder="Nhap id"><br>
    <input name="nameProduct" placeholder="Nhap ten san pham"><br>
    <input name="priceProduct" placeholder="Nhap gia san pham"><br>
    <input name="describeProduct" placeholder="Nhap mo ta san pham"><br>
    <input name="producer" placeholder="Nhap nha san xuat"><br>
    <button type="submit">Save</button>
  </form>
  </body>
</html>
