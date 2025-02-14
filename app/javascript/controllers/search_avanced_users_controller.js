import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-avanced-users"
export default class extends Controller {
  static targets = ["search-form"]
  connect() {
  }

  toggleSearch(event){
    event.preventDefault()
    this.element.querySelector("#search_form").classList.toggle("hidden")
  }
}
