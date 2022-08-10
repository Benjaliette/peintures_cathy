import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="billing-address-appear"
export default class extends Controller {
  static targets = [ 'yes', 'no', 'addressForm' ]

  addressChoice() {
    if (this.yesTarget.checked) {
      this.addressFormTarget.classList.add('disapear')
    } else if (this.noTarget.checked) {
      this.addressFormTarget.classList.remove('disapear')
    }
  }
}
