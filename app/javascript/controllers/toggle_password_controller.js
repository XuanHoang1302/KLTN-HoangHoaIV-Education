import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-password"
export default class extends Controller {
  static targets = ["show", "hide", "unhide"];

  password() {
    if (this.passwordHidden) {
      this.hideTarget.style.display = 'none';
      this.showTarget.style.display = 'block';
      this.input.type = "text";
    } else {
      this.hideTarget.style.display = 'block';
      this.showTarget.style.display = 'none';
      this.input.type = "password";
    }
  }

  get value() {
    return this.showTarget;
  }

  get input() {
    return this.unhideTarget;
  }

  get passwordHidden() {
    return this.input.type == 'password';
  }

  get hiddenClass() {
    return this.data.get('hiddenClass');
  }
}
