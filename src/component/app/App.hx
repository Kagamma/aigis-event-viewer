package component.app;

import react.ReactComponent;
import react.ReactMacro.jsx;

import component.board.Board;

class App extends ReactComponent {
	override public function render() {
		return jsx(
			<div>
				<div className='title'>
					Waifu Viewer
				</div>
				<Board />
			</div>
		);
	}
}