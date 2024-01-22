import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello Stimulus World!"
    console.log("Hello Stimulus World!")
  }
}
