 
-- JHOAN DIAZ MEDINA PARTE MIA GRUPO 6

-- INICIO DE SESIÓN (Pantallas 4, 5, 6)
-- ==========================================================

-- 1. Validar login (Correo y Contraseña)
SELECT idUsuario, Nombre, rol_idRol FROM Usuario WHERE correo = 'juan@barberia.com' AND contrasena = 'barbero123';

-- 2 Intento de login exitoso con etiqueta (Admin)
SELECT 'Login Exitoso' AS Operacion, idUsuario, Nombre, rol_idRol FROM Usuario WHERE correo = 'admin@barberia.com' AND contrasena = 'admin123';

-- 3 Intento de login fallido (Contraseña incorrecta)
SELECT 'Login Fallido' AS Operacion, COUNT(*) AS Coincidencias FROM Usuario WHERE correo = 'admin@barberia.com' AND contrasena = 'error_pass';

-- 4 Obtener el nombre del Rol tras un login exitoso (para redirección)
SELECT 'Obtener Rol' AS Operacion, U.Nombre, R.Nombre_Rol FROM Usuario U JOIN Roles R ON U.rol_idRol = R.IDRol WHERE U.idUsuario = 2;

-- 5 Cargar perfil completo (Usuario + Perfil)
SELECT u.Nombre, u.correo, p.Telefono, p.Ranking, p.foto_perfil FROM Usuario u LEFT JOIN Perfil p ON u.idUsuario = p.Usuario_idUsuario WHERE u.idUsuario = 7;

-- 6 Verificar si un correo ya está registrado (Evitar duplicados)
SELECT 'Verificar Correo' AS Operacion, correo, 'Ya existe' AS Estado FROM Usuario WHERE correo = 'juan@barberia.com';

-- 7 Registrar un nuevo intento de acceso 
INSERT INTO Notificacion (tipo, mensaje, fecha_envio, estado_citas_id) VALUES ('LOGIN', 'Intento de acceso desde IP 192.168.1.1', CURDATE(), 1);

-- 8 Obtener especialidad si el usuario es un barbero
SELECT especialidad, fotoperfil FROM barbero WHERE Usuario_idUsuario = 2;

-- 9 Contar cuántos usuarios hay por cada Rol (Estadística de acceso)
SELECT 'Usuarios por Rol' AS Operacion, R.Nombre_Rol, COUNT(U.idUsuario) AS Total FROM Roles R LEFT JOIN Usuario U ON R.IDRol = U.rol_idRol GROUP BY R.Nombre_Rol;

-- 10 Buscar usuarios que no han completado su Perfil (Post-login)
SELECT 'Perfiles Incompletos' AS Operacion, U.Nombre, U.correo FROM Usuario U LEFT JOIN Perfil P ON U.idUsuario = P.Usuario_idUsuario WHERE P.idPerfil IS NULL;

-- 11 Consulta validación inicio de sesión (Detallada Cliente)
SELECT u.idUsuario, u.Nombre, u.correo, r.Nombre_Rol AS rol FROM Usuario u JOIN Roles r ON u.rol_idRol = r.IDRol WHERE u.correo = 'maria@clientes.com' AND u.contrasena = 'cliente123';

-- 12 Consulta inicio de sesión del barbero (Detallada)
SELECT u.idUsuario, u.Nombre, u.correo, r.Nombre_Rol AS rol FROM Usuario u JOIN Roles r ON u.rol_idRol = r.IDRol WHERE u.correo = 'juan@barberia.com' AND u.contrasena = 'barbero123';

-- 13 Consulta inicio de sesión de administrador (Detallada)
SELECT u.idUsuario, u.Nombre, u.correo, r.Nombre_Rol AS rol FROM Usuario u JOIN Roles r ON u.rol_idRol = r.IDRol WHERE u.correo = 'admin@barberia.com' AND u.contrasena = 'admin123';

-- 14 Actualizar el teléfono de un usuario 
UPDATE Usuario SET telefono = '3119998877' WHERE idUsuario = 7;

