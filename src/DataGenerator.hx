package;

import sys.io.File;
import sys.FileSystem;
import haxe.Json;
import utils.Utils.Details;

typedef Data = Array<Details>;

class DataGenerator {
    static function readLine(fileName): Array<Array<String>> {
        var fin = File.read(fileName, false);
        var result = [];
        var sentence = [];
        var s = '';
        try {
            while (true) {
                var text = StringTools.trim(StringTools.replace(fin.readLine(), 'TEXT', ''));
                s += text;
                if (text.length > 0) {
                    if (text.indexOf('@') >= 0) {
                        sentence.push(s);
                        s = '';
                    }
                } else {
                    if (s != '') {
                        sentence.push(s);
                        s = '';
                    }
                    if (sentence.length > 0)
                        result.push(sentence);
                    sentence = [];
                };
            }
        } catch (e:haxe.io.Eof) {
            fin.close();
            return result;
        }
    }

    public static function main(): Void {
        var data = new Data();
        // Read girl's name
        var names: Array<String> = FileSystem.readDirectory('./.build/girls');
        for (name in names) {
            var details: Details = new Details();
            details.name = name;
            // Only girls has HCG
            if (FileSystem.exists('./.build/girls/${name}/HCG')) {
                // Read girl's HCG
                details.hcg = FileSystem.readDirectory('./.build/girls/${name}/HCG');
                // Read girl's render
                details.render = FileSystem.readDirectory('./.build/girls/${name}/images').filter((s: String) -> {
                    if (s.indexOf('Render') >= 0) {
                        return true;
                    }
                    return false;
                });
                // R18 scene
                var scenes = FileSystem.readDirectory('./.build/girls/${name}/scenes').filter((s: String) -> {
                    if (s.indexOf('HCG') >= 0) {
                        return true;
                    }
                    return false;
                });
                for (scene in scenes) {
                    var sentences = readLine('./.build/girls/${name}/scenes/${scene}');
                    details.r18scene.push(sentences);
                }
                // AA scene
                scenes = FileSystem.readDirectory('./.build/girls/${name}/scenes').filter((s: String) -> {
                    if (s.indexOf('HCG') < 0) {
                        return true;
                    }
                    return false;
                });
                for (scene in scenes) {
                    var sentences = readLine('./.build/girls/${name}/scenes/${scene}');
                    details.aascene.push(sentences);
                }
                //
                data.push(details);
            }
        }
        // Save data to json
        var json: String = Json.stringify(data);
        File.saveContent('./.build/data.json', json);
    }
}