// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ChangeNavbarBackgroundController from "./change_navbar_background_controller.js"
application.register("change-navbar-background", ChangeNavbarBackgroundController)

import DisapearFooterController from "./disapear_footer_controller.js"
application.register("disapear-footer", DisapearFooterController)

import DisapearNavbarController from "./disapear_navbar_controller.js"
application.register("disapear-navbar", DisapearNavbarController)

import GenerateBackgroundController from "./generate_background_controller.js"
application.register("generate-background", GenerateBackgroundController)

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)

import UserDropdownController from "./user_dropdown_controller.js"
application.register("user-dropdown", UserDropdownController)
