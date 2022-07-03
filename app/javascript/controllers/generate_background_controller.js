import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="generate-background"
export default class extends Controller {
  static targets = [ ]

  connect() {
    const mainContainer = document.querySelector('.main-container')

    mainContainer.style.backgroundImage = "url(<%= asset_path 'user_bg.svg' %>)"
  }
}
