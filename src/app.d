module main;

import dlangui;
import gui;
import conductor;

import luad.all;

mixin APP_ENTRY_POINT;

import std.conv:to;

extern (C) int UIAppMain(string[] args) {
    //Log.setStderrLogger();
    //Log.setLogLevel(LogLevel.Fatal);
    
    gui.init();
    gui.showMainWindow();
    
    gui.mainWidget.addChecks(conductor.getTiles("checks"));
    gui.mainWidget.addSettings(conductor.getTiles("settings"));
    
    auto lua = new LuaState;
    lua.openLibs();
    lua.doString(`out = "Hello, world!";`);
    
    
    gui.mainWidget.dbg_out(to!dstring(lua.globals["out"]));
    
    return Platform.instance.enterMessageLoop();
}



