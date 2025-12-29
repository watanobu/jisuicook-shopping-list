import { Controller } from "@hotwired/stimulus"

// Preview selected image in-place on the form
export default class extends Controller {
  static targets = ["input", "preview", "area"]

  triggerInput() {
    if (this.inputTarget) this.inputTarget.click()
  }

  preview(event) {
    const [file] = event.target.files || []
    if (!file) return

    const reader = new FileReader()
    reader.onload = e => {
      this.previewTarget.innerHTML = `
        <img src="${e.target.result}" class="w-32 h-32 object-cover rounded-xl shadow mb-3" alt="preview">
        <p class="upload-text text-slate-600">別の写真に差し替える</p>
      `
    }
    reader.readAsDataURL(file)
  }
}
