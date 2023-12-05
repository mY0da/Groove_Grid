// button_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button"
export default class extends Controller {
    toggle() {
        const dropdownId = this.element.dataset.target;
        toggleDropdown(dropdownId);
    }
}
