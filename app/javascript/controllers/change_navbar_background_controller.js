import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-navbar-background"
export default class extends Controller {
  static targets = [
    "principal",
    "secondary",
    "shortLogo",
    "shortItems",
    "mainDropdownList",
    "secondDropdownList",
    "navbarItem",
    "mobile"
   ]

  connect() {
    this.toggle()
  }

  modifyNavbar(e) {
    if(window.innerWidth <= 900) {
      if (window.scrollY > 30) {
        this.mobileTarget.classList.add('box-shadow');
      } else {
        this.mobileTarget.classList.remove('box-shadow');
      }
    } else {
      if (window.scrollY > 30) {
        // Make first navbar disapear to make second navbar apppear (only background for now)
        this.principalTarget.classList.add('disapear');
        this.secondaryTarget.classList.remove('disapear');

        try {
          // Next section is to make the dropdown navbar items disapear when scroll if active
          this.mainDropdownListTarget.classList.add('disapear');
          this.navbarItemTarget.style.background = 'transparent';
          this.navbarItemTarget.style.border = '0px solid black';
        } catch {

        }

        if (window.scrollY > 40) {
          // Here is the second navbar text appearing with smooth transition
          this.shortLogoTarget.classList.add('active');
          this.shortItemsTarget.classList.add('active');
        }
      } else {
        // Make the first navbar re-appearing when scroll up
        this.principalTarget.classList.remove('disapear');
        this.secondaryTarget.classList.add('disapear');
        this.shortLogoTarget.classList.remove('active');
        this.shortItemsTarget.classList.remove('active');

        try {
          // This section is to make the user dropdown disapear when scroll up if active
          this.secondDropdownListTarget.classList.add('disapear');
        } catch {

        }
      }
    }
  }

  toggle() {
    if(window.innerWidth <= 900) {
      this.principalTarget.classList.add('disapear');
      this.secondaryTarget.classList.add('disapear');
      this.mobileTarget.classList.remove('disapear');
    } else {
      this.principalTarget.classList.remove('disapear');
      this.mobileTarget.classList.add('disapear');

      this.modifyNavbar()
    }
  }
}
