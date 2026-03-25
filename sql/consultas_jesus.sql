--pantalla inicio_admin_reportes--

SELECT 
    u.Nombre AS Cliente,
    DATE_FORMAT(c.Fecha_hora, '%h:%i %p') AS Hora,
    DATE_FORMAT(c.Fecha_hora, '%d/%m/%Y') AS Fecha,
    ub.Nombre AS Barbero,
    s.Nombre AS Servicio,
    s.Precio AS Precio,
    CONCAT(s.Duracion, ' min') AS Duracion,
    ec.estado AS Estado
FROM Cita c
JOIN Usuario u ON c.Usuario_idUsuarioCli = u.idUsuario
JOIN Servicio s ON c.Servicio_idServicio = s.idServicio
JOIN estado_citas ec ON c.estado_citas_id = ec.id
JOIN barbero b ON c.barbero_idbarbero = b.idbarbero
JOIN Usuario ub ON b.Usuario_idUsuario = ub.idUsuario
ORDER BY c.Fecha_hora DESC;

--pantalla historial_vista_barbero--

SELECT 
    u.Nombre AS Cliente,
    DATE_FORMAT(c.Fecha_hora, '%d/%m/%y') AS Fecha,
    DATE_FORMAT(c.Fecha_hora, '%h:%i %p') AS Hora_Inicio,
    DATE_FORMAT(
        ADDTIME(c.Fecha_hora, SEC_TO_TIME(s.Duracion * 60)),
        '%h:%i %p'
    ) AS Hora_Fin,
    CONCAT(s.Duracion, ' minutos') AS Duracion,
    s.Nombre AS Servicio,
    s.Precio,
    ec.estado AS Estado
FROM Cita c
JOIN Usuario u ON c.Usuario_idUsuarioCli = u.idUsuario
JOIN Servicio s ON c.Servicio_idServicio = s.idServicio
JOIN estado_citas ec ON c.estado_citas_id = ec.id
WHERE c.barbero_idbarbero = 1
ORDER BY c.Fecha_hora DESC;

--pantalla infCitas--

SELECT 
    c.idCita,
    u.Nombre AS Cliente,
    TIME(c.Fecha_hora) AS Hora,
    s.Nombre AS Servicio,
    e.estado AS Estado,
    s.Precio AS Precio_Estimado
FROM Cita c
INNER JOIN Usuario u 
    ON c.Usuario_idUsuarioCli = u.idUsuario
INNER JOIN Servicio s 
    ON c.Servicio_idServicio = s.idServicio
INNER JOIN estado_citas e 
    ON c.estado_citas_id = e.id
WHERE c.idCita = 1;

--pantalla inicio_barbero_cita--
    --proxima cita del barbero--
    SELECT 
        c.idCita,
        TIME(c.Fecha_hora) AS Hora,
        u.Nombre AS Cliente,
        s.Nombre AS Servicio
    FROM Cita c
    JOIN Usuario u 
        ON c.Usuario_idUsuarioCli = u.idUsuario
    JOIN Servicio s 
        ON c.Servicio_idServicio = s.idServicio
    ORDER BY c.Fecha_hora ASC
    LIMIT 5;

    --citas hoy del barbero--
    SELECT COUNT(*) AS citas_hoy
    FROM Cita
    WHERE DATE(Fecha_hora) = CURDATE();

    -- citas compleasdas del barbero--
    SELECT COUNT(*) AS completadas
    FROM Cita
    WHERE estado = 'completada'
    AND DATE(Fecha_hora) = CURDATE();

    --O--

    SELECT 
    COUNT(*) AS citas_hoy,
    SUM(CASE WHEN estado_citas_id = 4 THEN 1 ELSE 0 END) AS completadas,
    SUM(CASE WHEN estado_citas_id = 1 THEN 1 ELSE 0 END) AS pendientes
    FROM Cita
    WHERE DATE(Fecha_hora) = CURDATE();

--pantalla perfil_info_barbero--
    --llenar los espacios con los datos del barbero--
    SELECT U.Nombre, U.correo, U.telefono, B.fotoperfil FROM barbero B JOIN Usuario U ON B.Usuario_idUsuario = U.idUsuario WHERE B.idbarbero = 1;

    --actualizar la informacion del barbero--
    UPDATE Usuario U JOIN barbero B ON B.Usuario_idUsuario = U.idUsuario SET U.Nombre = 'Nuevo Nombre',U.correo = 'nuevo@email.com',U.telefono = '3001112233' WHERE B.idbarbero = 1;

    --contraseña--
    UPDATE Usuario U
    JOIN barbero B ON B.Usuario_idUsuario = U.idUsuario
    SET U.contrasena = 'nueva_password'
    WHERE B.idbarbero = 1;

    --foto de perfil--
    UPDATE barbero
    SET fotoperfil = 'nueva_foto.jpg'
    WHERE idbarbero = 1;