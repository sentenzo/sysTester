/* 
    #TODO: Make it work with optional debugging version 
        (to turn on/off all the dbg backgroundColor in gui.d)
*/
module main;

import dlangui;
import gui;
import logic;

//import logic.ldbg;

mixin APP_ENTRY_POINT;

extern (C) int UIAppMain(string[] args) {
    //Log.setStderrLogger();
    //Log.setLogLevel(LogLevel.Fatal);
    
    gui.init();
    
    foreach(_InitChW x; logic.LogicList._list) {
        gui.addCheck(x);
    }
    
    gui.showMainWindow();
    return Platform.instance.enterMessageLoop();
}



