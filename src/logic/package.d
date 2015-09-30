// NOTE: How to make this package architecture better??
module logic;

import std.typecons;

import gui:_CheckRunner, _InitChW;
import std.process, std.regex;
import std.file:exists;

// ======
// LogicList base logic
// ======

interface CheckLogic {
    public static _InitChW getInitInfo();
}

interface CheckLogicNoShell {
    public static _InitChW getInitInfoNoShell();
}

class LogicList {
    public static _InitChW[] _list;
    public static _InitChW[] _listNoShell;
    

    public static void addLogic(T:CheckLogic)() { 
        _list ~= T.getInitInfo();
        
        if (is(T == CheckLogicNoShell)) 
            _listNoShell ~= (cast(CheckLogicNoShell)(T)).getInitInfoNoShell();
        else {
            _InitChW ich = T.getInitInfo();
            ich[1] = delegate() {
                return tuple(false
                    , "System shell is unavailable"d);
            };
            ich[2] = null;
            _listNoShell ~= ich;
        }
    }
}

static bool isShellEnabled() {
    try {
        auto cmd = executeShell("time /T");
        return true;
        //return false;
    } catch (Exception e) {
        return false;
    }
}

// ======
// some helpful stuff for checking purposes
// ======

// NOTE: Where to cast string to dstring? Here or in checktype.*?
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

bool fsCheck(string path) {
    return exists(path);
}