import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"];

  connect() {
    document.addEventListener("click", this.closeDropdown.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.closeDropdown.bind(this));
  }

  toggle(event) {
    event.stopPropagation();
    this.menuTarget.classList.toggle("hidden");
    this.menuTarget.classList.toggle("transition-transform");
    this.menuTarget.classList.toggle("duration-200");
    this.menuTarget.classList.toggle("ease-in-out");
    this.menuTarget.classList.toggle("transform");
    this.menuTarget.classList.toggle("scale-95");
  }

  closeDropdown(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }
}
