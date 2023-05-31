package pe.edu.vallegrande.app.prueba;

import pe.edu.vallegrande.app.db.AccesoDBLocal;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CreateRecord {
    public static void main(String[] args) {
        Connection connection = null;
        try {
            // Establecer la conexión
            connection = AccesoDBLocal.getConnection();
            System.out.println("Conexión exitosa a la base de datos.");

            // Definir la consulta SQL para insertar un nuevo registro
            String sql = "INSERT INTO \"user\" (name, password, role, branch_id) VALUES (?, ?, ?, ?)";

            // Crear un PreparedStatement con la consulta SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Establecer los valores de los parámetros para el nuevo registro
            statement.setString(1, "Luiz"); // Valor del name
            statement.setString(2, "Manzo"); // Valor del password
            statement.setString(3, "A"); // Valor del role
            statement.setInt(4, 5); // Valor del branch_id

            // Ejecutar la consulta para insertar el nuevo registro
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("Registro creado exitosamente.");
            } else {
                System.out.println("No se pudo crear el registro.");
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