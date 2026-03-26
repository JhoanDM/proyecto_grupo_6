REATE DATABASE IF NOT EXISTS book_cut;
USE book_cut;


CREATE TABLE Roles (
  IDRol INT NOT NULL AUTO_INCREMENT,
  Nombre_Rol VARCHAR(50) NOT NULL,
  PRIMARY KEY (IDRol)
);

CREATE TABLE Servicio (
  idServicio INT NOT NULL AUTO_INCREMENT,
  Nombre TEXT NOT NULL,
  Duracion INT NOT NULL,
  Precio INT NOT NULL,
  PRIMARY KEY (idServicio)
);

CREATE TABLE estado_citas (
  id INT NOT NULL AUTO_INCREMENT,
  estado VARCHAR(45) NOT NULL,
  descripcion TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Evaluacion_Barbero (
  idEvaluacion_Bar INT NOT NULL AUTO_INCREMENT,
  Calificacion INT NULL,
  Fecha DATE NOT NULL,
  PRIMARY KEY (idEvaluacion_Bar)
);

CREATE TABLE Evaluacion_Cliente (
  idEvaluacion_cli INT NOT NULL AUTO_INCREMENT,
  Calificacion INT NULL,
  Fecha DATE NOT NULL,
  PRIMARY KEY (idEvaluacion_cli)
);

CREATE TABLE horario (
  idhorario INT NOT NULL AUTO_INCREMENT,
  diasemana VARCHAR(45) NOT NULL,
  horainicio TIME NOT NULL,
  horafin TIME NOT NULL,
  PRIMARY KEY (idhorario)
);


CREATE TABLE Usuario (
  idUsuario INT NOT NULL AUTO_INCREMENT,
  Nombre TEXT NOT NULL,
  correo VARCHAR(255) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  contrasena VARCHAR(45) NOT NULL,
  rol_idRol INT NOT NULL,
  PRIMARY KEY (idUsuario),
  UNIQUE INDEX email_UNIQUE (correo ASC),
  FOREIGN KEY (rol_idRol) REFERENCES Roles(IDRol)
);

CREATE TABLE Beneficios (
  ID_publicacion INT NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(100) NOT NULL,
  Tipo_beneficio VARCHAR(50) NULL,
  Fecha_inicio DATE NULL,
  Fecha_fin DATE NULL,
  Usuario_idUsuario INT NOT NULL,
  PRIMARY KEY (ID_publicacion),
  INDEX fk_Beneficios_Usuario1_idx (Usuario_idUsuario ASC),
  CONSTRAINT fk_Beneficios_Usuario1 
    FOREIGN KEY (Usuario_idUsuario) 
    REFERENCES Usuario (idUsuario)
);

CREATE TABLE Perfil (
  idPerfil INT NOT NULL AUTO_INCREMENT,
  Telefono MEDIUMINT(10) NOT NULL,
  Ranking INT NOT NULL,
  foto_perfil VARCHAR(255) NULL,
  Usuario_idUsuario INT NOT NULL,
  PRIMARY KEY (idPerfil),
  INDEX fk_Perfil_Usuario1_idx (Usuario_idUsuario ASC),
  CONSTRAINT fk_Perfil_Usuario1 
    FOREIGN KEY (Usuario_idUsuario) 
    REFERENCES Usuario (idUsuario)
);

CREATE TABLE barbero (
  idbarbero INT NOT NULL AUTO_INCREMENT,
  especialidad VARCHAR(45) NOT NULL,
  disponibilidad TEXT NOT NULL,
  fotoperfil VARCHAR(45) NOT NULL,
  Usuario_idUsuario INT NOT NULL,
  PRIMARY KEY (idbarbero),
  CONSTRAINT fk_barbero_Usuario 
    FOREIGN KEY (Usuario_idUsuario) 
    REFERENCES Usuario (idUsuario)
);

CREATE TABLE Valora (
  Idvalora INT NOT NULL AUTO_INCREMENT,
  Evaluacion_Barbero_idEvaluacion_Bar INT NOT NULL,
  Evaluacion_Cliente_idEvaluacion_cli INT NOT NULL,
  PRIMARY KEY (Idvalora),
  INDEX fk_val_bar_idx (Evaluacion_Barbero_idEvaluacion_Bar ASC),
  INDEX fk_val_cli_idx (Evaluacion_Cliente_idEvaluacion_cli ASC),
  CONSTRAINT fk_val_bar 
    FOREIGN KEY (Evaluacion_Barbero_idEvaluacion_Bar) 
    REFERENCES Evaluacion_Barbero (idEvaluacion_Bar),
  CONSTRAINT fk_val_cli 
    FOREIGN KEY (Evaluacion_Cliente_idEvaluacion_cli) 
    REFERENCES Evaluacion_Cliente (idEvaluacion_cli)
);

CREATE TABLE Cita (
  idCita INT NOT NULL AUTO_INCREMENT,
  Fecha_hora DATETIME NOT NULL, 
  estado TEXT NOT NULL,
  Usuario_idUsuarioCli INT NOT NULL,
  estado_citas_id INT NOT NULL,
  Valora_Idvalora INT NULL, 
  Servicio_idServicio INT NOT NULL,
  barbero_idbarbero INT NOT NULL,
  PRIMARY KEY (idCita),
  CONSTRAINT fk_Cita_Cliente 
    FOREIGN KEY (Usuario_idUsuarioCli) REFERENCES Usuario (idUsuario),
  CONSTRAINT fk_Cita_Estado 
    FOREIGN KEY (estado_citas_id) REFERENCES estado_citas (id),
  CONSTRAINT fk_Cita_Valora 
    FOREIGN KEY (Valora_Idvalora) REFERENCES Valora (Idvalora),
  CONSTRAINT fk_Cita_Servicio 
    FOREIGN KEY (Servicio_idServicio) REFERENCES Servicio (idServicio),
  CONSTRAINT fk_Cita_Barbero 
    FOREIGN KEY (barbero_idbarbero) REFERENCES barbero (idbarbero)
);

CREATE TABLE Notificacion (
  idNotificacion INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(255) NOT NULL,
  mensaje TEXT NOT NULL,
  fecha_envio DATE NOT NULL,
  estado_citas_id INT NOT NULL,
  PRIMARY KEY (idNotificacion),
  CONSTRAINT fk_Notif_Estado 
    FOREIGN KEY (estado_citas_id) REFERENCES estado_citas (id)
);

CREATE TABLE barbero_has_horario (
  Idbarbero_has_horario INT NOT NULL AUTO_INCREMENT,
  barbero_idbarbero INT NOT NULL,
  horario_idhorario INT NOT NULL,
  PRIMARY KEY (Idbarbero_has_horario),
  CONSTRAINT fk_bhh_barbero 
    FOREIGN KEY (barbero_idbarbero) REFERENCES barbero (idbarbero),
  CONSTRAINT fk_bhh_horario 
    FOREIGN KEY (horario_idhorario) REFERENCES horario (idhorario)
);

INSERT INTO Roles (IDRol, Nombre_Rol) VALUES 
(1, 'admin'),
(2, 'barbero'),
(3, 'cliente');

INSERT INTO Usuario (idUsuario, Nombre, correo, telefono, contrasena, rol_idRol) VALUES 
(1, 'Admin Master', 'admin@barberia.com', '3001234567', 'admin123', 1),
(2, 'Juan Pérez', 'juan@barberia.com', '3002345678', 'barbero123', 2),
(3, 'Pedro Picapiedra', 'pedro@barberia.com', '3009876543', 'barbero456', 2),
(4, 'Roberto Gomez', 'roberto@barberia.com', '3008765432', 'barbero789', 2),
(5, 'Diego Marín', 'diego@barberia.com', '3007654321', 'barbero321', 2),
(6, 'Luis Suarez', 'luis@barberia.com', '3006543210', 'barbero654', 2),
(7, 'María Gómez', 'maria@clientes.com', '3003456789', 'cliente123', 3),
(8, 'Carlos López', 'carlos@clientes.com', '3004567890', 'cliente456', 3),
(9, 'Ana Rodríguez', 'ana@clientes.com', '3005678901', 'cliente789', 3);

INSERT INTO Servicio (Nombre, Duracion, Precio) VALUES 
('Corte clásico', 30, 25000),
('Corte degradé', 45, 35000),
('Afeitado', 20, 20000),
('Lavado + Corte', 50, 40000),
('Barba completa', 40, 30000);

INSERT INTO estado_citas (estado, descripcion) VALUES 
('pendiente', 'Cita solicitada esperando confirmación'),
('confirmada', 'Cita confirmada por el barbero'),
('en_progreso', 'Cita en atención actualmente'),
('completada', 'Servicio terminado satisfactoriamente'),
('cancelada', 'Cita cancelada por alguna razón');

INSERT INTO horario (diasemana, horainicio, horafin) VALUES 
('Lunes', '09:00:00', '19:00:00'),
('Martes', '09:00:00', '19:00:00'),
('Miércoles', '10:00:00', '20:00:00'),
('Jueves', '09:00:00', '18:00:00'),
('Viernes', '09:00:00', '21:00:00');

INSERT INTO barbero (idbarbero, especialidad, disponibilidad, fotoperfil, Usuario_idUsuario) VALUES 
(1, 'Degradé moderno', 'Disponible', 'barbero1.jpg', 2),
(2, 'Cortes clásicos', 'Disponible', 'barbero2.jpg', 3),
(3, 'Barbas expertas', 'Disponible', 'barbero3.jpg', 4),
(4, 'Estilos creativos', 'Ocupado', 'barbero4.jpg', 5),
(5, 'Niños y bebés', 'Disponible', 'barbero5.jpg', 6);

INSERT INTO barbero_has_horario (barbero_idbarbero, horario_idhorario) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO Evaluacion_Barbero (idEvaluacion_Bar, Calificacion, Fecha) VALUES 
(1, 5, '2026-03-10'), (2, 4, '2026-03-09'), (3, 5, '2026-03-08'), (4, 3, '2026-03-07'), (5, 4, '2026-03-06');

INSERT INTO Evaluacion_Cliente (idEvaluacion_cli, Calificacion, Fecha) VALUES 
(1, 5, '2026-03-10'), (2, 4, '2026-03-09'), (3, 5, '2026-03-08'), (4, 4, '2026-03-07'), (5, 3, '2026-03-06');

INSERT INTO Valora (Idvalora, Evaluacion_Barbero_idEvaluacion_Bar, Evaluacion_Cliente_idEvaluacion_cli) VALUES 
(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5);

-- Citas: Usamos Clientes (IDs 7, 8, 9) y Barberos (IDs 1, 2, 3, 4, 5)
INSERT INTO Cita (idCita, Fecha_hora, estado, Usuario_idUsuarioCli, estado_citas_id, Valora_Idvalora, Servicio_idServicio, barbero_idbarbero) VALUES 
(1, '2026-03-15 10:00:00', 'confirmada', 7, 2, 1, 1, 1),
(2, '2026-03-16 11:30:00', 'pendiente', 8, 1, 2, 2, 2),
(3, '2026-03-17 14:00:00', 'completada', 9, 4, 3, 3, 1),
(4, '2026-03-18 09:00:00', 'en_progreso', 7, 3, 4, 4, 3),
(5, '2026-03-19 16:45:00', 'cancelada', 8, 5, 5, 5, 2);



Consultas cliente 

/* 1. consulta de servicios despues de elegir 1 en pantalla de inicio */ 

select nombre, duracion, precio from servicio;

/* 2. seleccion de barbero al agendar una cita */

SELECT u.Nombre AS Nombre_Barbero, b.especialidad, b.fotoperfil FROM barbero b JOIN Usuario u ON b.Usuario_idUsuario = u.idUsuario;

/* 3. consuilta informacion de cita cliente, hora, servicio, estado de la cita, precio del servicio */

SELECT u.Nombre AS Cliente, DATE_FORMAT(c.Fecha_hora, '%d %H:%i') AS Hora_Formateada, s.Nombre AS Servicio_Nombre, ec.estado AS Estado_Cita, s.Precio AS Precio_Estimado FROM Cita c JOIN Usuario u ON c.Usuario_idUsuarioCli = u.idUsuario JOIN Servicio s ON c.Servicio_idServicio = s.idServicio JOIN estado_citas ec ON c.estado_citas_id = ec.id WHERE c.idCita = 1;

/* 4. consulta de horarios*/

SELECT DATE_FORMAT(Fecha_hora, '%H:%i') AS hora_ocupada FROM Cita WHERE DATE(Fecha_hora) = '2026-03-16' AND barbero_idbarbero = 1  AND estado_citas_id != 5;

/* 5. consulta validacion inicio de sesion */


SELECT 
    u.idUsuario, 
    u.Nombre, 
    u.correo, 
    r.Nombre_Rol AS rol
FROM Usuario u
JOIN Roles r ON u.rol_idRol = r.IDRol
WHERE u.correo = 'maria@clientes.com' 
  AND u.contrasena = 'cliente123';

/* 6. INSERT: Crear una nueva cita (Cliente solicita servicio) */
INSERT INTO Cita (Fecha_hora, estado, Usuario_idUsuarioCli, estado_citas_id, Servicio_idServicio, barbero_idbarbero) 
VALUES ('2026-03-25 15:00:00', 'pendiente', 9, 1, 1, 3);
SELECT '19. Nueva Cita' AS Operacion, idCita, Fecha_hora, estado FROM Cita WHERE idCita = LAST_INSERT_ID();

/* 7. SELECT: Ver agenda del día para un barbero específico */
SELECT '20. Agenda Barbero' AS Operacion, C.Fecha_hora, U.Nombre AS Cliente, S.Nombre AS Servicio 
FROM Cita C 
JOIN Usuario U ON C.Usuario_idUsuarioCli = U.idUsuario 
JOIN Servicio S ON C.Servicio_idServicio = S.idServicio 
WHERE C.barbero_idbarbero = 1 AND DATE(C.Fecha_hora) = '2026-03-15';

/* 8. UPDATE: Confirmar una cita (Barbero acepta la solicitud) */
UPDATE Cita SET estado = 'confirmada', estado_citas_id = 2 WHERE idCita = 2;
SELECT '21. Confirmar Cita' AS Operacion, idCita, estado FROM Cita WHERE idCita = 2;

/* 9. SELECT: Historial de citas de un cliente (Mis Citas)*/ 
SELECT '22. Historial Cliente' AS Operacion, C.Fecha_hora, S.Nombre AS Servicio, E.estado 
FROM Cita C 
JOIN Servicio S ON C.Servicio_idServicio = S.idServicio 
JOIN estado_citas E ON C.estado_citas_id = E.id 
WHERE C.Usuario_idUsuarioCli = 7;

/* 10. UPDATE: Cancelar una cita (Cliente o Barbero cancela)*/
UPDATE Cita SET estado = 'cancelada', estado_citas_id = 5 WHERE idCita = 5;
SELECT '23. Cancelar Cita' AS Operacion, idCita, estado FROM Cita WHERE idCita = 5;

/* 11. SELECT: Buscar barberos disponibles para un servicio específico */
SELECT '24. Barberos Disponibles' AS Operacion, U.Nombre, B.especialidad 
FROM barbero B 
JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario 
WHERE B.disponibilidad = 'Disponible';

/* 12. INSERT: Registrar una evaluación tras completar la cita */
INSERT INTO Evaluacion_Barbero (Calificacion, Fecha) VALUES (5, CURDATE());
SET @id_eval = LAST_INSERT_ID();
INSERT INTO Valora (Evaluacion_Barbero_idEvaluacion_Bar, Evaluacion_Cliente_idEvaluacion_cli) VALUES (@id_eval, 1);
UPDATE Cita SET Valora_Idvalora = LAST_INSERT_ID(), estado = 'completada', estado_citas_id = 4 WHERE idCita = 1;
SELECT '25. Evaluar Cita' AS Operacion, idCita, estado, Valora_Idvalora FROM Cita WHERE idCita = 1;

13.  /*Registrar un nuevo cliente: */ 
    INSERT INTO Clientes (Nombre_Completo, Correo_Electronico, Telefono, Contrasena_Hash)
    VALUES ('[Nombre Completo]', '[correo@ejemplo.com]', '[Telefono]', '[Contrasena_Hash]');
    

14.  /*Obtener el perfil completo de un cliente por su ID:*/

    SELECT ID_Cliente, Nombre_Completo, Correo_Electronico, Telefono
    FROM Clientes
    WHERE ID_Cliente = [ID_Cliente];


15.  /* Actualizar el número de teléfono de un cliente: */ 

    UPDATE Clientes
    SET Telefono = '[Nuevo Telefono]'
    WHERE ID_Cliente = [ID_Cliente];
    

16.  /* Ver todas las citas futuras de un cliente: */ 

    SELECT
        C.ID_Cita,
        C.Fecha_Cita,
        C.Hora_Cita,
        S.Nombre_Servicio,
        B.Nombre_Completo AS Nombre_Barbero,
        L.Nombre_Local
    FROM Citas C
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    JOIN Barberos B ON C.Barbero_ID = B.ID_Barbero
    JOIN Locales L ON C.Local_ID = L.ID_Local
    WHERE C.Cliente_ID = [ID_Cliente] AND C.Fecha_Cita >= CURDATE()
    ORDER BY C.Fecha_Cita, C.Hora_Cita;
    

17.  /* Obtener el historial de citas completadas de un cliente: */ 

    SELECT
        C.ID_Cita,
        C.Fecha_Cita,
        C.Hora_Cita,
        S.Nombre_Servicio,
        S.Precio,
        B.Nombre_Completo AS Nombre_Barbero,
        L.Nombre_Local
    FROM Citas C
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    JOIN Barberos B ON C.Barbero_ID = B.ID_Barbero
    JOIN Locales L ON C.Local_ID = L.ID_Local
    WHERE C.Cliente_ID = [ID_Cliente] AND C.Estado_Cita = 'Completada'
    ORDER BY C.Fecha_Cita DESC;


/* Consultas de Afeitado de Cliente */

18.  /* Programar una cita de afeitado para un cliente:*/

    INSERT INTO Citas (Cliente_ID, Barbero_ID, Servicio_ID, Local_ID, Fecha_Cita, Hora_Cita, Notas)
    VALUES (
        [ID_Cliente],
        [ID_Barbero],
        (SELECT ID_Servicio FROM Servicios WHERE Nombre_Servicio = 'Afeitado' LIMIT 1),
        [ID_Local],
        '[YYYY-MM-DD]',
        '[HH:MM:SS]',
        '[Notas Adicionales]'
    );
    

19.  /* Obtener todas las citas de afeitado de un cliente (futuras y pasadas):*/

    SELECT
        C.ID_Cita,
        C.Fecha_Cita,
        C.Hora_Cita,
        B.Nombre_Completo AS Barbero,
        L.Nombre_Local,
        C.Estado_Cita
    FROM Citas C
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    JOIN Barberos B ON C.Barbero_ID = B.ID_Barbero
    JOIN Locales L ON C.Local_ID = L.ID_Local
    WHERE C.Cliente_ID = [ID_Cliente] AND S.Nombre_Servicio = 'Afeitado'
    ORDER BY C.Fecha_Cita DESC, C.Hora_Cita DESC;
    

20.  /* Cancelar una cita de afeitado específica de un cliente:*/ 

    UPDATE Citas
    SET Estado_Cita = 'Cancelada'
    WHERE ID_Cita = [ID_Cita_Afeitado] AND Cliente_ID = [ID_Cliente];
    

21.  /* Contar el número de citas de afeitado completadas por un cliente:*/

    SELECT COUNT(C.ID_Cita)
    FROM Citas C
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    WHERE C.Cliente_ID = [ID_Cliente] AND S.Nombre_Servicio = 'Afeitado' AND C.Estado_Cita = 'Completada';
    

22. /* Obtener el barbero más frecuente para citas de afeitado de un cliente:*/ 

    SELECT B.Nombre_Completo AS Barbero_Frecuente, COUNT(C.ID_Barbero) AS Numero_Citas
    FROM Citas C
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    JOIN Barberos B ON C.Barbero_ID = B.ID_Barbero
    WHERE C.Cliente_ID = [ID_Cliente] AND S.Nombre_Servicio = 'Afeitado' AND C.Estado_Cita = 'Completada'
    GROUP BY B.Nombre_Completo
    ORDER BY Numero_Citas DESC
    LIMIT 1;
    

/*  Consultas de Agenda (para el Barbero/Administrador) */

22. /* Obtener todas las citas pendientes para un barbero en una fecha específica: */

    SELECT
        C.ID_Cita,
        C.Hora_Cita,
        Cl.Nombre_Completo AS Nombre_Cliente,
        S.Nombre_Servicio,
        C.Notas
    FROM Citas C
    JOIN Clientes Cl ON C.Cliente_ID = Cl.ID_Cliente
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    WHERE C.Barbero_ID = [ID_Barbero] AND C.Fecha_Cita = '[YYYY-MM-DD]' AND C.Estado_Cita = 'Pendiente'
    ORDER BY C.Hora_Cita;
    

23. /*Actualizar el estado de una cita a 'Completada':*/

    UPDATE Citas
    SET Estado_Cita = 'Completada'
    WHERE ID_Cita = [ID_Cita];
    

24. /* Obtener la disponibilidad de un barbero para un día específico (horas no ocupadas):*/ 

    SELECT Hora_Cita, Duracion_Minutos
    FROM Citas C
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    WHERE C.Barbero_ID = [ID_Barbero] AND C.Fecha_Cita = '[YYYY-MM-DD]' AND C.Estado_Cita = 'Pendiente';
    

25. /*Contar citas por estado para un barbero en el día actual:*/

    SELECT Estado_Cita, COUNT(ID_Cita) AS Cantidad
    FROM Citas
    WHERE Barbero_ID = [ID_Barbero] AND Fecha_Cita = CURDATE()
    GROUP BY Estado_Cita;
    

26. /*Obtener detalles de una cita específica (para la vista de detalles):*/

    SELECT
        Cl.Nombre_Completo AS Cliente,
        S.Nombre_Servicio AS Servicio,
        S.Precio,
        C.Fecha_Cita,
        C.Hora_Cita,
        C.Notas
    FROM Citas C
    JOIN Clientes Cl ON C.Cliente_ID = Cl.ID_Cliente
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    WHERE C.ID_Cita = [ID_Cita];


/* Consultas de Perfil del Cliente*/

27. /*Cambiar la contraseña de un cliente:*/

    UPDATE Clientes
    SET Contrasena_Hash = '[Nuevo_Contrasena_Hash]'
    WHERE ID_Cliente = [ID_Cliente];


28. /*Obtener el promedio de puntuación de las calificaciones de un cliente (si el cliente califica servicios):*/

    -- Asumiendo que el cliente puede calificar servicios de barberos
    SELECT AVG(Puntuacion)
    FROM Calificaciones Cal
    JOIN Citas C ON Cal.Cita_ID = C.ID_Cita
    WHERE C.Cliente_ID = [ID_Cliente];
    

29. /*Listar los servicios más solicitados por un cliente:*/

    SELECT S.Nombre_Servicio, COUNT(C.Servicio_ID) AS Veces_Solicitado
    FROM Citas C
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    WHERE C.Cliente_ID = [ID_Cliente] AND C.Estado_Cita = 'Completada'
    GROUP BY S.Nombre_Servicio
    ORDER BY Veces_Solicitado DESC
    LIMIT 5;
    

/*Consultas de Cortes de Cabello (y otros servicios)*/

30. /*Obtener todos los servicios de corte de cabello disponibles:*/

    SELECT ID_Servicio, Nombre_Servicio, Precio, Duracion_Minutos
    FROM Servicios
    WHERE Nombre_Servicio LIKE '%Corte%';
    

31. /*Buscar barberos que ofrecen un servicio específico (ej. 'Corte de Pelo'):*/

    SELECT DISTINCT B.Nombre_Completo, B.Telefono, L.Nombre_Local
    FROM Barberos B
    JOIN Citas C ON B.ID_Barbero = C.Barbero_ID
    JOIN Servicios S ON C.Servicio_ID = S.ID_Servicio
    JOIN Locales L ON B.Local_ID = L.ID_Local
    WHERE S.Nombre_Servicio = '[Nombre_Servicio_Deseado]';






