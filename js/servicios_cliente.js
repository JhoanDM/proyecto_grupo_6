const servicios = {
    corte: {
        titulo: "Corte de Cabello",
        duracion: "Duración: 45 minutos",
        precio: "$ 20.000",
        descripcion: "Corte profesional adaptado a tu estilo."
    },
    nino: {
        titulo: "Corte para Niño",
        duracion: "Duración: 40 minutos",
        precio: "$ 18.000",
        descripcion: "Corte moderno y cómodo para los más pequeños."
    },
    tinte: {
        titulo: "Tinte de Cabello",
        duracion: "Duración: 2 horas",
        precio: "$ 60.000",
        descripcion: "Cambio de color profesional con productos de calidad."
    },
    depilacion: {
        titulo: "Depilación",
        duracion: "Duración: 1 hora",
        precio: "$ 30.000",
        descripcion: "Servicio de depilación para una piel suave y cuidada."
    },
    facial: {
        titulo: "Tratamiento Facial",
        duracion: "Duración: 1 hora",
        precio: "$ 50.000",
        descripcion: "Limpieza profunda y revitalización facial."
    },
    capilar: {
        titulo: "Tratamiento Capilar",
        duracion: "Duración: 1 hora",
        precio: "$ 45.000",
        descripcion: "Hidratación y reparación profunda para tu cabello."
    }
};

function mostrarServicio(tipo) {

    document.getElementById("titulo").textContent = servicios[tipo].titulo;
    document.getElementById("duracion").textContent = servicios[tipo].duracion;
    document.getElementById("precio").textContent = servicios[tipo].precio;
    document.getElementById("descripcion").textContent = servicios[tipo].descripcion;

    document.getElementById("detalleServicio").style.display = "block";

    // Scroll automático hacia abajo
    document.getElementById("detalleServicio").scrollIntoView({
        behavior: "smooth"
    });
}
