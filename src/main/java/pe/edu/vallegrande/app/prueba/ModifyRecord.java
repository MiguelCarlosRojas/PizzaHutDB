package pe.edu.vallegrande.app.prueba;

import pe.edu.vallegrande.app.db.AccesoDBLocal;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ModifyRecord {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Definir la consulta SQL para modificar un registro existente por ID
            String sql = "UPDATE \"user\" SET name = ?, password = ?, role = ?, branch_id = ? WHERE id = ?";

            // Crear un PreparedStatement con la consulta SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer los valores de los parámetros para la modificación del registro
            statement.setString(1, "Luiz"); // Valor del name
            statement.setString(2, "Manzo"); // Valor del password
            statement.setString(3, "A"); // Valor del role
            statement.setInt(4, 5); // Valor del branch_id
            statement.setInt(5, 2); // Valor del ID del registro a modificar

            // Ejecutar la consulta para modificar el registro
            int rowsUpdated = statement.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Registro modificado exitosamente.");
            } else {
                System.out.println("No se pudo modificar el registro. Verifica el ID.");
            }

            // Cerrar el PreparedStatement
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