module main;

import dlangui;
import gui;
import conductor;

mixin APP_ENTRY_POINT;

import lua;

extern (C) int UIAppMain(string[] args) {
    //Log.setStderrLogger();
    //Log.setLogLevel(LogLevel.Fatal);
    
    gui.init();
    gui.showMainWindow();
    
    gui.mainWidget.addChecks(conductor.getTiles("checks"));
    gui.mainWidget.addSettings(conductor.getTiles("settings"));
    
    //auto lua = new LuaState();
    //lua.openLibs();
    //lua.doString(`out = "Hello, world!";`);
    
    
    gui.mainWidget.dbg_out(lua.Config.Testing.get_cmd_output(`ls -1`));
    
    return Platform.instance.enterMessageLoop();
}