-- 15 Limpieza de auditoría (Eliminar notificaciones de login antiguas)
DELETE FROM Notificacion WHERE tipo = 'LOGIN' AND idNotificacion > 0;

-- 16 Actualizar foto de perfil
UPDATE Perfil SET foto_perfil = 'nueva_foto_perfil.jpg' WHERE Usuario_idUsuario = 7;



-- ==========================================================
-- OLVIDO CONTRASEÑA (Pantalla 9)
-- ==========================================================

-- 1 Buscar usuario por correo para enviar token
SELECT idUsuario, Nombre FROM Usuario WHERE correo = 'maria@clientes.com';

-- 2 Cambio de contraseña (Recuperación de cuenta)
UPDATE Usuario SET contrasena = 'nueva_pass_2026' WHERE correo = 'maria@clientes.com';

-- 3 Verificar cambio de password exitoso
SELECT 'Cambio Password' AS Operacion, correo, contrasena FROM Usuario WHERE correo = 'maria@clientes.com';

-- 4 Validar que el correo pertenece a un rol específico
SELECT u.idUsuario FROM Usuario u JOIN Roles r ON u.rol_idRol = r.IDRol WHERE u.correo = 'maria@clientes.com' AND r.Nombre_Rol = 'cliente';

-- 5 Consultar correo para enviar código via gmail
SELECT correo FROM Usuario WHERE correo = 'maria@clientes.com';

-- 6 Verificar si la nueva contraseña es diferente a la anterior
SELECT (contrasena = 'nueva_pass_2026') as es_igual FROM Usuario WHERE idUsuario = 7;

-- 7 Buscar usuarios por dominio de correo (Filtro seguridad)
SELECT * FROM Usuario WHERE correo LIKE '%@clientes.com';

-- 8 Obtener fecha de creación del usuario para validar antigüedad
SELECT idUsuario, Nombre, correo FROM Usuario WHERE idUsuario = 7;

-- 9 Listar usuarios con contraseñas por defecto (Riesgo de seguridad)
SELECT idUsuario, Nombre, correo FROM Usuario WHERE contrasena IN ('123456', 'password', 'admin123');

-- 10 Buscar si el correo existe y obtener su ID de Rol
SELECT idUsuario, rol_idRol FROM Usuario WHERE correo = 'carlos@clientes.com';

-- 11 Obtener datos de contacto rápidos para soporte
SELECT Nombre, correo, telefono FROM Usuario WHERE idUsuario = 8;

-- 12 Resetear contraseña a valor temporal (Admin)
UPDATE Usuario SET contrasena = 'Temporal2026' WHERE idUsuario = 9;

-- 13 Listar últimas 5 notificaciones de cambio de clave
SELECT * FROM Notificacion WHERE mensaje LIKE '%contrasena%' ORDER BY fecha_envio DESC LIMIT 5;

-- 14 Verificar si el usuario tiene un rol de administrador antes de cambios críticos
SELECT COUNT(*) FROM Usuario WHERE idUsuario = 1 AND rol_idRol = 1;

-- 15. Crear alerta de seguridad por cambio de contraseña
INSERT INTO Notificacion (tipo, mensaje, fecha_envio, estado_citas_id) VALUES ('SEGURIDAD', 'Se cambió la contraseña del usuario 7', NOW(), 1);

-- ==========================================================
-- SERVICIOS Y AGENDAMIENTO DE CITAS (Pantallas 23, 25, 26, 27)
-- ==========================================================

--1 Consulta de todos los servicios disponibles
SELECT nombre, duracion, precio FROM servicio;

--2 Selección de barbero al agendar una cita (Nombre, especialidad, foto)
SELECT u.Nombre AS Nombre_Barbero, b.especialidad, b.fotoperfil FROM barbero b JOIN Usuario u ON b.Usuario_idUsuario = u.idUsuario;

--3 Buscar barberos disponibles (Estado 'Disponible')
SELECT 'Barberos Disponibles' AS Operacion, U.Nombre, B.especialidad FROM barbero B JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario WHERE B.disponibilidad = 'Disponible';

