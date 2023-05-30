/* Poner en uso la base de datos */
USE PizzaHutDB;

/* Configurar idioma español en el servidor */
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

/* Configurar el formato de fecha */
SET DATEFORMAT dmy
GO

/* Agregar restricción CHECK en la columna "role" de la tabla "user" */
ALTER TABLE "user"
	ADD CONSTRAINT user_role_check 
	CHECK (role IN ('A', 'J', 'V', 'D'))
GO

/* Agregar restricción UNIQUE a la columna "email" en la tabla "representative" para garantizar que no haya duplicados */
ALTER TABLE representative
	ADD CONSTRAINT representative_email_unique UNIQUE (email)
GO

/* Agregar restricción CHECK en la columna "status" de la tabla "delivery" */
ALTER TABLE delivery
	ADD CONSTRAINT delivery_status_check 
	CHECK (status IN ('En camino', 'Entregado', 'Pendiente'))
GO

--CRUD Maestro

-- Insertar registros en la tabla representative
INSERT INTO representative (name, email)
VALUES
	  ('Juan Pérez', 'juan.perez@example.com'),
	  ('María Gómez', 'maria.gomez@example.com'),
	  ('Carlos López', 'carlos.lopez@example.com'),
	  ('Ana Rodríguez', 'ana.rodriguez@example.com'),
	  ('Pedro Ramírez', 'pedro.ramirez@example.com');

-- Insertar registros en la tabla branch
INSERT INTO branch (name, representative_id)
VALUES
	  ('Sucursal A', 1),
	  ('Sucursal B', 2),
	  ('Sucursal C', 3),
	  ('Sucursal D', 4),
	  ('Sucursal E', 5);

-- Insertar registros en la tabla "user"
INSERT INTO "user" (name, password, role, branch_id)
VALUES
	  ('Admin', 'admin123', 'A', 1),
	  ('Usuario 1', 'pass123', 'V', 2),
	  ('Usuario 2', 'pass456', 'J', 3),
	  ('Usuario 3', 'pass789', 'D', 4),
	  ('Usuario 4', 'pass012', 'V', 5);

-- Insertar registros en la tabla vendor
INSERT INTO vendor (name, branch_id, email, phone_number)
VALUES
	  ('José Morales', 1, 'jose.morales@example.com', '555-1234'),
	  ('Sofía Castro', 2, 'sofia.castro@example.com', '555-5678'),
	  ('Miguel Navarro', 3, 'miguel.navarro@example.com', '555-9012'),
	  ('Luisa Ortega', 4, 'luisa.ortega@example.com', '555-3456'),
	  ('Daniel Molina', 5, 'daniel.molina@example.com', '555-7890');

-- Insertar registros en la tabla dispatcher
INSERT INTO dispatcher (name, branch_id, email, vehicle_number)
VALUES
	  ('Luis Torres', 1, 'luis.torres@example.com', 'ABC123'),
	  ('Laura Sánchez', 2, 'laura.sanchez@example.com', 'DEF456'),
	  ('Diego Herrera', 3, 'diego.herrera@example.com', 'GHI789'),
	  ('Carmen Mendoza', 4, 'carmen.mendoza@example.com', 'JKL012'),
	  ('Jorge Vargas', 5, 'jorge.vargas@example.com', 'MNO345');

-- Insertar registros en la tabla product
INSERT INTO product (name, branch_id, price, description)
VALUES
	  ('Pizza Margarita', 1, 9.99, 'Deliciosa pizza con tomate, mozzarella y albahaca'),
	  ('Pizza Pepperoni', 2, 10.99, 'Sabrosa pizza con pepperoni y queso fundido'),
	  ('Pizza Hawaiana', 3, 11.99, 'Exquisita pizza con piña, jamón y queso'),
	  ('Pizza Vegetariana', 4, 10.99, 'Pizza saludable con una variedad de vegetales frescos'),
	  ('Pizza BBQ', 5, 12.99, 'Irresistible pizza con pollo a la barbacoa y salsa BBQ');

