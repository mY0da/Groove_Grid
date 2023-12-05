import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="playlist"
export default class extends Controller {
  connect() {
    this.element.addEventListener("click", this.redirect.bind(this));
  }

  redirect() {
    const path = this.element.dataset.path;
    if (path) {
      // Navigate to the specified path
      window.location.href = path;
    }
  }
}
