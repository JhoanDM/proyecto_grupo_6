document.addEventListener("DOMContentLoaded", function () {
  renderAuth();
});

function renderAuth() {
  const zona = document.getElementById("zona-auth");

  if (!zona) return;

  const usuario = JSON.parse(localStorage.getItem("usuario"));

  if (usuario) {

    let rutaPerfil = "";

    if (usuario.rol === "admin") {
      rutaPerfil = "#";
    }
    else if (usuario.rol === "Barbero") {
      rutaPerfil = "/html/barbero/perfil_info_barbero.html";
    }
    else {
      rutaPerfil = "/html/cliente/perfil_cliente.html";
    }

    zona.innerHTML = `
  <a href="${rutaPerfil}" class="me-2 fw-bold text-decoration-none">

    Hola, ${usuario.nombre}
  </a>
  <button class="btn btn-outline-dark activado" onclick="cerrarSesion()">
    Cerrar sesión
  </button>
`;
  }
  else {
    zona.innerHTML = `
      <a href="/html/incio_Sesion/inicioSesion.html" class="btn btn-outline-light me-2 nav-item-login">
        Iniciar Sesión
      </a>
      <a href="/html/incio_Sesion/registro.html" class="btn btn-outline-light nav-item">
        Registrarse
      </a>
    `;
  }
}

function cerrarSesion() {
  localStorage.removeItem("usuario");
  window.location.href = "/html/pantallaInicio.html";
}



//autenticacion del usuario, se agrega el nombre al momento de iniciar sesion, se guarda el rol seleccionado y se muestra en la pantalla de inicio, si no se selecciona ningun rol, se muestra una alerta, al cerrar sesion se elimina el usuario del localStorage y se vuelve a mostrar los botones de iniciar sesion y registrarse