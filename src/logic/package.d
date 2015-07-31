// TODO: [x] Seporate modules for every CheckLogic class
// TODO: How to make this package architecture better??
module logic;

import gui:_CheckRunner, _InitChW;
import std.process, std.regex;

// ======
// LogicList base logic
// ======

interface CheckLogic {
    public static _InitChW getInitInfo();
}

class LogicList {
    public static _InitChW[] _list;
    public static void addLogic(T:CheckLogic)() { 
        _list~=T.getInitInfo(); 
    }
}

// ======
// some helpful stuff for checking purposes
// ======

struct Report {
    bool answer;
    string comments;
}
Report checkCmd(string cmdStr, string rExStr, string rExFlags = "") {
    auto cmd = executeShell(cmdStr);
    if (cmd.status != 0) 
        return Report(false, "failed to execute shell");
    if (!matchFirst(cmd.output, regex(rExStr, rExFlags))) { 
        return Report(false, cmd.output);
    } else {
        return Report(true, cmd.output);
    }
}