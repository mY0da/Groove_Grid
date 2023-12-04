import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="playlist"
export default class extends Controller {
  static values = {
    url: String
  }

  goToUrl(){
    Turbo.visit(this.urlValue)
  }
}
