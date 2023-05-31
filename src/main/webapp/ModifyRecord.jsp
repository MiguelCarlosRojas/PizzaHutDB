<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Usuario</title>
    <style>
        /* Estilos CSS */
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .form-group label {
            display: inline-block;
            width: 100px;
        }

        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group select {
            width: 250px;
        }

        .form-group input[type="submit"] {
            margin-top: 10px;
        }

        .success-message {
            color: green;
            font-weight: bold;
        }

        .error-message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Editar Usuario</h2>
        <form action="" method="post">
            <div class="form-group">
                <label for="existingId">Seleccionar ID:</label>
                <select id="existingId" name="existingId">
                    <option value="">Seleccionar</option>
                    <%-- Obtener los IDs de usuarios existentes de la base de datos --%>
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
                                String id = rs.getString("id");
                                out.println("<option value='" + id + "'>" + id + "</option>");
                            }
                        } catch (Exception e) {
                            out.println("<option value='' disabled>Error al conectar con la base de datos</option>");
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
                <label for="name">Nombre:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="role">Rol:</label>
                <select id="role" name="role" required>
                    <option value="">Seleccionar</option>
                    <option value="A">Administrador</option>
                    <option value="J">Jefe de Sucursal</option>
                    <option value="V">Vendedor</option>
                    <option value="D">Despachador</option>
                </select>
            </div>
            <div class="form-group">
                <label for="branchId">Sucursal:</label>
                <select id="branchId" name="branchId" required>
                    <option value="">Seleccionar</option>
                    <option value="1">Sucursal A</option>
                    <option value="2">Sucursal B</option>
                    <option value="3">Sucursal C</option>
                    <option value="4">Sucursal D</option>
                    <option value="5">Sucursal E</option>
                </select>
            </div>
            <div class="form-group">
                <input type="submit" value="Editar Usuario">
            </div>
        </form>
        <div>
            <c:if test="${not empty successMessage}">
                <p class="success-message">${successMessage}</p>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>
        </div>
    </div>
    <script>
        // Código JavaScript (opcional)
    </script>
    <%-- Lógica para editar los datos en la base de datos --%>
    <%
        String existingId = request.getParameter("existingId");
        String manualId = request.getParameter("manualId");
        String id = (existingId != null && !existingId.isEmpty()) ? existingId : manualId;
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String branchId = request.getParameter("branchId");
        
        if (id != null && !id.isEmpty()) {
            
            try {
                String url = "jdbc:sqlserver://localhost:1433;databaseName=PizzaHutDB;encrypt=true;TrustServerCertificate=True;";
                String username = "sa";
                String passwordDB = "miguelangel";
                
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(url, username, passwordDB);
                
                String sql = "UPDATE \"user\" SET name = ?, password = ?, role = ?, branch_id = ? WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, password);
                stmt.setString(3, role);
                stmt.setString(4, branchId);
                stmt.setString(5, id);
                
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.println("<div class='success-message'>Datos actualizados correctamente.</div>");
                } else {
                    out.println("<div class='error-message'>Error al actualizar los datos del usuario.</div>");
                }
            } catch (Exception e) {
                out.println("<div class='error-message'>Error al conectar con la base de datos: " + e.getMessage() + "</div>");
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
</body>
</html>
