import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["backdrop", "message"]
  static values = { message: String }

  connect() {
    this.pendingForm = null
    this.pendingLink = null
  }

  ask(event) {
    event.preventDefault()
    this.pendingForm = event.target.form || event.target.closest("form")
    this.pendingLink = event.target.closest("a")
    this.messageTarget.textContent = this.messageValue || "本当に削除しますか？"
    this.backdropTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  cancel(event) {
    if (event) event.preventDefault()
    this.hide()
  }

  confirm(event) {
    if (event) event.preventDefault()
    const form = this.pendingForm
    const link = this.pendingLink
    this.hide()
    if (form) {
      form.submit()
    } else if (link) {
      link.click()
    }
  }

  hide() {
    this.backdropTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
    this.pendingForm = null
    this.pendingLink = null
  }
}
