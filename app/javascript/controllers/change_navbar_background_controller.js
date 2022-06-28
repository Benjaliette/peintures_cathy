import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-navbar-background"
export default class extends Controller {
  static targets = [ "principal", "secondary", "shortLogo", "shortItems" ]

  connect() {
  }

  modifyNavbar(e) {
    if (window.scrollY > 30) {
      this.principalTarget.classList.add('disapear');
      this.secondaryTarget.classList.remove('disapear');
      if (window.scrollY > 40) {
        this.shortLogoTarget.classList.add('active');
        this.shortItemsTarget.classList.add('active');
      }
    } else {
      this.principalTarget.classList.remove('disapear');
      this.secondaryTarget.classList.add('disapear');
      this.shortLogoTarget.classList.remove('active');
      this.shortItemsTarget.classList.remove('active');
    }
  }
}
