CREATE USER 'mariangels'@'localhost' IDENTIFIED BY 'mariangels';
CREATE DATABASE sprint;
GRANT INSERT, UPDATE, DELETE, SELECT ON sprint.* TO 'mariangels'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
USE sprint;

CREATE TABLE Usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  edad INT,
  email VARCHAR(100),
  veces_utilizado INT DEFAULT 1
);
CREATE TABLE Operario (
  id_operario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  edad INT,
  email VARCHAR(100),
  veces_soporte INT DEFAULT 1
);
CREATE TABLE Soporte (
  id_soporte INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT,
  id_operario INT,
  fecha DATE,
  evaluacion INT,
  comentario VARCHAR(255),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_operario) REFERENCES Operario(id_operario)
);

-- Agregar usuarios
INSERT INTO Usuario (id_usuario, nombre, apellido, edad, email, veces_utilizado)
VALUES
  (1, 'Diana', 'Perez', 20, 'diana.perez@talent.com', 3),
  (2, 'Maria', 'Loyo', 31, 'mari.loyo@talent.com', 2),
  (3, 'Elvis', 'Perez', 29, 'elvis@talent.com', 1),
  (4, 'Simon', 'Loyo', 29, 'saimon@talent.com', 5),
  (5, 'Roxiris', 'Rodriguez', 46, 'roxiris@talent.com', 4);
  
  -- Agregar operarios
INSERT INTO Operario (id_operario, nombre, apellido, edad, email, veces_soporte)
VALUES
  (1, 'Sarah', 'Loyo', 27, 'sarah.loyo@talent.com', 2),
  (2, 'Daniel', 'Rodriguez', 31, 'daniel.rodri@talent.com', 3),
  (3, 'Andrea', 'Rodriguez', 37, 'andreita@talent.com', 1),
  (4, 'Juli', 'Medina', 26, 'juli@talent.com', 4),
  (5, 'Fernanda', 'Sequera', 35, 'fernanda@talent.com', 2);
  
-- Agregar operaciones de soporte
INSERT INTO Soporte (id_soporte, id_usuario, id_operario, fecha, evaluacion, comentario)
VALUES
  (1, 1, 2, '2023-05-01', 6, 'Buen servicio'),
  (2, 3, 1, '2023-05-02', 4, 'Tiempo de respuesta lento'),
  (3, 2, 4, '2023-05-03', 7, 'Excelente atención'),
  (4, 5, 3, '2023-05-04', 5, 'Podría mejorar la claridad de las respuestas'),
  (5, 4, 5, '2023-05-05', 7, 'Muy amable y servicial'),
  (6, 1, 2, '2023-05-06', 6, 'Buena orientación'),
  (7, 3, 1, '2023-05-07', 3, 'No resolvieron mi problema'),
  (8, 2, 4, '2023-05-08', 7, 'Rápida solución'),
  (9, 5, 3, '2023-05-09', 5, 'Necesité más explicaciones'),
  (10, 4, 5, '2023-05-10', 7, 'Resolvió mi problema de manera efectiva');
  
  -- Seleccione las 3 operaciones con mejor evaluación
SELECT * FROM Soporte ORDER BY evaluacion DESC LIMIT 3;

-- Seleccione las 3 operaciones con menor evaluación
SELECT * FROM Soporte ORDER BY evaluacion ASC LIMIT 3;

-- Seleccione al operario que más soportes ha realizado
SELECT o.*, COUNT(s.id_soporte) AS total_soportes
FROM Operario o
JOIN Soporte s ON o.id_operario = s.id_operario
GROUP BY o.id_operario
ORDER BY total_soportes DESC
LIMIT 1;

-- Seleccione al cliente que menos veces ha utilizado la aplicación
SELECT u.*, MIN(veces_utilizado) AS min_veces_utilizado
FROM Usuario u
GROUP BY u.id_usuario
ORDER BY min_veces_utilizado ASC
LIMIT 1;

-- Agregue 10 años a los tres primeros usuarios registrados
UPDATE Usuario
SET edad = edad + 10
WHERE id_usuario IN (1, 2, 3);

-- Renombre todas las columnas 'correo electrónico'. El nuevo nombre debe ser email.
ALTER TABLE Usuario
CHANGE COLUMN email correo_electronico VARCHAR(100);

ALTER TABLE Usuario
CHANGE COLUMN  correo_electronico email VARCHAR(100);

ALTER TABLE Operario
CHANGE COLUMN email correo_electronico VARCHAR(100);

ALTER TABLE Operario
CHANGE COLUMN  correo_electronico email VARCHAR(100);

-- Seleccione solo los operarios mayores de 20 años.
SELECT *
FROM Operario
WHERE edad > 20;