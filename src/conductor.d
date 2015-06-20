module conductor;

import dlangui;
import logic;
import gui;
import std.json;
import std.conv;

import std.file, std.array : replace;

static immutable string defConfFileName = "sysTester.config.json";

static immutable string defJsonStr = `{
    "checks": 
    [
        {
            "name": "checkTest0",
            "checkCmd": "date /t",
            "checkMask": "dd\\.dd\\.dddd"
        },
        {
            "name": "checkTest0",
            "checkCmd": "date /t",
            "checkMask": "dd\\.dd\\.dddd"
        },
        {
            "name": "checkTest0",
            "checkCmd": "date /t",
            "checkMask": "dd\\.dd\\.dddd"
        },
        {
            "name": "checkTest1",
            "checkCmd": "time /t",
            "checkMask": "dd\\:dd"
        }
    ],
    "settings": 
    [
        {
            "name": "settingTest0",
            "checkCmd": "time /t",
            "checkMask": "dd\\:d[02468]",
            "settCmd": "time /t",
            "settMask": "dd\\:d[02468]"
        }
    ]
}`;

public Widget[] getTiles(string sectionName) {
    JSONValue j = parseJSON(
        exists(defConfFileName) ?
        to!string(read(defConfFileName))[3..$] :
        ({ 
            std.file.write(
                defConfFileName
                , cast(byte[])([0xef, 0xbb, 0xbf]) // byte order mark (BOM) for Unicode
            ); 
            std.file.append(defConfFileName, defJsonStr);
            return defJsonStr;
        })() 
        // functional functionality :D
    );
    auto jArr = j[sectionName].array;
    Widget[] ret = new Widget[jArr.length];
    for(int i=0; i<jArr.length; i++)
        ret[i] = makeTile(jArr[i]);
    return ret;
}


private Widget makeTile(JSONValue node) {
    auto ds = delegate dstring (string s) { return to!dstring(node[s].str).replace(`\/`, `/`); };
    auto s  = delegate string  (string s) { return to!string(node[s].str).replace(`\/`, `/`); };
    //logic.CheckTask cht = new CheckTask(ds("name"), null);
    logic.CheckTask cht = new CheckTask(ds("name"), s("checkCmd"), s("checkMask"));
    Widget tName = (new TextWidget()).text(cht.getName());
    Widget tInfo = (new EditLine()).readOnly(true).text(cht.getInfo());
    ImageButton iButton = new ImageButton("ib0", "folder");
    iButton.click = delegate(Widget w) {
        cht.run();
        tInfo.text(cht.getInfo());
        return true;
    };
    
    
    
    HorizontalLayout hla = new HorizontalLayout();
    VerticalLayout vla = new VerticalLayout();
    hla.addChild(tName);
    hla.addChild(iButton);
    vla.addChild(hla);
    vla.addChild(tInfo);
    
    return vla;
}
