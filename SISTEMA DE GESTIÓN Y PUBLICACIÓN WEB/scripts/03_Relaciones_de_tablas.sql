## CREACIÓN DE BASE DE DATOS
CREATE DATABASE IF NOT EXISTS gestionWeb
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;
USE gestionWeb;

### CREACIÓN DE TABLAS

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS User (
    user_id INT AUTO_INCREMENT NOT NULL,          -- Identificador único del usuario
    document_type INT NOT NULL,                   -- Tipo de documento
    document_number INT NOT NULL,                 -- Número de documento
    names VARCHAR(60) NOT NULL,                   -- Nombre del usuario
    surnames VARCHAR(60) NOT NULL,                -- Apellidos del usuario
    mail VARCHAR(200) NOT NULL,                   -- Correo electrónico
    phone CHAR(9) NOT NULL,                       -- Teléfono del usuario
    state CHAR(1) DEFAULT 'A',                    -- Estado del usuario (Activo/Inactivo)
    CONSTRAINT pk_user PRIMARY KEY (user_id)
) ENGINE=InnoDB;

-- Tabla de consultas
CREATE TABLE IF NOT EXISTS Contact_us (
    id_Contact_us INT AUTO_INCREMENT NOT NULL,    -- Identificador único de la consulta
    user_id INT NOT NULL,                         -- Relación con el usuario
    Phone CHAR(9) NOT NULL,                       -- Teléfono del usuario
    Description VARCHAR(150) NOT NULL,           -- Descripción de la consulta
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    -- Fecha y hora de la consulta
    CONSTRAINT pk_contact_us PRIMARY KEY (id_Contact_us),
    CONSTRAINT fk_contact_us_user FOREIGN KEY (user_id) 
        REFERENCES User (user_id) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

### RELACIONES ENTRE TABLAS
-- Verificamos el motor de almacenamiento
SHOW TABLE STATUS LIKE 'User';
SHOW TABLE STATUS LIKE 'Contact_us';

-- Relación de UNO A VARIOS (User y Contact_us)
-- Ya se estableció con la clave foránea en la tabla Contact_us.

### CONSULTAS PARA LISTAR RELACIONES
-- Verificar las relaciones en la base de datos
SELECT 
    kcu.CONSTRAINT_NAME AS 'Nombre de Relación',
    kcu.REFERENCED_TABLE_NAME AS 'Tabla Padre',
    kcu.REFERENCED_COLUMN_NAME AS 'Primary Key',
    kcu.TABLE_NAME AS 'Tabla Hija',
    kcu.COLUMN_NAME AS 'Foreign Key'
FROM 
    information_schema.KEY_COLUMN_USAGE AS kcu
WHERE 
    kcu.TABLE_SCHEMA = 'gestionWeb' 
    AND kcu.REFERENCED_TABLE_NAME IS NOT NULL;

### CONSULTAS PRÁCTICAS
-- Insertar un usuario
INSERT INTO User (document_type, document_number, names, surnames, mail, phone)
VALUES (1, 12345678, 'Carlos', 'Gómez', 'carlos.gomez@example.com', '987654321');

-- Insertar una consulta de contacto
INSERT INTO Contact_us (user_id, Phone, Description)
VALUES (1, '987654321', 'Consulta sobre los servicios.');

-- Consultar todas las consultas con su usuario relacionado
SELECT 
    cu.id_Contact_us AS consulta_id, 
    u.names AS usuario_nombre, 
    cu.Description AS consulta_descripcion, 
    cu.fecha AS consulta_fecha
FROM Contact_us cu
LEFT JOIN User u ON cu.user_id = u.user_id
ORDER BY cu.fecha DESC;

### ELIMINACIÓN DE ELEMENTOS

-- Eliminar una tabla si existe
DROP TABLE IF EXISTS Contact_us;

-- Eliminar una base de datos si existe
DROP DATABASE IF EXISTS gestionWeb;
