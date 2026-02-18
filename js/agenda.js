const monthYearElement = document.getElementById('monthYear');
const datesElement = document.getElementById('dates');
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');

let currentDate = new Date();
let selectedDate = null;

const renderTimeSlots = () => {
    const timeGrid = document.getElementById('timeGrid');
    const selectedDateTitle = document.getElementById('selected-date-title');

    if (!selectedDate) {
        selectedDateTitle.textContent = 'Selecciona un día';
        timeGrid.innerHTML = '';
        return;
    }

    selectedDateTitle.textContent = `Horarios para el ${selectedDate.getDate()} de ${currentDate.toLocaleString('default', { month: 'long', year: 'numeric' })}`;
    timeGrid.innerHTML = '';

    const start = 10;
    const end = 15.5;

    for (let t = start; t <= end; t += 0.5) {
        const h = Math.floor(t);
        const m = t % 1 === 0 ? "00" : "30";
        const period = h >= 12 ? 'PM' : 'AM';
        const hour12 = h % 12 || 12;
        const timeStr = `${hour12}:${m} ${period}`;

        const slot = document.createElement('div');
        slot.className = 'time-slot';
        slot.innerText = timeStr;
        slot.onclick = () => {
            document.querySelectorAll('.time-slot').forEach(s => s.classList.remove('selected'));
            slot.classList.add('selected');
        };
        timeGrid.appendChild(slot);
    }
};

const updateCalendar = () => {
    const currentYear = currentDate.getFullYear();
    const currentMonth = currentDate.getMonth();

    const firstDay = new Date(currentYear, currentMonth, 1);
    const lastDay = new Date(currentYear, currentMonth + 1, 0);
    const totalDays = lastDay.getDate();
    const firstDayIndex = firstDay.getDay();
    const lastDayIndex = lastDay.getDay();

    const monthYearString = currentDate.toLocaleString('default', { month: 'long', year: 'numeric' });
    monthYearElement.textContent = monthYearString;

    let datesHTML = '';

    const prevDays = (firstDayIndex - 1 + 7) % 7;
    for (let i = prevDays; i > 0; i--) {
        const prevDate = new Date(currentYear, currentMonth, 1 - i);
        datesHTML += `<div class="date inactive">${prevDate.getDate()}</div>`;
    }

    for (let i = 1; i <= totalDays; i++) {
        const date = new Date(currentYear, currentMonth, i);
        const activeClass = date.toDateString() === new Date().toDateString() ? 'active' : '';
        const selectedClass = selectedDate && date.toDateString() === selectedDate.toDateString() ? 'selected' : '';
        datesHTML += `<div class="date ${activeClass} ${selectedClass}" data-date="${date.toISOString()}">${i}</div>`;
    }

    const totalCells = prevDays + totalDays;
    const nextDays = (7 - (totalCells % 7)) % 7;
    for (let i = 1; i <= nextDays; i++) {
        const nextDate = new Date(currentYear, currentMonth + 1, i);
        datesHTML += `<div class="date inactive">${nextDate.getDate()}</div>`;
    }

    datesElement.innerHTML = datesHTML;

    if (selectedDate && (selectedDate.getMonth() !== currentDate.getMonth() || selectedDate.getFullYear() !== currentDate.getFullYear())) {
        selectedDate = null;
        renderTimeSlots();
    }

    document.querySelectorAll('.date:not(.inactive)').forEach(dateEl => {
        dateEl.addEventListener('click', () => {
            const dateStr = dateEl.getAttribute('data-date');
            selectedDate = new Date(dateStr);
            updateCalendar();
            renderTimeSlots();
        });
    });
};

prevBtn.addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() - 1);
    updateCalendar();
});

nextBtn.addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() + 1);
    updateCalendar();
});

updateCalendar();