module gui;

import dlangui;
import std.random;
//import conductor;


 
/*
class AppGUI {
    public static TabWidget tileTabs;
    //public static t
    static this() {
        tileTabs = new TabWidget();
    }
}
*/

TabWidget tabWidget() {
    //CheckTask _ct = new CheckTask("kkkkkkkkkkkkkkkkkkkkk ", delegate LoggedAnswer() {LoggedAnswer la; return la;});
    
    TabWidget wtabs = new TabWidget();
    wtabs.addTab((new TextWidget("x")).text("checks"d).margins(Rect(20,20,20,20)), "Information"d);
    wtabs.addTab((new TextWidget("y")).text("settings"d).margins(Rect(20,20,20,20)), "Settings"d);
    
    
    //wtabs.addTab(makeTile(_ct), "Settings"d);
    wtabs.selectTab("x");

    return wtabs;
}

uint getRandColor() {
    uint ret = 0xdd000000;
    ret += uniform(0x00, 0xff) * 0x10000;
    ret += uniform(0x00, 0xff) * 0x100;
    ret += uniform(0x00, 0xff);
    return ret;
}