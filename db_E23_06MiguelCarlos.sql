-- Base de datos
/* Poner en uso base de datos master */
USE master;

/* Si la base de datos ya existe la eliminamos */
DROP DATABASE PizzaHutDB;

/* Crear base de datos PizzaHutDB */
CREATE DATABASE PizzaHutDB;

/* Poner en uso la base de datos */
USE PizzaHutDB;

-- Creación de la tabla Branch (Sucursal)
CREATE TABLE dbo.branch (
    id int identity(1,1)  NOT NULL,
    name varchar(60)  NOT NULL,
    representative_id int  NOT NULL,
    CONSTRAINT branch_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla branch */
EXEC sp_columns @table_name = 'branch';

-- Creación de la tabla Delivery (Entrega)
CREATE TABLE dbo.delivery (
    id int identity(1,1)  NOT NULL,
    sale_id int  NOT NULL,
    dispatcher_id int  NOT NULL,
    date date  NOT NULL,
    customer_name varchar(60)  NOT NULL,
    customer_address varchar(200)  NOT NULL,
    status char(20)  NOT NULL,
    CONSTRAINT delivery_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla delivery */
EXEC sp_columns @table_name = 'delivery';

-- Creación de la tabla Dispatcher (Despachador)
CREATE TABLE dbo.dispatcher (
    id int identity(1,1)  NOT NULL,
    name varchar(60)  NOT NULL,
    branch_id int  NOT NULL,
    email varchar(80)  NOT NULL,
    vehicle_number Varchar(20)  NOT NULL,
    CONSTRAINT dispatcher_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla dispatcher */
EXEC sp_columns @table_name = 'dispatcher';

-- Creación de la tabla Product (Producto)
CREATE TABLE dbo.product (
    id int identity(1,1)  NOT NULL,
    name varchar(60)  NOT NULL,
    branch_id int  NOT NULL,
    price money  NOT NULL,
    description text  NOT NULL,
    CONSTRAINT product_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla product */
EXEC sp_columns @table_name = 'product';

-- Creación de la tabla Representative (Representante)
CREATE TABLE dbo.representative (
    id int identity(1,1)  NOT NULL,
    name varchar(60)  NOT NULL,
    email varchar(80)  NOT NULL,
    CONSTRAINT representative_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla representative */
EXEC sp_columns @table_name = 'representative';

-- Creación de la tabla Sale (Venta)
CREATE TABLE dbo.sale (
    id int identity(1,1)  NOT NULL,
    product_id int  NOT NULL,
    vendor_id int  NOT NULL,
    date date  NOT NULL,
    quantity int  NOT NULL,
    total_amount money  NOT NULL,
    CONSTRAINT sale_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla Sale */
EXEC sp_columns @table_name = 'sale';

-- Creación de la tabla User (Usuario)
CREATE TABLE dbo."user" (
    id int identity(1,1)  NOT NULL,
    name varchar(60)  NOT NULL,
    password varchar(50)  NOT NULL,
    role char(1)  NOT NULL,
    branch_id int  NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla "user" */
EXEC sp_columns @table_name = 'user';

-- Creación de la tabla Vendor (Vendedor)
CREATE TABLE dbo.vendor (
    id int identity(1,1)  NOT NULL,
    name varchar(60)  NOT NULL,
    branch_id int  NOT NULL,
    email varchar(80)  NOT NULL,
    phone_number varchar(20)  NOT NULL,
    CONSTRAINT vendor_pk PRIMARY KEY  (id)
);

/* Ver estructura de tabla vendor */
EXEC sp_columns @table_name = 'vendor';

-- Relaciones
/* Relacionar tabla branch_representative con tabla branch */
ALTER TABLE branch 
	ADD CONSTRAINT branch_representative FOREIGN KEY (representative_id)
    REFERENCES representative (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla delivery_dispatcher con tabla delivery */
ALTER TABLE delivery 
	ADD CONSTRAINT delivery_dispatcher FOREIGN KEY (dispatcher_id)
    REFERENCES dispatcher (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla delivery_sale con tabla delivery */
ALTER TABLE delivery 
	ADD CONSTRAINT delivery_sale FOREIGN KEY (sale_id)
    REFERENCES sale (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla dispatcher_branch con tabla dispatcher */
ALTER TABLE dispatcher 
	ADD CONSTRAINT dispatcher_branch FOREIGN KEY (branch_id)
    REFERENCES branch (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla product_branch con tabla product */
ALTER TABLE product 
	ADD CONSTRAINT product_branch FOREIGN KEY (branch_id)
    REFERENCES branch (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

-- Relacionar tabla sale_product con tabla sale
ALTER TABLE sale 
	ADD CONSTRAINT sale_product FOREIGN KEY (product_id)
    REFERENCES product (id)
	ON UPDATE NO ACTION
    ON DELETE NO ACTION
GO

/* Relacionar tabla sale_vendor con tabla sale */
ALTER TABLE sale 
	ADD CONSTRAINT sale_vendor FOREIGN KEY (vendor_id)
    REFERENCES vendor (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

/* Relacionar tabla user_branch con tabla user */
ALTER TABLE "user" 
	ADD CONSTRAINT user_branch FOREIGN KEY (branch_id)
    REFERENCES branch (id)
	ON UPDATE CASCADE 
    ON DELETE CASCADE
GO

-- Relacionar tabla vendor_branch con tabla vendor
ALTER TABLE vendor 
	ADD CONSTRAINT vendor_branch FOREIGN KEY (branch_id)
    REFERENCES branch (id)
	ON UPDATE NO ACTION
    ON DELETE NO ACTION
GO

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO


-- fin
