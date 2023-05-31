package pe.edu.vallegrande.app.prueba;

import pe.edu.vallegrande.app.db.AccesoDBLocal;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConsultTotalRecords {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Consultar todos los registros en la tabla "user"
            String selectAllQuery = "SELECT id, name, password, role, branch_id FROM \"user\"";

            // Crear un PreparedStatement con la consulta para seleccionar todos los registros
            PreparedStatement selectAllStatement = connection.prepareStatement(selectAllQuery);

            // Ejecutar la consulta para seleccionar todos los registros
            ResultSet selectAllResultSet = selectAllStatement.executeQuery();

            // Mostrar los resultados en una tabla
            System.out.println("=== Registros en la tabla user ===");
            System.out.println("|  ID |   Nombre  |  Contraseña | Rol |  ID Sucursal |");
            while (selectAllResultSet.next()) {
                int id = selectAllResultSet.getInt("id");
                String name = selectAllResultSet.getString("name");
                String password = selectAllResultSet.getString("password");
                String role = selectAllResultSet.getString("role");
                String branch_id = selectAllResultSet.getString("branch_id");

                System.out.printf("| %3d | %-9s | %-11s | %-3s | %-12s |\n",
                        id, name, password, role, branch_id);
            }
            System.out.println("------------------------------------------------------");

            // Cerrar el ResultSet y el PreparedStatement
            selectAllResultSet.close();
            selectAllStatement.close();

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