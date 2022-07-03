import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disapear-footer"
export default class extends Controller {
  connect() {
    const footer = document.querySelector('.footer');
    footer.remove();
  }
}
