import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-upload"
export default class extends Controller {
  static targets = [ 'overview', 'image' ]

  connect() {
    const uploadButton = document.querySelector('.upload-button')
    uploadButton.addEventListener('change', event => this.addFile(event))
  }

  addFile(event) {
    const file = `
      <li>Nom: ${event.srcElement.files[0].name}</li>
      <li>Taille: ${Math.round(event.srcElement.files[0].size / 1000)} ko</li>`

    this.overviewTarget.insertAdjacentHTML('beforeend', file)
    this.imageTarget.remove()
  }
}
