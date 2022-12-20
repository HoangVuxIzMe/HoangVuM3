
<%--
  Created by IntelliJ IDEA.
  User: HoangVu
  Date: 12/19/2022
  Time: 7:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>Calculator</title>
  </head>
  <body>
  <h1>Simple calculator</h1>
  <form method="post" action="/calculate">
    <fieldset>
      <legend>Calculator</legend>
      <table>
        <tr>
          <td>First operand</td>
          <td><input type="text" name="first-operand"></td>
        </tr>
        <tr>
          <td>Operator</td>
          <td>
            <select name="operator">
              <option value="+">Addition</option>
              <option value="-">Subtraction</option>
              <option value="*">Multiplication</option>
              <option value="/">Division</option>
            </select>
          </td>
        </tr>
        <tr>
          <td>Second Operator</td>
          <td><input type="text" name="second-operand"></td>
        </tr>
        <tr>
          <td></td>
          <td><input type="submit" value="Calculate"></td>
        </tr>
      </table>
    </fieldset>
  </form>
  </body>
</html>