--4 Consulta de horarios ocupados para un barbero en fecha específica
SELECT DATE_FORMAT(Fecha_hora, '%H:%i') AS hora_ocupada FROM Cita WHERE DATE(Fecha_hora) = '2026-03-16' AND barbero_idbarbero = 1 AND estado_citas_id != 5;

--5 Crear una nueva cita (Cliente solicita servicio)
INSERT INTO Cita (Fecha_hora, estado, Usuario_idUsuarioCli, estado_citas_id, Servicio_idServicio, barbero_idbarbero) VALUES ('2026-03-25 15:00:00', 'pendiente', 9, 1, 1, 3);

--6 Obtener detalles del servicio tras elegir en pantalla de inicio
SELECT * FROM Servicio WHERE idServicio = 1;

--7 Ver agenda del día para un barbero específico
SELECT 'Agenda Barbero' AS Operacion, C.Fecha_hora, U.Nombre AS Cliente, S.Nombre AS Servicio FROM Cita C JOIN Usuario U ON C.Usuario_idUsuarioCli = U.idUsuario JOIN Servicio S ON C.Servicio_idServicio = S.idServicio WHERE C.barbero_idbarbero = 1 AND DATE(C.Fecha_hora) = '2026-03-15';

--8 Listar servicios ordenados por precio (De menor a mayor)
SELECT * FROM Servicio ORDER BY Precio ASC;


--9 Cambiar disponibilidad de barbero a 'Ocupado' tras agendar 
UPDATE barbero SET disponibilidad = 'Ocupado' WHERE idbarbero = 1;

--10 Obtener el horario de trabajo base de un barbero
SELECT 'Horario Barbero' AS Operacion, U.Nombre AS Barbero, H.diasemana, H.horainicio, H.horafin FROM barbero B JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario JOIN barbero_has_horario BHH ON B.idbarbero = BHH.barbero_idbarbero JOIN horario H ON BHH.horario_idhorario = H.idhorario WHERE B.idbarbero = 1;

--11 Buscar servicios que duren menos de 30 minutos 
SELECT * FROM Servicio WHERE Duracion <= 30;

--12 Listar barberos y su especialidad filtrando por especialidad
SELECT u.Nombre, b.especialidad FROM barbero b JOIN Usuario u ON b.Usuario_idUsuario = u.idUsuario WHERE b.especialidad LIKE '%Corte%';

-- 13 Contar citas agendadas para el día de mañana
SELECT COUNT(*) FROM Cita WHERE DATE(Fecha_hora) = DATE_ADD(CURDATE(), INTERVAL 1 DAY);

--14 Obtener el servicio más caro ofrecido
SELECT * FROM Servicio ORDER BY Precio DESC LIMIT 1;


-- ==========================================================
-- CITAS - REPROGRAMAR O CANCELAR (Pantallas 18, 19)
-- ==========================================================

-- 1 Consulta información detallada de cita (Cliente, hora, servicio, estado, precio)
SELECT u.Nombre AS Cliente, DATE_FORMAT(c.Fecha_hora, '%d %H:%i') AS Hora_Formateada, s.Nombre AS Servicio_Nombre, ec.estado AS Estado_Cita, s.Precio AS Precio_Estimado FROM Cita c JOIN Usuario u ON c.Usuario_idUsuarioCli = u.idUsuario JOIN Servicio s ON c.Servicio_idServicio = s.idServicio JOIN estado_citas ec ON c.estado_citas_id = ec.id WHERE c.idCita = 1;

-- 2 Ver agenda de próximas citas del cliente
SELECT 'Historial Cliente' AS Operacion, C.Fecha_hora, S.Nombre AS Servicio, E.estado FROM Cita C JOIN Servicio S ON C.Servicio_idServicio = S.idServicio JOIN estado_citas E ON C.estado_citas_id = E.id WHERE C.Usuario_idUsuarioCli = 7;

