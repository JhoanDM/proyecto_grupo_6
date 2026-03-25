1. REGISTRO O LOGIN

1. SELECT: Intento de login exitoso (Admin)
SELECT '1. Login Exitoso' AS Operacion, idUsuario, Nombre, rol_idRol FROM Usuario WHERE correo = 'admin@barberia.com' AND contrasena = 'admin123';

2. SELECT: Intento de login fallido (Contraseña incorrecta)
SELECT '2. Login Fallido' AS Operacion, COUNT(*) AS Coincidencias FROM Usuario WHERE correo = 'admin@barberia.com' AND contrasena = 'error_pass';

3. SELECT: Verificar si un correo ya está registrado (para evitar duplicados en registro)
SELECT '3. Verificar Correo' AS Operacion, correo, 'Ya existe' AS Estado FROM Usuario WHERE correo = 'juan@barberia.com';

4. INSERT: Registrar un nuevo intento de acceso (Simulado en Notificacion)
INSERT INTO Notificacion (tipo, mensaje, fecha_envio, estado_citas_id) VALUES ('LOGIN', 'Intento de acceso desde IP 192.168.1.1', CURDATE(), 1);
SELECT '4. Auditoría Login' AS Operacion, mensaje FROM Notificacion WHERE tipo = 'LOGIN' ORDER BY idNotificacion DESC LIMIT 1;

5. UPDATE: Cambio de contraseña (Recuperación de cuenta)
UPDATE Usuario SET contrasena = 'nueva_pass_2026' WHERE correo = 'maria@clientes.com';
SELECT '5. Cambio Password' AS Operacion, correo, contrasena FROM Usuario WHERE correo = 'maria@clientes.com';

6. SELECT: Obtener el nombre del Rol tras un login exitoso (para redirección)
SELECT '6. Obtener Rol' AS Operacion, U.Nombre, R.Nombre_Rol FROM Usuario U JOIN Roles R ON U.rol_idRol = R.IDRol WHERE U.idUsuario = 2;

7. SELECT: Contar cuántos usuarios hay por cada Rol (Estadística de acceso)
SELECT '7. Usuarios por Rol' AS Operacion, R.Nombre_Rol, COUNT(U.idUsuario) AS Total FROM Roles R LEFT JOIN Usuario U ON R.IDRol = U.rol_idRol GROUP BY R.Nombre_Rol;

8. UPDATE: Actualizar el teléfono de un usuario (Gestión de perfil post-login)
UPDATE Usuario SET telefono = '3119998877' WHERE idUsuario = 7;
SELECT '8. Actualizar Perfil' AS Operacion, Nombre, telefono FROM Usuario WHERE idUsuario = 7;

9. DELETE: Eliminar una notificación de intento de login antigua (Limpieza)
DELETE FROM Notificacion WHERE tipo = 'LOGIN' AND idNotificacion > 0;
SELECT '9. Limpieza Auditoría' AS Operacion, 'Registros eliminados' AS Resultado;

10. SELECT: Buscar usuarios que no han completado su Perfil (Falta de datos post-login)
SELECT '10. Perfiles Incompletos' AS Operacion, U.Nombre, U.correo FROM Usuario U LEFT JOIN Perfil P ON U.idUsuario = P.Usuario_idUsuario WHERE P.idPerfil IS NULL;

11. consulta validacion inicio de sesion
SELECT 
    u.idUsuario, 
    u.Nombre, 
    u.correo, 
    r.Nombre_Rol AS rol
FROM Usuario u
JOIN Roles r ON u.rol_idRol = r.IDRol
WHERE u.correo = 'maria@clientes.com' 
  AND u.contrasena = 'cliente123';

12. consulta inicio de sesion del barbero
SELECT 
    u.idUsuario, 
    u.Nombre, 
    u.correo, 
    r.Nombre_Rol AS rol
FROM Usuario u
JOIN Roles r ON u.rol_idRol = r.IDRol
WHERE u.correo = 'juan@barberia.com' 
  AND u.contrasena = 'barbero123';

13. consulta inicio de sesion de administrador
SELECT 
    u.idUsuario, 
    u.Nombre, 
    u.correo, 
    r.Nombre_Rol AS rol
FROM Usuario u
JOIN Roles r ON u.rol_idRol = r.IDRol
WHERE u.correo = 'admin@barberia.com' 
  AND u.contrasena = 'admin123';

2. PANTALLA DE INICIO

1. consulta de servicios despues de elegir 1 en pantalla de inicio
select nombre, duracion, precio from servicio;


3. PROYECTO_INICIO_CLIENTE


