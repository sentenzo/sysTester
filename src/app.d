module main;

import dlangui;
import gui;
import conductor;

mixin APP_ENTRY_POINT;

extern (C) int UIAppMain(string[] args) {
    //Log.setStderrLogger();
    //Log.setLogLevel(LogLevel.Fatal);
    
    gui.init();
    gui.showMainWindow();
    
    //gui.mainWidget.addChecks(conductor.getTiles("checks"));
    //gui.mainWidget.addSettings(conductor.getTiles("settings"));
    
    return Platform.instance.enterMessageLoop();
}



