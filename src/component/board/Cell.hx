package component.board;

import js.Browser;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.ReactDOM;

import component.imageviewer.ImageViewer;

typedef CellProps = {
    var details: utils.Utils.Details;
}

class Cell extends ReactComponentOfProps<CellProps> {
    public function new(props: CellProps) {
        super(props);
    }

	function click() {
        // js.Browser.alert(props.name);
        var popup = Browser.document.getElementsByClassName('popup')[0];
        popup.style.display = 'block';
        ReactDOM.render(jsx(
            <ImageViewer isShow={true} details={props.details}/>
        ), popup);
	}

    override public function render() {
        var imageUrl = 'girls/${props.details.name}/images/${props.details.name}_Icon.png';

        return jsx(
            <div onClick={click}>
                <img className='cell-image' src='${imageUrl}' />
                <div className='cell-name'>
                    {props.details.name}
                </div>
            </div>
        );
    }
}