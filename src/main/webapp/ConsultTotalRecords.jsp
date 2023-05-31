<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listar Usuarios</title>
    <style>
        /* Estilos CSS (opcional) */
        .user-list {
            width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
        }
        .user-list table {
            width: 100%;
            border-collapse: collapse;
        }
        .user-list th, .user-list td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="user-list">
        <h2>Listar Usuarios</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Password</th>
                    <th>Rol</th>
                    <th>Branch ID</th>
                </tr>
            </thead>
            <tbody>
                <%-- Lógica para obtener y mostrar los usuarios desde la base de datos --%>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    
                    try {
                        String url = "jdbc:sqlserver://localhost:1433;databaseName=PizzaHutDB;encrypt=true;TrustServerCertificate=True;";
                        String username = "sa";
                        String passwordDB = "miguelangel";
                        
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        conn = DriverManager.getConnection(url, username, passwordDB);
                        
                        String sql = "SELECT * FROM \"user\"";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                        
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("name") + "</td>");
                            out.println("<td>" + rs.getString("password") + "</td>");
                            out.println("<td>" + rs.getString("role") + "</td>");
                            out.println("<td>" + rs.getInt("branch_id") + "</td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5'>Error al conectar con la base de datos: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) {
                            try { rs.close(); } catch (SQLException e) { }
                        }
                        if (stmt != null) {
                            try { stmt.close(); } catch (SQLException e) { }
                        }
                        if (conn != null) {
                            try { conn.close(); } catch (SQLException e) { }
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
