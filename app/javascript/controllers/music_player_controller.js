import { Controller } from "@hotwired/stimulus"
import WaveSurfer from 'wavesurfer.js'

// Connects to data-controller="music-player"
export default class extends Controller {

connect() {
  this.audioUrl = ""

  this.element[
    (str => {
      return str
        .split('--')
        .slice(-1)[0]
        .split(/[-_]/)
        .map(w => w.replace(/./, m => m.toUpperCase()))
        .join('')
        .replace(/^\w/, c => c.toLowerCase())
    })(this.identifier)
  ] = this
  this.initializeWaveSurfer();
}

initializeWaveSurfer() {
  // Check if a WaveSurfer instance already exists
  if (this.wavesurfer) {
    this.wavesurfer.destroy();
  }

  this.wavesurfer = WaveSurfer.create({
    container: document.querySelector("#audio-player"),
    waveColor: 'rgb(200, 0, 200)',
    progressColor: 'rgb(100, 0, 100)',
    url: this.audioUrl
  });
}

play() {
  this.wavesurfer.play();
}

pause() {
  this.wavesurfer.pause();
}
}
