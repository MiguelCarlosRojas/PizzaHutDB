package pe.edu.vallegrande.app.prueba;

import pe.edu.vallegrande.app.db.AccesoDBLocal;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class ConsultFilters {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Definir la consulta SQL con los filtros deseados
            String sql = "SELECT * FROM \"user\" WHERE role = ?";

            // Crear un PreparedStatement con la consulta SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer los valores de los parámetros para la consulta
            statement.setString(1, "A"); // Valor del filtro de role

            // Ejecutar la consulta
            ResultSet resultSet = statement.executeQuery();

            // Crear una tabla para mostrar los resultados
            System.out.println("+----+--------------+--------------+---------+---------------+");
            System.out.println("| ID |    Nombre    |  Contraseña  |   Rol   |  ID Sucursal  |");
            System.out.println("+----+--------------+--------------+---------+---------------+");

            while (resultSet.next()) {
                // Obtener los valores de las columnas del registro
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String password = resultSet.getString("password");
                String role = resultSet.getString("role");
                String branch_id = resultSet.getString("branch_id");

                // Mostrar los valores del registro en la tabla
                System.out.printf("| %2d | %12s | %12s | %7s | %13s |%n", id, name, password, role, branch_id);
            }

            System.out.println("+----+--------------+--------------+---------+---------------+");

            // Cerrar el ResultSet y el PreparedStatement
            resultSet.close();
            statement.close();

        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos: " + e.getMessage());
        } finally {
            try {
                // Cerrar la conexión
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
}