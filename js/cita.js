document.addEventListener("DOMContentLoaded", function () {

  const usuario = JSON.parse(localStorage.getItem("usuario"));

  if (!usuario || usuario.rol !== "Barbero") {
    window.location.href = "/html/pantallaInicio.html";
  }

});
//funcion para sacarlo de la pantalla de inicio del barbero cuando se oprime el boton de cerrar secion, se borra el usuario del localStorage y se redirige a la pantalla de inicio



const ctx = document.getElementById('estadoChart');

new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['Completadas', 'Pendientes'],
    datasets: [{
      label: 'Citas del día',
      data: [3, 4],
      backgroundColor: ['#4caf50', '#ff9800'],
      borderColor: '#000',
      borderWidth: 1
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    scales: {
      y: {
        beginAtZero: true,
        ticks: { stepSize: 1 }
      }
    }
  }
});