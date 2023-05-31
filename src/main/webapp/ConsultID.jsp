<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consulta de Usuario por ID</title>
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
        <h2>Consulta de Usuario por ID</h2>
        <%-- Formulario para ingresar el ID del usuario a consultar --%>
        <form method="get">
            <label for="userId">ID del Usuario:</label>
            <input type="number" id="userId" name="userId" required>
            <button type="submit">Consultar</button>
        </form>

        <%-- Lógica para obtener y mostrar los detalles del usuario desde la base de datos --%>
        <%-- Solo se realiza la consulta si se ha proporcionado el ID --%>
        <% if (request.getParameter("userId") != null) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
                String url = "jdbc:sqlserver://localhost:1433;databaseName=PizzaHutDB;encrypt=true;TrustServerCertificate=True;";
                String username = "sa";
                String passwordDB = "miguelangel";
                
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(url, username, passwordDB);
                
                String sql = "SELECT * FROM \"user\" WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                rs = stmt.executeQuery();
                
                if (rs.next()) {
        %>
                    <h3>Detalles del Usuario</h3>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Password</th>
                            <th>Rol</th>
                            <th>Branch ID</th>
                        </tr>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("password") %></td>
                            <td><%= rs.getString("role") %></td>
                            <td><%= rs.getInt("branch_id") %></td>
                        </tr>
                    </table>
        <%      } else { %>
                    <p>No se encontró ningún usuario con el ID <%= userId %>.</p>
        <%      }
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
        } %>
    </div>
</body>
</html>
