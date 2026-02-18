document.addEventListener("DOMContentLoaded", function () {

    const modal = document.getElementById("terminosModal");
    const botonAceptar = document.getElementById("btnAceptarTerminos");

    
    modal.addEventListener("shown.bs.modal", function () {

       
        const contenedor = modal.querySelector(".modal-body div");

     
        botonAceptar.disabled = true;
        contenedor.scrollTop = 0;

        contenedor.addEventListener("scroll", function () {

            const scrollTop = contenedor.scrollTop;
            const totalHeight = contenedor.scrollHeight;
            const visibleHeight = contenedor.clientHeight;

        
            if (scrollTop + visibleHeight >= totalHeight - 2) {
                botonAceptar.disabled = false;
            }

        });

    });

});