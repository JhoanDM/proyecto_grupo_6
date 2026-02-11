    const urlParams = new URLSearchParams(window.location.search);
    const cliente = urlParams.get('cliente') || 'Desconocido';
    const hora = urlParams.get('hora') || '00:00';
    const servicios = urlParams.get('servicios') || 'Sin especificar';

    document.getElementById('cliente').innerHTML = '<strong>Cliente:</strong> ' + cliente;
    document.getElementById('hora').innerHTML = '<strong>Hora:</strong> ' + hora;
    document.getElementById('servicios').innerHTML = '<strong>Servicios:</strong> ' + servicios;