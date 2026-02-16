let registros = [];

document.addEventListener("DOMContentLoaded", () => {
    fetch("reporteGeneral.txt")
    .then(response => response.text())
    .then(texto => {
        procesarTXT(texto);
        llenarSelectClientes();
        });
    });


function procesarTXT(texto) {
    const lineas = texto.trim().split("\n");

    registros = lineas.map(linea => {
        const datos = linea.split(";");
        return {
            Cliente: datos[0],
            Hora: datos[1],
            Fecha: datos[2],
            Barbero: datos[3],
            Servicio: datos[4],
            Precio: parseInt(datos[5]),
            Propina: parseInt(datos[6]),
            MetodoDePago: datos[7],
            Duracion: datos[8],
            EstadoDelServicio: datos[9],
            Observaciones: datos[10]
        };
    });
}


function llenarSelectClientes() {
    const select = document.getElementById("clienteSelect");
    const clientesUnicos = [...new Set(registros.map(r => r.Cliente))];

    clientesUnicos.forEach(Cliente => {
        const option = document.createElement("option");
        option.value = Cliente;
        option.textContent = Cliente;
        select.appendChild(option);
    });
}


function cargarTXT() {
    const cliente = document.getElementById("clienteSelect").value;
    const tbody = document.getElementById("tablaBody");
    tbody.innerHTML = "";

    if (!cliente)  return;

    const datosCliente = registros.filter(r => r.Cliente === Cliente);

    datosCliente.forEach(d => {
        const fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${d.Cliente}</td>
            <td>${d.Hora}</td>
            <td>${d.Fecha}</td>
            <td>${d.Barbero}</td>
            <td>${d.Servicio}</td>
            <td>${d.Precio}</td>
            <td>${d.Propina}</td>
            <td>${d.MetodoDePago}</td>
            <td>${d.Duracion}</td>
            <td>${d.EstadoDelServicio}</td>
            <td>${d.Observaciones}</td>
        `;

        tbody.appendChild(fila);
    });
    
    dibujarGrafico(datosCliente);
}

function agregarFila() {
    const tbody = document.getElementById("tablaBody");
    const fila = document.createElement("tr");

    fila.innerHTML = `
        <td>Cliente nuevo</td>
        <td>00:00</td>
        <td>--/--/----</td>
        <td>Barbero</td>
        <td>Servicio</td>
        <td>$0</td>
        <td>$0</td>
        <td>Metodo de pago</td>
        <td>0</td>
        <td>Pendiente</td>
        <td>Observaciones</td>
    `;

    tbody.appendChild(fila);

}

function eliminarFila() {
    const tbody = document.getElementById("tablaBody");
    if (tbody.ariaRowSpan.length > 0) {
        tbody.deleteRow(tbody.ariaRowSpan.length - 1);
    } else {
        alert("No hay filas para eliminar");
    }
}

function dibujarGrafico(datos) {
    const canvas = document.getElementById("grafico");
    const ctx = canvas.getContext("2d");

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    datos.forEach((d, index) => {
        const altura = d.precio/500;
        ctx.fillStyle = "blue";
        ctx.fillRect(60 + index * 80, 180 - altura, 40, altura);
    });
}