<%--
  Created by IntelliJ IDEA.
  User: HoangVu
  Date: 12/14/2022
  Time: 9:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Product Discount Calculator</title>
  </head>
  <body>

  <form action="/DiscountServlet" method="post">
    <h1>Product Description: ip 14</h1>
    <label>List Price: </label><br>
    <input type="text" name="price" ><br>
    <label>Discount Percent: </label><br>
    <input type="text" name="percent" ><br>
    <input type="submit" id="submit" value="Calculate Discount">
  </form>
  </body>
</html>
