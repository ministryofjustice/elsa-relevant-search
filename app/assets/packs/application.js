// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Stylesheets and images
//
import "../stylesheets/application.scss"
require.context("../images", true)
require.context('govuk-frontend/govuk/assets')

// Javascript
//
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"

Rails.start()
Turbolinks.start()

import { initAll } from 'govuk-frontend'
initAll()

import "../javascript/cse";
import "../javascript/ga-events";
