import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	connect() {
		this.element.textContent = "\"What do you call a bear caught in the rain?\" (click)"
	}

	handleClick() {
		this.element.textContent = "\"A drizzly bear!\""
	}
}
