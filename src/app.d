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
    
    Widget[] wArr = new Widget[2];
    wArr[0] =  (new TextWidget()).text("checks 0"d);
    wArr[1] =  (new TextWidget()).text("checks 1"d);
    
    //gui.addChecks( (new TextWidget()).text("checks"d) );
    //gui.addChecks(wArr);
    //gui.addSettings((new TextWidget()).text("settings"d) );
    
    gui.mainWidget.addChecks(conductor.getTiles("checks"));
    gui.mainWidget.addSettings(conductor.getTiles("settings"));
    
    return Platform.instance.enterMessageLoop();
}



