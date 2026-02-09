function seleccionarRol(boton) {
    document.querySelectorAll('.roles .BotonDefecto').forEach(btn => {btn.classList.remove('activo');
    });

boton.classList.add('activo');

const rol = boton.textContent.trim();

const registro = document.querySelector('.registro');

if (rol === 'Cliente') {
    registro.style.display = 'block';
} else {
    registro.style.display = 'none';
}

}