let datos = [];
let seccionActual= "reporteGeneral";

document.addEventListener("DOMContentLoaded", function () {

    const botones = document.querySelectorAll("nav button");

    botones.forEach(boton => {
        boton.addEventListener("click", function () {

            document.querySelectorAll("nav button")
                .forEach(b => b.classList.remove("active"));

            this.classList.add("active");

            seccionActual = this.dataset.seccion;

            actualizarTitulo();
            cargarArchivo(seccionActual);
            
        });
    });

    actualizarTitulo();
    cargarArchivo("reporteGeneral");
});

function actualizarTitulo() {

    const titulo = document.getElementById("tituloTabla")
    const label = document.getElementById("labelFiltro");

    if (seccionActual === "reporteGeneral") {
        titulo.textContent = "TABLA GENERAL DE REPORTES";
        label.textContent = "Seleccione Cliente:";
    }

    if (seccionActual === "reporteVentas") {
        titulo.textContent = "TABLA DE VENTAS";
        label.textContent = "Fecha:";
    }

    if (seccionActual === "reporteServicios") {
        titulo.textContent = "TABLA DE SERVICIOS";
        label.textContent = "Servicio:";
    }

    if (seccionActual === "reporteBarberos") {
        titulo.textContent = "TABLA DE BARBEROS";
        label.textContent = "Barbero:";
    }
}

function cargarArchivo(nombre) {

    fetch(`/datos/${nombre}.txt`)
        .then(response => response.text())
        .then(texto => {

            const lineas = texto.trim().split("\n");
            datos = lineas.map(linea => linea.split(";"));

            actualizarEncabezados();
            llenarSelect();
            limpiarTabla();
            limpiarGrafico();
        })
        .catch(error => {
            console.error("Error al cargar el archivo:", error);
        });
}

function actualizarEncabezados() {

    const thead = document.querySelector("thead tr");
    thead.innerHTML = "";

    let encabezados = [];

    if (seccionActual === "reporteGeneral") {
        encabezados = ["Cliente", "Hora", "Fecha", "Barbero", "Servicio", "Precio", "Propina", "Metodo de Pago", "Duracion", "Estado", "Observaciones"];
}
    if (seccionActual === "reporteVentas") {
        encabezados = ["Fechas", "Total Servicios", "Total Vendido", "Total Propinas", "Venta Promedio", "Ventas Efectivo", "Ventas Electronicas"];
    }
    
    if (seccionActual === "reporteServicios") {
        encabezados = ["Servicio", "Cantidad Realizada", "Ingreso Total", "% de Demanda", "Tiempo Promedio", "Nivel de Complejidad", "Satisfacción Promedio"];
    }

    if (seccionActual === "reporteBarberos") {
        encabezados = ["Barbero", "Servicios Realizados", "Ingresos Generados", "Propinas Recibidas", "Calificacion Promedio", "Tiempo Total", "Servicios Mejor Calificados", "% Clientes Nuevos", "% Clientes Recurrentes"];
    }

    encabezados.forEach(texto => {
        let th = document.createElement("th");
        th.textContent = texto;
        thead.appendChild(th);
    });

}
function llenarSelect() {
    const select = document.getElementById("clienteSelect");
    select.innerHTML = "<option value=''>Seleccione</option>";

    const valoresUnicos = [...new Set(datos.map(d => d[0]))];

    valoresUnicos.forEach(valor => {
        const option = document.createElement("option");
        option.value = valor;
        option.textContent = valor;
        select.appendChild(option);
    });
}

function cargarDatos() {
    const valorSeleccionado = document.getElementById("clienteSelect").value;
    const tbody = document.getElementById("tablaBody");
    tbody.innerHTML = "";

    let datosFiltrados = datos;

    if (valorSeleccionado !== "") {
        datosFiltrados = datos.filter(d => d[0] === valorSeleccionado);
}

datosFiltrados.forEach(fila => {
    let tr = document.createElement("tr");

    fila.forEach(celda => {
        let td = document.createElement("td");
        td.textContent = celda;
        tr.appendChild(td);
    });

    tbody.appendChild(tr);
});

dibujarGrafico(datosFiltrados);

}

function dibujarGrafico(datosGrafico) {
    const canvas = document.getElementById("grafico");
    const ctx = canvas.getContext("2d");

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    datosGrafico.forEach((dato, i) => {

        let valor = parseInt(dato[dato.length - 1]) || 0;
        let altura = valor / 500;

        ctx.fillStyle = "#0d6efd";
        ctx.fillRect(80 + (i * 80), 200 - altura, 40, altura);
    });
}


function limpiarTabla() {
    document.getElementById("tablaBody").innerHTML = "";
}

function limpiarGrafico() {
    const canvas = document.getElementById("grafico");
    const ctx = canvas.getContext("2d");
    ctx.clearRect(0, 0, canvas.width, canvas.height);
}


function agregarFila() {
    const tbody = document.getElementById("tablaBody");
    const fila = document.createElement("tr");

    fila.innerHTML = `<td colspan="5">Nueva Fila</td>`;
     

    tbody.appendChild(fila);

}

function eliminarFila() {

    const tbody = document.getElementById("tablaBody");

    if (tbody.rows.length > 0) {
        tbody.deleteRow(tbody.rows.length - 1);
    }
}

