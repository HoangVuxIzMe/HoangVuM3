<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HoangVu
  Date: 12/22/2022
  Time: 11:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sua san pham</title>
</head>
<body>
<h1>Thong tin san pham</h1>
<a href="/ProductServlet">Quay lai trang chu</a>
<form method="post">
    <input name="id" value="${product.id}"><br><br>
    <input name="nameProduct" value="${product.nameProduct}"><br><br>
    <input name="priceProduct" value="${product.priceProduct}"><br><br>
    <input name="describeProduct" value="${product.describeProduct}"><br><br>
    <input name="producer" value="${product.producer}"><br><br>
    <button type="submit">Edit</button>
</form>
</body>
</html>