-- Insertar registros en la tabla sale
INSERT INTO sale (product_id, vendor_id, date, quantity, total_amount)
VALUES
	  (1, 1, GETDATE(), 2, 19.98),
	  (2, 2, GETDATE(), 1, 10.99),
	  (3, 3, GETDATE(), 3, 35.97),
	  (4, 4, GETDATE(), 2, 21.98),
	  (5, 5, GETDATE(), 1, 12.99);

-- Insertar registros en la tabla delivery
INSERT INTO delivery (sale_id, dispatcher_id, date, customer_name, customer_address, status)
VALUES
	  (1, 1, GETDATE(), 'Juan Pérez', 'Calle Principal 123', 'En camino'),
	  (2, 2, GETDATE(), 'María Gómez', 'Avenida Central 456', 'Entregado'),
	  (3, 3, GETDATE(), 'Carlos López', 'Boulevard Norte 789', 'En camino'),
	  (4, 4, GETDATE(), 'Ana Rodríguez', 'Calle Secundaria 012', 'Pendiente'),
	  (5, 5, GETDATE(), 'Pedro Ramírez', 'Avenida Sur 345', 'Entregado');

-- Verificar los datos insertados en cada tabla
SELECT * FROM "user";
SELECT * FROM representative;
SELECT * FROM branch;
SELECT * FROM dispatcher;
SELECT * FROM product;
SELECT * FROM vendor;
SELECT * FROM sale;
SELECT * FROM delivery;

-- Actualizar registros

-- Actualizar el nombre y email del representante con ID 1
UPDATE representative 
	SET name = 'Jane Johnson', 
	email = 'jane@example.com' WHERE id = 1;

-- Actualizar el nombre y email de la sucursal con ID 1
UPDATE branch 
	SET name = 'Sucursal B', 
	representative_id = 2 WHERE id = 1;

-- Actualizar el nombre, branch_id y email del despachador con ID 1
UPDATE dispatcher 
	SET name = 'Bob Smith', 
	branch_id = 2, email = 'bob@example.com' WHERE id = 1;

-- Actualizar el nombre, branch_id, precio y descripción del producto con ID 1
UPDATE product 
	SET name = 'Pizza Margarita', 
	branch_id = 2, price = 8.99, 
	description = 'Deliciosa pizza con queso y tomate' WHERE id = 1;

-- Actualizar el nombre, branch_id, email y número de teléfono del vendedor con ID 1
UPDATE vendor 
	SET name = 'Michael Johnson', 
	branch_id = 2, email = 'michael@example.com', 
	phone_number = '555-5678' WHERE id = 1;

-- Actualizar el nombre, password, role y branch_id del usuario con ID 1
UPDATE "user" 
	SET name = 'Sarah Davis', 
	password = 'newpassword', 
	role = 'D', branch_id = 2 WHERE id = 1;

-- Actualizar el product_id, vendor_id, date, quantity y total_amount de la venta con ID 1
UPDATE sale 
	SET product_id = 2, vendor_id = 2, 
	date = GETDATE(), quantity = 3, 
	total_amount = 29.97 WHERE id = 1;

-- Actualizar el sale_id, dispatcher_id, date, customer_name, customer_address y status de la entrega con ID 1
UPDATE delivery 
	SET sale_id = 2, dispatcher_id = 2, 
	date = GETDATE(), customer_name = 'Ana Gómez', 
	customer_address = 'Avenida Central 789', 
	status = 'Entregado' WHERE id = 1;


-- Eliminar registros

-- Eliminar la sucursal con ID 1
DELETE FROM branch 
WHERE id = 1;

-- Eliminar el despachador con ID 1
DELETE FROM dispatcher 
WHERE id = 4;

-- Eliminar el producto con ID 1
DELETE FROM product 
WHERE id = 6;

-- Eliminar el vendedor con ID 1
DELETE FROM vendor 
WHERE id = 2;

-- Eliminar el usuario con ID 1
DELETE FROM "user" 
WHERE id = 1;

-- Eliminar la venta con ID 1
DELETE FROM sale 
WHERE id = 3;

-- Eliminar la entrega con ID 1
DELETE FROM delivery 
WHERE id = 1;