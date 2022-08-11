import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="footer-responsivity"
export default class extends Controller {
  static targets = [ 'footer' ]

  connect() {
    this.toggle()
  }

  toggle() {
    if(window.innerWidth <= 900) {
      this.footerTarget.classList.add('disapear');
    } else {
      this.footerTarget.classList.remove('disapear')
    }
  }
}
