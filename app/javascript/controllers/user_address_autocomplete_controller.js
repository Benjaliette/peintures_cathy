import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="user-address-autocomplete"
export default class extends Controller {
  static targets = [ 'address' ]

  static values = {
    apiKey: String,
    address: String
  }

  connect() {
    const input = document.querySelector("#order_address")

    this.addressTarget.value = this.addressValue
    input.value = this.addressValue

    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      placeholder: this.addressValue
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    const input = document.querySelector("#order_address")

    this.addressTarget.value = event.result["place_name"]
    input.value = event.result["place_name"]
  }

  #clearInputValue() {
    const input = document.querySelector("#order_address")

    this.addressTarget.value = ""
    input.value = ""
  }
}
