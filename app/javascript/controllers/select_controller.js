import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select"
export default class extends Controller {
  static targets = ["player", "audioSource"]

  connect() {
  }

  selectSong(event) {
    const songUrl = event.target.parentElement.dataset['url'];
    const songJSON = event.target.parentElement.dataset['song'];
    const songInfo = JSON.parse(songJSON);
    const currentlyPlaying = document.querySelector(".currently-playing");
    currentlyPlaying.innerText = songInfo['name'];
    
    const wavesurfer = document.querySelector('#audio-player').musicPlayer.wavesurfer
    wavesurfer.load(songUrl);
  }
}
