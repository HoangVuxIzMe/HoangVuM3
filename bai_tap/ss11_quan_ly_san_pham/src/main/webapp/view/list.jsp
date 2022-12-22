<%--
  Created by IntelliJ IDEA.
  User: HoangVu
  Date: 12/21/2022
  Time: 7:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<html>
<head>
    <title>Quan ly san pham</title>
</head>
<body>
<c:import url="../navbar.jsp"></c:import>
<h1>Product List</h1>
<a href="/ProductServlet?action=create">Thêm Mới Sản Phẩm</a>
<table class="table table-striped">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Giá</th>
        <th>Mô Tả</th>
        <th>Nhà Sản Xuất</th>
        <th>Sửa</th>
        <th>Xóa</th>
    </tr>
    <c:forEach var="product" items='${products}' varStatus="status">
        <tr>
            <td><a href="/ProductServlet?action=view&id=${product.id}">${product.id}</a></td>
            <td>${product.nameProduct}</td>
            <td>${product.priceProduct}</td>
            <td>${product.describeProduct}</td>
            <td>${product.producer}</td>
            <td><a href="/ProductServlet?action=edit&id=${product.id}">Sửa</a></td>

            <td>

                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                        data-bs-target="#exampleModal" onclick="xoa(${product.id-1},'${product.nameProduct}')">
                    Xóa
                </button>

                <!-- Modal -->
                <form action="/ProductServlet">
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Thong bao</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    Bạn có chắc chắn muốn xóa <span id="nameProduct"></span> ????
                                    <input hidden name="id" id="idDelete">
                                    <input hidden name="action" value="delete">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                    </button>
                                    <button type="submit" class="btn btn-primary">Ok</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
<form action="/ProductServlet">
    <input type="text" placeholder="Tìm kiếm" name="nameFind">
    <input type="submit" value="find" name="action">
</form>
<!-- Button trigger modal -->

</body>
<script>
    function xoa(id, name) {
        document.getElementById("idDelete").value = id;
        document.getElementById("nameProduct").innerText = name;
    }
</script>
</html>
