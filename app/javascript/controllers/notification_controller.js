import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
  }

  close(){
    this.element.remove()
  }
}
