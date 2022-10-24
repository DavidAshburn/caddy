import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
static targets = [ 
  "alert" 
  ]

  connect() {
  }

  close() {
    this.element.remove();
  }
}