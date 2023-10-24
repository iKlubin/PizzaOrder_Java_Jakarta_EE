<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.concurrent.ThreadLocalRandom" %>
<%@ page import="com.example.demo3.EmailSendingServlet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Обработка заказа</title>
</head>
<body>
<h1>Заказ обрабатывается...</h1>
<form action="EmailSendingServlet" method="post">
    <table border="0" width="35%" align="center">
        <caption><h2>Send New E-mail</h2></caption>
        <tr>
            <td width="50%">Recipient address </td>
            <td><input type="text" name="recipient" size="50"/></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><input type="submit" value="Send"/></td>
        </tr>
    </table>

</form>
<%
    String pizzaType = request.getParameter("pizzaType");
    String customerName = request.getParameter("customerName");
    String contactPhone = request.getParameter("contactPhone");
    String email = request.getParameter("email");
    String deliveryAddress = request.getParameter("deliveryAddress");
    String[] toppings = request.getParameterValues("topping");
    String customPizzaName = request.getParameter("customPizzaName");
    String customPizzaIngredients = request.getParameter("customPizzaIngredients");
    String toppingsStr = "";
    if (toppings != null && toppings.length > 0) {
        toppingsStr = String.join(", ", toppings);
    }
    Connection conn = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "12345");
        String sql = "INSERT INTO PIZZA(ORDER_ID, pizza_type, customer_name, contact_phone, email, delivery_address, TOPPINGS, CUSTOM_PIZZA_INGREDIENTS) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, String.valueOf(ThreadLocalRandom.current().nextInt(1, 1000)));
        stmt.setString(2, pizzaType.equals("Custom") ? customPizzaName : pizzaType);
        stmt.setString(3, customerName);
        stmt.setString(4, contactPhone);
        stmt.setString(5, email);
        stmt.setString(6, deliveryAddress);
        stmt.setString(7, toppingsStr);
        stmt.setString(8, customPizzaIngredients);
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            out.println("Заказ успешно размещен!");
        } else {
            out.println("Ошибка при размещении заказа.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
</body>
</html>
