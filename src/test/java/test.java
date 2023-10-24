import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.concurrent.ThreadLocalRandom;

class Spring2ApplicationTests {

    @Test
    void contextLoads() {
        String pizzaType = "pizzaType";
        String customerName = "customerName";
        String contactPhone = "contactPhone";
        String email = "email";
        String deliveryAddress = "deliveryAddress";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "12345");
            String sql = "INSERT INTO PIZZA(ORDER_ID, pizza_type, customer_name, contact_phone, email, delivery_address) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, String.valueOf(ThreadLocalRandom.current().nextInt(1, 1000)));
            stmt.setString(2, pizzaType);
            stmt.setString(3, customerName);
            stmt.setString(4, contactPhone);
            stmt.setString(5, email);
            stmt.setString(6, deliveryAddress);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Заказ успешно размещен!");
            } else {
                System.out.println("Ошибка при размещении заказа.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }

}