-- 3 Confirmar una cita (Barbero acepta la solicitud)
UPDATE Cita SET estado = 'confirmada', estado_citas_id = 2 WHERE idCita = 2;

-- 4 Cancelar una cita (Cambio de estado a 'cancelada')
UPDATE Cita SET estado = 'cancelada', estado_citas_id = 5 WHERE idCita = 5;

-- 5 Pantalla barbero: Ver próxima cita inmediata de hoy
SELECT DATE_FORMAT(c.Fecha_hora, '%H:%i') AS Hora, u.Nombre AS Cliente, s.Nombre AS Servicio FROM Cita c JOIN Usuario u ON c.Usuario_idUsuarioCli = u.idUsuario JOIN Servicio s ON c.Servicio_idServicio = s.idServicio WHERE c.barbero_idbarbero = 2 AND DATE(c.Fecha_hora) = CURDATE() AND c.estado_citas_id != 5 ORDER BY c.Fecha_hora ASC LIMIT 1;

-- 6 Reasignar una cita a otro barbero (Gestión de emergencias)
UPDATE Cita SET barbero_idbarbero = 2 WHERE idCita = 1;

-- 7 Eliminar una cita errónea (Limpieza)
DELETE FROM Cita WHERE idCita = 5;

-- 8 Citas próximas en las siguientes 24 horas (Recordatorios)
SELECT 'Recordatorios' AS Operacion, U.Nombre AS Cliente, C.Fecha_hora FROM Cita C JOIN Usuario U ON C.Usuario_idUsuarioCli = U.idUsuario WHERE C.Fecha_hora BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 24 HOUR);

-- 9 Citas pendientes de confirmación para un barbero
SELECT 'Pendientes' AS Seccion, COUNT(*) AS Total FROM Cita WHERE barbero_idbarbero = 2 AND estado_citas_id = 1;

-- 10 Resumen de citas para HOY (Barbero ID 1)
SELECT 'Citas Hoy' AS Seccion, COUNT(*) AS Total FROM Cita WHERE barbero_idbarbero = 1 AND DATE(Fecha_hora) = '2026-03-15';

-- 11 Eliminar cita duplicada por error
DELETE FROM Cita WHERE idCita = 99;

-- 12 Obtener lista de citas canceladas por el cliente para auditoría
SELECT * FROM Cita WHERE Usuario_idUsuarioCli = 7 AND estado_citas_id = 5;

-- 13 Ver historial de cambios de estado (Simulado con Notificaciones)
SELECT * FROM Notificacion WHERE mensaje LIKE '%cita%' AND mensaje LIKE '%confirmada%';

-- 14 Listar citas de un barbero que están 'en_progreso'
SELECT c.*, u.Nombre FROM Cita c JOIN Usuario u ON c.Usuario_idUsuarioCli = u.idUsuario WHERE c.barbero_idbarbero = 1 AND c.estado_citas_id = 3;

-- 15 Generar notificación automática para cita confirmada
INSERT INTO Notificacion (tipo, mensaje, fecha_envio, estado_citas_id) SELECT 'CONFIRMACION', CONCAT('Tu cita para ', S.Nombre, ' ha sido confirmada.'), CURDATE(), 2 FROM Cita C JOIN Servicio S ON C.Servicio_idServicio = S.idServicio WHERE C.idCita = 2;


-- ==========================================================
-- HISTORIAL Y CALIFICACIÓN CITAS (Pantallas 20, 21, 22)
-- ==========================================================

-- 1 Registrar una evaluación tras completar la cita
INSERT INTO Evaluacion_Barbero (Calificacion, Fecha) VALUES (5, CURDATE());

-- 2 Vincular evaluación en tabla Valora (Asumiendo ID de cliente 1)
INSERT INTO Valora (Evaluacion_Barbero_idEvaluacion_Bar, Evaluacion_Cliente_idEvaluacion_cli) VALUES (LAST_INSERT_ID(), 1);

-- 3 Actualizar cita a 'completada' y asignar valoración
UPDATE Cita SET Valora_Idvalora = LAST_INSERT_ID(), estado = 'completada', estado_citas_id = 4 WHERE idCita = 1;

