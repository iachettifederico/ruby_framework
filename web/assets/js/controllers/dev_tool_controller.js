import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.translate()

    this.translate = this.translate.bind(this);
    window.addEventListener('resize', this.translate);
  }

  dragEnd(event) {
    sessionStorage.setItem('omashu.xPosition', event.clientX)
    sessionStorage.setItem('omashu.yPosition', event.clientY)

    this.translate()
  }

  translate() {
    let x = 0 + sessionStorage.getItem('omashu.xPosition')
    let y = 0 + sessionStorage.getItem('omashu.yPosition')

    let moveToX = Math.min(x, window.innerWidth - this.element.clientWidth)
    let moveToY = Math.min(y, window.innerHeight - this.element.clientHeight)

    this.element.style.transform = `translate(${moveToX}px, ${moveToY}px)`
  }
}
