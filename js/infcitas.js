    const urlParams = new URLSearchParams(window.location.search);
    const cliente = urlParams.get('cliente');
    const hora = urlParams.get('hora');
    const servicios = urlParams.get('servicios');

    if (cliente) document.getElementById('cliente').innerHTML = '<strong>Cliente:</strong> ' + cliente;
    if (hora) document.getElementById('hora').innerHTML = '<strong>Hora:</strong> ' + hora;
    if (servicios) document.getElementById('servicios').innerHTML = '<strong>Servicios:</strong> ' + servicios;