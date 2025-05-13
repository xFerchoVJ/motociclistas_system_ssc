import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fisica", "moral"]

  connect() {
    this.toggleFields()
  }

  onChange(event) {
    this.toggleFields()
  }

  toggleFields() {
    const tipo = this.element.querySelector("select").value

    if (tipo === "fisica") {
      this.fisicaTarget.classList.remove("hidden")
      this.moralTarget.classList.add("hidden")
    } else if (tipo === "moral") {
      this.fisicaTarget.classList.add("hidden")
      this.moralTarget.classList.remove("hidden")
    } else {
      this.fisicaTarget.classList.add("hidden")
      this.moralTarget.classList.add("hidden")
    }
  }
}
