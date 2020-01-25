package component.imageviewer;

import js.Browser;
import react.ReactComponent;
import react.ReactMacro.jsx;

import component.eventviewer.EventViewer;

typedef ImageViewerProps = {
	var isShow: Bool;
	var details: utils.Utils.Details;
}

typedef ImageViewerState = {
	var isShow: Bool;
	var tab: Int;
	var folder: String;
	var isR18Event: Bool;
	var isAAEvent: Bool;
	var aa: Int;
}

class ImageViewer extends ReactComponentOf<ImageViewerProps, ImageViewerState> {
	public function new(props: ImageViewerProps) {
		super(props);
		state = {
			isShow: props.isShow,
			tab: 0,
			folder: 'images',
			isR18Event: false,
			isAAEvent: false,
			aa: 0,
		};
	}

	function btnCloseClick() {
        var popup = Browser.document.getElementsByClassName('popup')[0];
		popup.style.display = 'none';
		setState({
			isShow: false,
			folder: 'images',
			tab: 0,
		});
	}

	function btnTabClick(tab: Int, folder: String) {
		setState({
			tab: tab,
			folder: folder,
			isR18Event: false,
			isAAEvent: false,
		});
	}

	function btnViewR18Event() {
		setState({
			isR18Event: !state.isR18Event,
			isAAEvent: false,
		});
	}

	function btnViewAAEvent(aa: Int) {
		setState({
			isR18Event: false,
			isAAEvent: state.aa != aa ? true : !state.isAAEvent,
			aa: aa,
		});
	}

	function renderName(name: String): String {
		if (name.indexOf('AW_') >= 0) {
			return 'AW';
		} else
		if (name.indexOf('AW2_') >= 0) {
			return 'AW2';
		} else
		if (name.indexOf('AW2v1_') >= 0) {
			return 'AW2v1';
		} else
		if (name.indexOf('AW2v2_') >= 0) {
			return 'AW2v2';
		}
		return 'Normal';
	}

	override function componentWillReceiveProps(next: ImageViewerProps) {
		setState({
			isShow: next.isShow,
			isR18Event: false,
			isAAEvent: false,
			aa: 0,
		});
	}

	override public function render() {
		var result = null;
		var imageUrl = 'girls/${props.details.name}/${state.folder}/';
		var event = null;
		var eventButton = [];
		var tabs = [];

		switch (state.folder) {
			case 'HCG':
				imageUrl += props.details.hcg[state.tab];
			default:
				imageUrl += props.details.render[props.details.render.length - state.tab - 1];
		}
		for (i in 0...props.details.render.length) {
			tabs.push(jsx(
				<div className='tablinks' key={i} onClick={() -> btnTabClick(i, 'images')}>
					{renderName(props.details.render[props.details.render.length - i - 1])}
				</div>
			));
		}
		for (i in 0...props.details.hcg.length) {
			tabs.push(jsx(
				<div className='tablinks' key={i + 10} onClick={() -> btnTabClick(i, 'HCG')}>HCG {i+1}</div>
			));
		}
		if (state.folder == 'HCG') {
			eventButton.push(jsx(
				<div className='button' key={110} onClick={btnViewR18Event}>
					Event (R18)
				</div>
			));
			if (state.isR18Event && props.details.r18scene.length >= state.tab + 1) {
				event = jsx(
					<EventViewer text={props.details.r18scene[state.tab]} />
				);
			}
		} else {
			for (i in 0...props.details.aascene.length) {
				eventButton.push(jsx(
					<div className='button' key={120 + i} onClick={() -> btnViewAAEvent(i)}>
						Event {i + 1} (AA)
					</div>
				));
			}
			if (state.isAAEvent) {
				event = jsx(
					<EventViewer text={props.details.aascene[state.aa]} />
				);
			}
		}
		eventButton.push(jsx(
			<div className='button' key={140} onClick={btnCloseClick}>
				Close
			</div>
		));
		if (state.isShow) {
			result = jsx(
				<div className='imageviewer'>
					<div className="tab">
						{tabs}
					</div>
					<img className='imageviewer-image' src='${imageUrl}' />
					<div className='imageviewer-footer'>
						{eventButton}
					</div>
					{event}
				</div>
			);
		}
		return result;
	}
}