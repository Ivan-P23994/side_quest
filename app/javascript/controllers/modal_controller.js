// This controller is an edited-to-the-essentials version of the modal component created by @excid3 as part of the essential tailwind-stimulus-components package found here:
// https://github.com/excid3/tailwindcss-stimulus-components

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
static targets = ['container'];
static values = {
  backdropColor: { type: String, default: 'rgba(0, 0, 0, 0.8)' },
  restoreScroll: { type: Boolean, default: true }
}

  connect() {
    this.toggleClass = 'hidden';
    this.backgroundId = 'modal-background';
    this.backgroundHtml = this._backgroundHTML();
    
    this.allowBackgroundClose = (this.data.get('allowBackgroundClose') || 'true') === 'true';
  }

  disconnect() {
    this.close();
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.close()
    }
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.close()
    }
  }

  closeBackground(e) {
    if (this.allowBackgroundClose && e.target === this.containerTarget) {
      this.close(e);
    }
  }

  open() {
    document.body.classList.add('fixed', 'inset-x-0', 'overflow-hidden');
    this.containerTarget.classList.remove(this.toggleClass);
    document.body.insertAdjacentHTML('beforeend', this.backgroundHtml);
    this.background = document.querySelector(`#${this.backgroundId}`);
  }

  close(event) {
    if (typeof event !== 'undefined') {
      event.preventDefault()
    }
    this.containerTarget.classList.add(this.toggleClass);
    if (this.background) { this.background.remove() }
    this.unlockScroll();
  }

  _backgroundHTML() {
    return `<div id="${this.backgroundId}" class="fixed top-0 left-0 w-full h-full" style="background-color: rgba(0, 0, 0, 0.7); z-index: 9998;"></div>`;
  }

  lockScroll() {
    const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth;
    document.body.style.paddingRight = `${scrollbarWidth}px`;

    document.body.classList.add('fixed', 'inset-x-0', 'overflow-hidden');

    if(this.restoreScrollValue) {
      this.saveScrollPosition();
      
      document.body.style.top = `-${this.scrollPosition}px`;
    }
  }

  unlockScroll() {
    document.body.style.paddingRight = null;

    document.body.classList.remove('fixed', 'inset-x-0', 'overflow-hidden');

    if(this.restoreScrollValue) {
      this.restoreScrollPosition();
      
      document.body.style.top = null;
    }
  }

  saveScrollPosition() {
    this.scrollPosition = window.pageYOffset || document.body.scrollTop;
  }

  restoreScrollPosition() {
    if (this.scrollPosition === undefined) return;

    document.documentElement.scrollTop = this.scrollPosition;
  }
}