-- 4 Ranking promedio de cada barbero (Estadística de calidad)
SELECT 'Ranking Barberos' AS Operacion, U.Nombre, AVG(EB.Calificacion) AS Promedio_Calificacion FROM barbero B JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario JOIN Cita C ON B.idbarbero = C.barbero_idbarbero JOIN Valora V ON C.Valora_Idvalora = V.Idvalora JOIN Evaluacion_Barbero EB ON V.Evaluacion_Barbero_idEvaluacion_Bar = EB.idEvaluacion_Bar GROUP BY B.idbarbero;

-- 5 Reporte de ingresos por servicios completados (Admin)
SELECT 'Ingresos Totales' AS Operacion, SUM(S.Precio) AS Total_Recaudado FROM Cita C JOIN Servicio S ON C.Servicio_idServicio = S.idServicio WHERE C.estado_citas_id = 4;

-- 6 Buscar citas finalizadas que aún no tienen evaluación (Pendientes)
SELECT 'Sin Evaluar' AS Operacion, C.idCita, U.Nombre AS Cliente FROM Cita C JOIN Usuario U ON C.Usuario_idUsuarioCli = U.idUsuario WHERE C.estado_citas_id = 4 AND C.Valora_Idvalora IS NULL;

-- 7 Servicio más solicitado (Popularidad)
SELECT 'Servicio Top' AS Operacion, S.Nombre, COUNT(C.idCita) AS Veces_Solicitado FROM Servicio S LEFT JOIN Cita C ON S.idServicio = C.Servicio_idServicio GROUP BY S.idServicio ORDER BY Veces_Solicitado DESC LIMIT 1;

-- 8 Carga de trabajo total hoy para un barbero (Minutos totales)
SELECT 'Carga Trabajo' AS Operacion, U.Nombre AS Barbero, SUM(S.Duracion) AS Minutos_Totales FROM Cita C JOIN Servicio S ON C.Servicio_idServicio = S.idServicio JOIN barbero B ON C.barbero_idbarbero = B.idbarbero JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario WHERE DATE(C.Fecha_hora) = CURDATE() GROUP BY B.idbarbero;

-- 9 Clientes que han cancelado citas
SELECT 'Clientes Cancelan' AS Operacion, U.Nombre, COUNT(C.idCita) AS Citas_Canceladas FROM Usuario U JOIN Cita C ON U.idUsuario = C.Usuario_idUsuarioCli WHERE C.estado_citas_id = 5 GROUP BY U.idUsuario;

-- 10 Ingresos proyectados (Citas confirmadas pero no pagadas aún)
SELECT 'Ingresos Proyect.' AS Operacion, SUM(S.Precio) AS Total_Proyectado FROM Cita C JOIN Servicio S ON C.Servicio_idServicio = S.idServicio WHERE C.estado_citas_id IN (1, 2);

-- 11 Ver las últimas 5 evaluaciones recibidas por un barbero
SELECT eb.Calificacion, eb.Fecha FROM Evaluacion_Barbero eb JOIN Valora v ON eb.idEvaluacion_Bar = v.Evaluacion_Barbero_idEvaluacion_Bar JOIN Cita c ON v.Idvalora = c.Valora_Idvalora WHERE c.barbero_idbarbero = 1 ORDER BY eb.Fecha DESC LIMIT 5;

-- 12 Ver detalles de perfil y ranking actual del barbero
SELECT 'Datos Perfil' AS Seccion, U.Nombre, B.especialidad, B.disponibilidad, B.fotoperfil FROM barbero B JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario WHERE B.idbarbero = 1;

-- 13 Obtener el servicio que más ingresos ha generado
SELECT s.Nombre, SUM(s.Precio) as total FROM Cita c JOIN Servicio s ON c.Servicio_idServicio = s.idServicio WHERE c.estado_citas_id = 4 GROUP BY s.idServicio ORDER BY total DESC LIMIT 1;