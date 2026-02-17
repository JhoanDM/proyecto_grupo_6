let rolSeleccionado = null;

function seleccionarRol(boton) {
    document.querySelectorAll('.roles .BotonDefecto')
        .forEach(btn => btn.classList.remove('activo'));

    boton.classList.add('activo');

    rolSeleccionado = boton.textContent.trim();

    const registro = document.querySelector('.registro');

    if (rolSeleccionado === 'Cliente') {
        registro.style.display = 'block';
    } else {
        registro.style.display = 'none';
    }
}

function iniciarSesion() {

    const correo = document.querySelector('input[type="email"]').value;
    const password = document.querySelector('input[type="password"]').value;

    if (!rolSeleccionado) {
        alert("Selecciona un rol");
        return;
    }

    if (!correo || !password) {
        alert("Completa todos los campos");
        return;
    }

    const usuario = {
        nombre: correo.split("@")[0],
        rol: rolSeleccionado
    };

    localStorage.setItem("usuario", JSON.stringify(usuario));
    //segun el rol seleccionado lo mandara a una pantalla diferente, si es cliente a la pantalla de inicio, si es barbero a su perfil y si es administrador a la pantalla de citas

    if (rolSeleccionado === "Cliente") {
        window.location.href = "/html/pantallaInicio.html";
    }

    else if (rolSeleccionado === "Barbero") {
        window.location.href = "/html/barbero/inicio_barbero_cita.html";
    }

    else if (rolSeleccionado === "Administrador") {
        window.location.href = "/html/admin/inicio_admin_reportes.html";
    }

}


//se elimino la funcion const rol = boton.textContent.trim(); Se eliminó porque era una variable local que no podía ser usada fuera de la funcion, se reemplazo por el let rolSeleccionado = null; esto guarda el rol seleccionado pero si no se selecciona ningun rol, este mandara una alerta, despues de selecionar e iniciar sesion, se guarda el usuario en el localStorage y se redirige a la pantalla de inicio