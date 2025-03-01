import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="user-registration"
export default class extends Controller {
  static targets = ["seguridadMedica", "divHidden"];

  onChangeSelect(event) {
    console.log(this.divHiddenTarget.hidden);
    
    if (event.target.value !== "Otros") {
      if (!this.divHiddenTarget.hidden) {
        this.divHiddenTarget.hidden = true;
      }
      this.seguridadMedicaTarget.value = event.target.value;
    } else {
      this.seguridadMedicaTarget.value = "";
      this.divHiddenTarget.hidden = false;
    }
  }
}
