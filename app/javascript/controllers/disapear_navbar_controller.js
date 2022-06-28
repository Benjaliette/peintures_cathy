import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disapear-navbar"
export default class extends Controller {
  connect() {
    const navbar = document.querySelector('.navbar');
    const mainContainer = document.querySelector('.main-container');
    navbar.remove();
    mainContainer.classList.remove("main-container")
  }
}
