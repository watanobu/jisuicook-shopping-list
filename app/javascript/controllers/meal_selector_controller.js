import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "backdrop",
    "search",
    "listItem",
    "servingsDisplay",
    "form",
    "dateInput",
    "mealTypeInput",
    "recipeInput",
    "servingsInput",
  ]

  static values = {
    planDate: String,
    mealType: String,
    servings: { type: Number, default: 1 },
  }

  connect() {
    this.updateDisplays()
  }

  open(event) {
    event.preventDefault()
    const { mealSelectorPlanDateValue, mealSelectorMealTypeValue } = event.currentTarget.dataset
    this.planDateValue = mealSelectorPlanDateValue
    this.mealTypeValue = mealSelectorMealTypeValue
    this.servingsValue = 1
    this.updateDisplays()
    this.searchTarget.value = ""
    this.filter()
    this.show()
  }

  close(event) {
    if (event) event.preventDefault()
    this.hide()
  }

  increment() {
    this.servingsValue = (this.servingsValue || 1) + 1
    this.updateDisplays()
  }

  decrement() {
    this.servingsValue = Math.max(1, (this.servingsValue || 1) - 1)
    this.updateDisplays()
  }

  filter() {
    const q = this.searchTarget.value.toLowerCase()
    this.listItemTargets.forEach((item) => {
      const name = item.dataset.name || ""
      item.classList.toggle("hidden", !name.includes(q))
    })
  }

  select(event) {
    const recipeId = event.currentTarget.dataset.recipeId || event.target.closest("[data-recipe-id]")?.dataset.recipeId
    if (!recipeId) return
    this.recipeInputTarget.value = recipeId
    this.dateInputTarget.value = this.planDateValue
    this.mealTypeInputTarget.value = this.mealTypeValue
    this.servingsInputTarget.value = this.servingsValue
    this.formTarget.submit()
  }

  show() {
    this.backdropTarget.classList.remove("hidden")
    document.body.classList.add("overflow-hidden")
  }

  hide() {
    this.backdropTarget.classList.add("hidden")
    document.body.classList.remove("overflow-hidden")
  }

  updateDisplays() {
    this.servingsDisplayTarget.textContent = this.servingsValue
  }
}
