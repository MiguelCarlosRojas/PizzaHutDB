<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consultar Usuarios por Rol</title>
    <style>
        /* Estilos CSS (opcional) */
        .user-details {
            width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
        }
        .user-details table {
            width: 100%;
            border-collapse: collapse;
        }
        .user-details th, .user-details td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="user-details">
        <h2>Consultar Usuarios por Rol</h2>
        <form method="GET" action="">
            <label for="userRole">Rol:</label>
            <select id="userRole" name="userRole">
                <option value="A">Administrador</option>
                <option value="J">Jefe de Sucursal</option>
                <option value="V">Vendedor</option>
                <option value="D">Despachador</option>
            </select>
            <button type="submit">Consultar</button>
        </form>
        <br>
        <%-- Lógica para obtener y mostrar los usuarios por rol desde la base de datos --%>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            String userRoleParam = request.getParameter("userRole");
            if (userRoleParam != null && !userRoleParam.isEmpty()) {
                String userRole = userRoleParam;
                
                try {
                    String url = "jdbc:sqlserver://localhost:1433;databaseName=PizzaHutDB;encrypt=true;TrustServerCertificate=True;";
                    String username = "sa";
                    String passwordDB = "miguelangel";
                    
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    conn = DriverManager.getConnection(url, username, passwordDB);
                    
                    String sql = "SELECT * FROM \"user\" WHERE role = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, userRole);
                    rs = stmt.executeQuery();
                    
                    if (rs.next()) {
                        out.println("<table>");
                        out.println("<tr><th>ID</th><th>Nombre</th><th>Password</th><th>Rol</th><th>Branch ID</th></tr>");
                        do {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("name") + "</td>");
                            out.println("<td>" + rs.getString("password") + "</td>");
                            out.println("<td>" + rs.getString("role") + "</td>");
                            out.println("<td>" + rs.getInt("branch_id") + "</td>");
                            out.println("</tr>");
                        } while (rs.next());
                        out.println("</table>");
                    } else {
                        out.println("<p>No se encontraron usuarios con el Rol proporcionado.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error al conectar con la base de datos: " + e.getMessage() + "</p>");
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
            }
        %>
    </div>
</body>
</html>
