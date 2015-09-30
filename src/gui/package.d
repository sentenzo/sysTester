module gui;

import gui.checker, gui.mwidget;

import dlangui;
import std.random;

import std.typecons;

Window window;
MWidget _mW = null;
//@property MWidget MWidget() { return MWidget.getInst(); }

alias _CheckRunner = Tuple!(bool, dstring) delegate();
//return type for logic module methods to init ChW with one arg
alias _InitChW = Tuple!(dstring, _CheckRunner, _CheckRunner);

public static void init() {
    embeddedResourceList
        .addResources(embedResourcesFromList!("resources.list")());

    window = Platform.instance
        .createWindow("System check"d, null, WindowFlag.Modal);
    _mW = new MWidget("mW"); //mainWidget
    window.mainWidget = _mW;
    window.windowIcon = drawableCache
        .getImage("information_shless_32");
}

public static void showMainWindow() {
    window.show();
}

public static addCheck(E...)(E vals) {
    _mW.addChecker(vals);
}

uint getRandColor() {
    uint ret = 0xdd000000;
    ret += uniform(0x00, 0xff) << 4; //* 0x10000;
    ret += uniform(0x00, 0xff) << 2; //* 0x100;
    ret += uniform(0x00, 0xff);
    return ret;
}