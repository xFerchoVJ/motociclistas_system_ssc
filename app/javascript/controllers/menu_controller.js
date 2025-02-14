import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["offCanvas"]

  toggle() {
    this.offCanvasTarget.classList.toggle("translate-x-full")
  }
}