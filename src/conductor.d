module conductor;

import dlangui;
import logic;
import gui;
import std.json;
import std.conv;


string jsonStr = `
{
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
}
`;



public Widget[] getTiles(string sectionName) {
    JSONValue j = parseJSON(jsonStr);
    auto jArr = j[sectionName].array;
    Widget[] ret = new Widget[jArr.length];
    for(int i=0; i<jArr.length; i++)
        ret[i] = makeTile(jArr[i]);
    return ret;
}

private Widget makeTile(JSONValue node) {
    logic.CheckTask cht = new CheckTask(to!dstring(node["name"]), null, null);
    Widget tName = (new TextWidget()).text(cht.getName());
    Widget tInfo = (new EditLine()).readOnly(true).text(cht.getInfo());
    ImageButton iButton = new ImageButton("ib0", "folder");
    
    HorizontalLayout hla = new HorizontalLayout();
    VerticalLayout vla = new VerticalLayout();
    hla.addChild(tName);
    hla.addChild(iButton);
    vla.addChild(hla);
    vla.addChild(tInfo);
    
    return vla;//(new TextWidget()).text(to!dstring(node["name"].str()));
}



/*
Widget makeTile(CheckTask ct) {
    auto hlayout = new HorizontalLayout("title");
    auto name = (new TextWidget()).text(ct.getName()).minWidth(2000);
    auto icone = (new ImageWidget("y", "39down")).padding(Rect(5,5,5,5)).alignment(Align.Center);
    
    hlayout.addChild(name);
    hlayout.addChild(icone);
    return hlayout.backgroundColor(getRandColor());
}*/