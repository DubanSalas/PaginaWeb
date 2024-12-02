-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS gestionWebDB;

-- Usar la base de datos
USE gestionWebDB;

-- Crear la tabla de usuarios
CREATE TABLE IF NOT EXISTS User (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Identificador único del usuario
    document_type INT NOT NULL,               -- Tipo de documento
    document_number INT NOT NULL,             -- Número de documento
    names VARCHAR(100) NOT NULL,              -- Nombre del usuario
    surnames VARCHAR(100) NOT NULL,           -- Apellidos del usuario
    mail VARCHAR(200) NOT NULL,               -- Correo electrónico
    phone CHAR(9) NOT NULL,                   -- Número de teléfono
    state CHAR(1) DEFAULT 'A'                 -- Estado del usuario (Activo/Inactivo)
) ENGINE=InnoDB;

-- Crear la tabla de consultas
CREATE TABLE IF NOT EXISTS Contact_us (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Identificador único de la consulta
    user_id INT NOT NULL,                     -- Referencia al usuario que realizó la consulta
    description TEXT NOT NULL,                -- Contenido de la consulta
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,-- Fecha y hora de creación de la consulta
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insertar datos en la tabla de usuarios
INSERT INTO User (document_type, document_number, names, surnames, mail, phone)
VALUES 
(1, 12345678, 'Juan', 'Pérez', 'juan.perez@example.com', '987654321'),
(2, 87654321, 'María', 'Gómez', 'maria.gomez@example.com', '987654322');

-- Insertar datos en la tabla de consultas
INSERT INTO Contact_us (user_id, description)
VALUES 
(1, '¿Cuál es el horario de atención?'),
(2, '¿Ofrecen soporte técnico los fines de semana?');

-- Consultar las consultas con sus usuarios relacionados (ordenados por fecha de consulta)
SELECT 
    cu.id AS consulta_id, 
    cu.description AS consulta,
    cu.fecha AS fecha_consulta,
    u.names AS nombre_usuario,
    u.surnames AS apellido_usuario,
    u.mail AS correo_usuario
FROM Contact_us cu
LEFT JOIN User u ON cu.user_id = u.id
ORDER BY cu.fecha;

-- Consultar las consultas más recientes
SELECT 
    cu.id AS consulta_id, 
    cu.description AS consulta,
    cu.fecha AS fecha_consulta,
    u.names AS nombre_usuario,
    u.surnames AS apellido_usuario
FROM Contact_us cu
LEFT JOIN User u ON cu.user_id = u.id
ORDER BY cu.fecha DESC;

-- Consultar todos los registros de ambas tablas sin unir (sin JOIN)
SELECT * FROM User;
SELECT * FROM Contact_us;
