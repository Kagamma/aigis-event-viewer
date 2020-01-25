package utils;

class Details {
    public var name: String;
    public var hcg: Array<String>;
    public var render: Array<String>;
    public var r18scene: Array<Array<Array<String>>>;
    public var aascene: Array<Array<Array<String>>>;
    public function new(): Void {
        name = '';
        hcg = [];
        render = [];
        r18scene = [];
        aascene = [];
    }
}