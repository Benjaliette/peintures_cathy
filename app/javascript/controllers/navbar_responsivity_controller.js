import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-responsivity"
export default class extends Controller {
  static targets = [ 'hamburgerIcon', 'navItems' ]

  toggleDropdown() {
    this.navItemsTarget.classList.toggle('disapear')
    this.hamburgerIconTarget.classList.toggle('fa-bars')
    this.hamburgerIconTarget.classList.toggle('fa-xmark')
  }
}
