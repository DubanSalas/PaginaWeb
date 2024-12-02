## CREACIÓN DE BASE DE DATOS
CREATE DATABASE IF NOT EXISTS gestionWeb 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_spanish_ci;
USE gestionWeb;

## CREACIÓN DE TABLAS
# Tabla de Calendario
CREATE TABLE Calendar (
    event_id INT AUTO_INCREMENT NOT NULL COMMENT 'Identificador único del evento.',
    qualification VARCHAR(30) NOT NULL COMMENT 'Título del evento.',
    description LONGTEXT NOT NULL COMMENT 'Descripción del evento.',
    date DATE NOT NULL COMMENT 'Fecha del evento.',
    data VARCHAR(500) NOT NULL,
    CONSTRAINT Calendario_pk PRIMARY KEY (event_id)
) COMMENT 'Almacena los eventos del calendario.';

# Tabla de Contactános
CREATE TABLE Contact_us (
    id_Contact_us INT AUTO_INCREMENT NOT NULL COMMENT 'Identificador único de la consulta.',
    Phone CHAR(9) NOT NULL,
    Names VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    Description VARCHAR(150) NOT NULL,
    CONSTRAINT Contact_us_pk PRIMARY KEY (id_Contact_us)
) COMMENT 'Almacena las consultas recibidas desde el formulario "Contáctanos".';

# Tabla de Noticias
CREATE TABLE News (
    news_id INT AUTO_INCREMENT NOT NULL COMMENT 'Identificador único de la noticia.',
    qualification VARCHAR(30) NOT NULL COMMENT 'Título de la noticia.',
    content LONGTEXT NOT NULL COMMENT 'Contenido de la noticia.',
    text VARCHAR(500) NOT NULL COMMENT 'Imagen o texto relacionado con la noticia.',
    date DATETIME NOT NULL COMMENT 'Fecha de publicación de la noticia.',
    CONSTRAINT News_pk PRIMARY KEY (news_id)
) COMMENT 'Guarda las noticias publicadas en el sitio.';

# Tabla de Usuarios
CREATE TABLE User (
    user_id INT AUTO_INCREMENT NOT NULL COMMENT 'Identificador único del usuario.',
    document_type INT NOT NULL COMMENT 'Tipo de documento del usuario.',
    Numero_documento INT NOT NULL COMMENT 'Número de documento del usuario.',
    names VARCHAR(60) NOT NULL COMMENT 'Contiene los nombres del usuario.',
    surnames VARCHAR(60) NOT NULL COMMENT 'Contiene los apellidos del usuario.',
    mail VARCHAR(200) NOT NULL COMMENT 'Correo electrónico del usuario.',
    phone CHAR(9) NOT NULL COMMENT 'Número de celular del usuario.',
    CONSTRAINT User_pk PRIMARY KEY (user_id)
) COMMENT 'Almacena los datos de las personas que interactúan con el sitio.';

## INSERTAR DATOS
-- Inserta un evento en Calendario
INSERT INTO Calendar (qualification, description, date, data)
VALUES ('Conferencia de Tecnología', 'Una conferencia sobre innovación y tecnología.', '2024-12-10', 'Detalles sobre la conferencia.');

-- Inserta una consulta en Contactános
INSERT INTO Contact_us (Phone, Names, last_name, Description)
VALUES ('987654321', 'María', 'Pérez', 'Consulta sobre cursos disponibles.');

-- Inserta una noticia
INSERT INTO News (qualification, content, text, date)
VALUES ('Lanzamiento del Nuevo Curso', 'Se ha lanzado un nuevo curso sobre desarrollo web.', 'imagen_curso.png', '2024-12-01 10:00:00');

-- Inserta un usuario
INSERT INTO User (document_type, Numero_documento, names, surnames, mail, phone)
VALUES (1, 12345678, 'Carlos', 'Gómez', 'carlos.gomez@example.com', '987654321');

## CONSULTAS
-- Consulta de todos los eventos del calendario
SELECT * FROM Calendar;

-- Consulta de todas las consultas realizadas por los usuarios
SELECT * FROM Contact_us;

-- Consulta de todas las noticias
SELECT * FROM News;

-- Consulta de todos los usuarios
SELECT * FROM User;

## GESTIÓN DE TABLAS
-- Ver todas las tablas en la base de datos
SHOW TABLES;

-- Ver la estructura de la tabla de Noticias
DESCRIBE News;

-- Agregar columna a la tabla de Usuarios
ALTER TABLE User
ADD COLUMN status CHAR(1) DEFAULT 'A' COMMENT 'Estado del usuario (A = Activo, I = Inactivo)';

-- Modificar columna de la tabla de Noticias
ALTER TABLE News
MODIFY COLUMN content VARCHAR(1000);

-- Eliminar columna de la tabla de Contactános
ALTER TABLE Contact_us
DROP COLUMN last_name;

-- Eliminar tabla si existe
DROP TABLE IF EXISTS Contact_us;