1. consuilta informacion de cita cliente, hora, servicio, estado de la cita, precio del servicio
SELECT u.Nombre AS Cliente, DATE_FORMAT(c.Fecha_hora, '%d %H:%i') AS Hora_Formateada, s.Nombre AS Servicio_Nombre, ec.estado AS Estado_Cita, s.Precio AS Precio_Estimado FROM Cita c JOIN Usuario u ON c.Usuario_idUsuarioCli = u.idUsuario JOIN Servicio s ON c.Servicio_idServicio = s.idServicio JOIN estado_citas ec ON c.estado_citas_id = ec.id WHERE c.idCita = 1;

2. consulta de horario
SELECT DATE_FORMAT(Fecha_hora, '%H:%i') AS hora_ocupada FROM Cita WHERE DATE(Fecha_hora) = '2026-03-16' AND barbero_idbarbero = 1  AND estado_citas_id != 5;

3. INSERT: Crear una nueva cita (Cliente solicita servicio)
INSERT INTO Cita (Fecha_hora, estado, Usuario_idUsuarioCli, estado_citas_id, Servicio_idServicio, barbero_idbarbero) 
VALUES ('2026-03-25 15:00:00', 'pendiente', 9, 1, 1, 3);
SELECT '19. Nueva Cita' AS Operacion, idCita, Fecha_hora, estado FROM Cita WHERE idCita = LAST_INSERT_ID();

4. SELECT: Historial de citas de un cliente (Mis Citas
SELECT '22. Historial Cliente' AS Operacion, C.Fecha_hora, S.Nombre AS Servicio, E.estado 
FROM Cita C 
JOIN Servicio S ON C.Servicio_idServicio = S.idServicio 
JOIN estado_citas E ON C.estado_citas_id = E.id 
WHERE C.Usuario_idUsuarioCli = 7;

5. UPDATE: Cancelar una cita (Cliente o Barbero cancela
UPDATE Cita SET estado = 'cancelada', estado_citas_id = 5 WHERE idCita = 5;
SELECT '23. Cancelar Cita' AS Operacion, idCita, estado FROM Cita WHERE idCita = 5;

6. INSERT: Registrar una evaluación tras completar la cita
INSERT INTO Evaluacion_Barbero (Calificacion, Fecha) VALUES (5, CURDATE());
SET @id_eval = LAST_INSERT_ID();
INSERT INTO Valora (Evaluacion_Barbero_idEvaluacion_Bar, Evaluacion_Cliente_idEvaluacion_cli) VALUES (@id_eval, 1);
UPDATE Cita SET Valora_Idvalora = LAST_INSERT_ID(), estado = 'completada', estado_citas_id = 4 WHERE idCita = 1;
SELECT '25. Evaluar Cita' AS Operacion, idCita, estado, Valora_Idvalora FROM Cita WHERE idCita = 1;

7. SELECT: Citas próximas en las siguientes 24 horas (Recordatorios)
SELECT '28. Recordatorios' AS Operacion, U.Nombre AS Cliente, C.Fecha_hora 
FROM Cita C 
JOIN Usuario U ON C.Usuario_idUsuarioCli = U.idUsuario 
WHERE C.Fecha_hora BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 24 HOUR);

4. SELECCION BARBERO

1. seleccion de barbero al agendar una cita
SELECT u.Nombre AS Nombre_Barbero, b.especialidad, b.fotoperfil FROM barbero b JOIN Usuario u ON b.Usuario_idUsuario = u.idUsuario;

2. SELECT: Buscar barberos disponibles para un servicio específico
SELECT '24. Barberos Disponibles' AS Operacion, U.Nombre, B.especialidad 
FROM barbero B 
JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario 
WHERE B.disponibilidad = 'Disponible';

3. SELECT: Obtener el horario de trabajo de un barbero específico para un día determinado
SELECT '29. Horario Barbero' AS Operacion, U.Nombre AS Barbero, H.diasemana, H.horainicio, H.horafin 
FROM barbero B 
JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario 
JOIN barbero_has_horario BHH ON B.idbarbero = BHH.barbero_idbarbero 
JOIN horario H ON BHH.horario_idhorario = H.idhorario 
WHERE B.idbarbero = 1;

4. UPDATE: Cambiar la disponibilidad de un barbero a 'Ocupado' tras agendar cita
UPDATE barbero SET disponibilidad = 'Ocupado' WHERE idbarbero = 1;
SELECT '33. Estado Barbero' AS Operacion, U.Nombre, B.disponibilidad 
FROM barbero B JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario WHERE B.idbarbero = 1;