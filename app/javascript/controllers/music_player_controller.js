import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="music-player"
export default class extends Controller {
  static targets = ["player", "audioSource"]

  connect() {
    console.log('hello');
  }

  select(event) {
    const songUrl = event.target.parentElement.dataset['url'];
    const songJSON = event.target.parentElement.dataset['song'];
    const songInfo = JSON.parse(songJSON);

    this.audioSourceTarget.src = songUrl;
    this.playerTarget.load();
  }
}
