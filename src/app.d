module main;

import dlangui;
import gui;

mixin APP_ENTRY_POINT;

extern (C) int UIAppMain(string[] args) {
    //Log.setStderrLogger();
    //Log.setLogLevel(LogLevel.Fatal);
    
    gui.init();
    gui.showMainWindow();
    return Platform.instance.enterMessageLoop();
}



