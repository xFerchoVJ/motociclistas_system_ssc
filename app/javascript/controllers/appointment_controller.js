import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="appointment"
export default class extends Controller {
  static targets = ["fecha", "hora", "horaSelect", "fechaHelp", "horaError"];
  static values = {
    disabledDates: Array,
    availableTimesUrl: String
  };

  connect() {
    if (this.fechaHelpTarget.value !== "") {
      fetchAvailableTimes();
      this.horaSelectTarget.disabled = false;
    }else{
      this.horaSelectTarget.disabled = true;
    }
  }

  async fetchAvailableTimes() {
    const selectedDate = this.fechaTarget.value;
    if (!selectedDate) {
      // Si no hay fecha seleccionada, mostrar el mensaje de error
      this.horaErrorTarget.classList.remove("hidden");
      return;
    }

    if (this.disabledDatesValue.includes(selectedDate)) {
      alert("No hay horarios disponibles en esta fecha, elige otro día.");
      this.fechaTarget.value = "";
      this.horaSelectTarget.innerHTML = ""; // Limpiar el select
      this.horaSelectTarget.disabled = true; // Deshabilitar el select
      this.horaTarget.value = ""; // Limpiar valor de la hora seleccionada
      this.fechaHelpTarget.classList.remove("hidden"); // Mostrar mensaje de ayuda
      this.horaErrorTarget.classList.add("hidden"); // Ocultar mensaje de error
    } else {
      const res = await fetch(
        `${this.availableTimesUrlValue}?fecha=${selectedDate}`
      );
      const data = await res.json();
      console.log(data);

      // Limpiar el select
      this.horaSelectTarget.innerHTML = "";

      // Añadir la opción inicial
      const defaultOption = document.createElement("option");
      defaultOption.value = "";
      defaultOption.textContent = "Selecciona una hora";
      this.horaSelectTarget.appendChild(defaultOption);

      // Generar opciones para las horas disponibles
      data.available_times.forEach((time) => {
        const option = document.createElement("option");
        option.value = time;
        option.textContent = time;
        this.horaSelectTarget.appendChild(option);
      });

      // Habilitar el select
      this.horaSelectTarget.disabled = false;

      // Ocultar el mensaje de ayuda y el mensaje de error
      this.fechaHelpTarget.classList.add("hidden");
      this.horaErrorTarget.classList.add("hidden");

      // Manejar la selección de la hora
      this.horaSelectTarget.addEventListener("change", () => {
        this.horaTarget.value = this.horaSelectTarget.value;
      });
    }
  }
}