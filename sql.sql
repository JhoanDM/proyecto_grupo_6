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




