<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Usuario</title>
    <style>
        /* Estilos CSS (opcional) */
        .form-container {
            width: 300px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .form-group label {
            display: block;
        }
        .form-group input[type="text"], .form-group input[type="password"] {
            width: 100%;
            padding: 5px;
            font-size: 14px;
        }
        .form-group input[type="submit"] {
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        .success-message, .error-message {
            margin-top: 10px;
            padding: 10px;
        }
        .success-message {
            background-color: #c3e6cb;
            color: #155724;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Eliminar Usuario</h2>
        <form method="POST">
            <div class="form-group">
                <label for="existingId">ID Existente:</label>
                <select id="existingId" name="existingId">
                    <option value="">Seleccionar</option>
                    <%-- Lógica para obtener los IDs existentes desde la base de datos --%>
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
                            
                            String sql = "SELECT id FROM \"user\"";
                            stmt = conn.prepareStatement(sql);
                            rs = stmt.executeQuery();
                            
                            while (rs.next()) {
                                out.println("<option value='" + rs.getString("id") + "'>" + rs.getString("id") + "</option>");
                            }
                        } catch (Exception e) {
                            out.println("<option value=''>Error al conectar con la base de datos: " + e.getMessage() + "</option>");
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
                </select>
            </div>
            <div class="form-group">
                <input type="submit" value="Eliminar Usuario">
            </div>
        </form>
        <%-- Lógica para eliminar el usuario seleccionado --%>
        <% if (request.getMethod().equals("POST")) {
            String existingId = request.getParameter("existingId");
            String manualId = request.getParameter("manualId");        

            
            try {
                String url = "jdbc:sqlserver://localhost:1433;databaseName=PizzaHutDB;encrypt=true;TrustServerCertificate=True;";
                String username = "sa";
                String passwordDB = "miguelangel";
                
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(url, username, passwordDB);
                
                String sql = "DELETE FROM \"user\" WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                
                if (!existingId.isEmpty()) {
                    stmt.setInt(1, Integer.parseInt(existingId));
                } else if (!manualId.isEmpty()) {
                    stmt.setInt(1, Integer.parseInt(manualId));
                } else {
                    out.println("<div class='error-message'>Debes seleccionar o ingresar un ID válido</div>");
                    return;
                }
                
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.println("<div class='success-message'>Usuario eliminado correctamente</div>");
                } else {
                    out.println("<div class='error-message'>No se encontró un usuario con el ID especificado</div>");
                }
            } catch (Exception e) {
                out.println("<div class='error-message'>Error al conectar con la base de datos: " + e.getMessage() + "</div>");
            } finally {
                if (stmt != null) {
                    try { stmt.close(); } catch (SQLException e) { }
                }
                if (conn != null) {
                    try { conn.close(); } catch (SQLException e) { }
                }
            }
        } %>
    </div>
</body>
</html>

