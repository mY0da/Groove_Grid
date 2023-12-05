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
    if (!this.wavesurfer) {
      this.audioUrl = "";

      this.wavesurfer = WaveSurfer.create({
        container: document.querySelector("#audio-player"),
        waveColor: '#777DE0',
        progressColor: '#3D44B3',
        url: this.audioUrl
      });

      this.wavesurfer.on('finish', () => {
      });
    }
  }

  play() {
    console.log('play');
    this.wavesurfer.play();
  }

  pause() {
    console.log('pause');
    this.wavesurfer.pause();
  }

  selectSong() {

    if (!this.wavesurfer) {
      this.initializeWaveSurfer();
    }

    if (!this.wavesurfer.isPlaying()) {
      this.wavesurfer.load();
      this.wavesurfer.play();
    }
  }
}
