import { Controller } from "@hotwired/stimulus"

// Adds new ingredient rows from a template without reloading
export default class extends Controller {
  static targets = ["template", "container"]

  addRow() {
    const template = this.templateTarget.innerHTML
    const uniqueId = Date.now().toString()
    const html = template.replace(/NEW_RECORD/g, uniqueId)
    this.containerTarget.insertAdjacentHTML("beforeend", html)
  }
}
