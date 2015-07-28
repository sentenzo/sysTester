// TODO: [x] Seporate modules for every CheckLogic class
// TODO: How to make this package architecture better??
module logic;


import gui:_CheckRunner, _InitChW;


import std.process;

import std.regex;
import std.conv;
import std.random;




interface CheckLogic {
    public static _InitChW getInitInfo();
}


class LogicList {
    public static _InitChW[] _list;
    public static void addLogic(T:CheckLogic)() { _list~=T.getInitInfo(); }
}

