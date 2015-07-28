/* 
    #TODO: Make it work with optional debugging version 
        (to turn on/off all the dbg backgroundColor in gui.d)
*/
module main;

import dlangui;
import gui;
import logic;

mixin APP_ENTRY_POINT;

extern (C) int UIAppMain(string[] args) {
    //Log.setStderrLogger();
    //Log.setLogLevel(LogLevel.Fatal);
    
    gui.init();
    gui.showMainWindow();
    
    gui.addCheck(logic.LDbg.getInitInfo);
    
    
    //*
    gui.addCheck();
    gui.addCheck(logic.LDbg.getInitInfo);
    gui.addCheck();
    gui.addCheck();
    gui.addCheck();
    //*/
    
    return Platform.instance.enterMessageLoop();
}



