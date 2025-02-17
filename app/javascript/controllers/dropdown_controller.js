import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"];

  toggle() {
    // Cerrar otros dropdowns abiertos
    document.querySelectorAll("[data-controller='dropdown']").forEach((element) => {
      if (element !== this.element) {
        element.querySelector("[data-dropdown-target='menu']").classList.add("hidden");
      }
    });

    // Alternar el dropdown actual
    this.menuTarget.classList.toggle("hidden");
  }
}
