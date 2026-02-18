document.addEventListener("DOMContentLoaded", function () {

  const usuario = JSON.parse(localStorage.getItem("usuario"));

  if (!usuario || usuario.rol !== "Barbero") {


  }

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

});