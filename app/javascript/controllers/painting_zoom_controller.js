import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="painting-zoom"
export default class extends Controller {
  static targets = [ 'modal' ]

  modalAppear() {
    this.modalTarget.classList.remove('disapear')
  }

  modalClose() {
    this.modalTarget.classList.add('disapear')
  }
}
