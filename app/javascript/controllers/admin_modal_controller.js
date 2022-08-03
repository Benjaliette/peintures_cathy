import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin-modal"
export default class extends Controller {
  static targets = [ 'editModal', 'deleteModal' ]

  editModalAppear() {
    this.editModalTarget.classList.remove('disapear')
  }

  deleteModalAppear() {
    this.deleteModalTarget.classList.remove('disapear')
  }

  modalClose() {
    this.editModalTarget.classList.add('disapear')
    this.deleteModalTarget.classList.add('disapear')
  }
}
