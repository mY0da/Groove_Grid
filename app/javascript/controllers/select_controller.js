import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select"
export default class extends Controller {
  static targets = ["player", "audioSource"]

  connect() {
  }

  selectSong(event) {
    console.log(event.target.parentElement)
    const songUrl = event.target.parentElement.dataset['url'];
    const songJSON = event.target.parentElement.dataset['song'];
    const songInfo = JSON.parse(songJSON);

    const wavesurfer = document.querySelector('#audio-player').musicPlayer.wavesurfer
    wavesurfer.load(songUrl);
  }
}
