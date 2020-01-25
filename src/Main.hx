package;

import react.ReactDOM;
import react.ReactMacro.jsx;
import js.Browser;

import component.app.App;

class Main {
	public static function main() {
		var wrapper = Browser.document.createElement('div');
		Browser.document.body.appendChild(wrapper);

		var popup = Browser.document.createElement('div');
		popup.classList.add('popup');
		Browser.document.body.appendChild(popup);

		ReactDOM.render(jsx(<App/>), wrapper);
	}
}