<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registro de Usuarios</title>
    <style>
        /* Estilos CSS (opcional) */
        .user-form {
            width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
        }
        .user-form label, .user-form input, .user-form select {
            display: block;
            margin-bottom: 10px;
        }
        .user-form button {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="user-form">
        <h2>Registro de Usuarios</h2>
        <form method="POST" action="">
            <label for="name">Nombre:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required>
            
            <label for="role">Rol:</label>
            <select id="role" name="role">
                <option value="A">Administrador</option>
                <option value="J">Jefe de Sucursal</option>
                <option value="V">Vendedor</option>
                <option value="D">Despachador</option>
            </select>
            
            <label for="branch_id">Branch ID:</label>
            <select id="branch_id" name="branch_id">
                <option value="1">Sucursal A</option>
                <option value="2">Sucursal B</option>
                <option value="3">Sucursal C</option>
                <option value="4">Sucursal D</option>
                <option value="5">Sucursal E</option>
            </select>
            
            <button type="submit">Registrar</button>
        </form>
        
        <%-- Lógica para insertar el usuario en la base de datos --%>
        <%
            if (request.getMethod().equals("POST")) {
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                int branchId = Integer.parseInt(request.getParameter("branch_id"));
                
                Connection conn = null;
                PreparedStatement stmt = null;
                
                try {
                    String url = "jdbc:sqlserver://localhost:1433;databaseName=PizzaHutDB;encrypt=true;TrustServerCertificate=True;";
                    String username = "sa";
                    String passwordDB = "miguelangel";
                    
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    conn = DriverManager.getConnection(url, username, passwordDB);
                    
                    String sql = "INSERT INTO \"user\" (name, password, role, branch_id) VALUES (?, ?, ?, ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, name);
                    stmt.setString(2, password);
                    stmt.setString(3, role);
                    stmt.setInt(4, branchId);
                    stmt.executeUpdate();
                    
                    out.println("<p>Usuario insertado correctamente.</p>");
                } catch (Exception e) {
                    out.println("<p>Error al conectar con la base de datos: " + e.getMessage() + "</p>");
                } finally {
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