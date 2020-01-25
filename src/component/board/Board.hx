package component.board;

import json2object.JsonParser;
import react.ReactComponent;
import react.ReactMacro.jsx;
import tink.http.Client;

import component.board.Cell;

typedef BoardState = {
    var data: Dynamic;
}

typedef Data = Array<utils.Utils.Details>;

class Board extends ReactComponentOfState<BoardState> {
    public function new() {
        super();
        state = {
            data: [],
        };
    }

    override public function componentDidMount() {
        Client.fetch('data.json').all().handle(function(o) switch o {
            case Success(res):
                var data = (new JsonParser<Data>()).fromJson(res.body.toString());
                data.sort((a, b) -> {
                    return Reflect.compare(a.name, b.name);
                });
                setState({
                    data: data,
                });
            case Failure(e):
                trace(e);
        });
    }

    override public function render() {
        var uiGirlList = [];

        for (i in 0...state.data.length) {
            uiGirlList.push(jsx(
                <Cell key={i} details={state.data[i]} />
            ));
        }

        return jsx(
            <div className='board'>
                {uiGirlList}
            </div>
        );
    }
}