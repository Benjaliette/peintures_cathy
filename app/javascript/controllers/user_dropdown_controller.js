import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-dropdown"
export default class extends Controller {
  static targets = [ 'navbarItem', 'navbarItemText', 'dropdownList' ]

  toggleDropdown() {
    this.dropdownListTarget.classList.toggle('disapear');


    try {
      if (this.navbarItemTarget.style.background === 'rgb(219, 208, 192)') {
        this.navbarItemTarget.style.background = 'transparent';
        this.navbarItemTarget.style.border = '0px solid black';
        this.navbarItemTarget.childNodes[1].id = 'account-tab'
      } else {
        this.navbarItemTarget.style.background = '#DBD0C0';
        this.navbarItemTarget.style.boxSizing = 'border-box';
        this.navbarItemTarget.style.border = '1px solid black';
        this.navbarItemTarget.childNodes[1].id = ''
      }
    } catch (error) {
    }



  }

  closeDropdown(event) {
    if(event.target === this.navbarItemTextTarget || event.target === this.navbarItemTarget) {
      console.log('ok')
    } else {
      this.dropdownListTarget.classList.add('disapear');
      this.navbarItemTarget.style.background = 'transparent';
      this.navbarItemTarget.style.border = '0px solid black';
      this.navbarItemTarget.childNodes[1].id = 'account-tab'
    }
  }
}
