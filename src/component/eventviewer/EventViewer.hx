package component.eventviewer;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef EventViewerProps = {
    var text: Array<Array<String>>;
}

class EventViewer extends ReactComponentOfProps<EventViewerProps> {
    public function new(props: EventViewerProps) {
        super(props);
    }

    override public function render() {
        var text = [];
        var i: Int = 0;
        for (sentence in props.text) {
            for (s in sentence) {
                text.push(jsx(
                    <div key={i}>{s}</div>
                ));
                text.push(jsx(
                    <br key={i+1} />
                ));
                i += 3;
            }
            text.push(jsx(
                <br key={i+2} />
            ));
        }
        return jsx(
            <div className='eventviewer'>
                {text}
            </div>
        );
    }
}