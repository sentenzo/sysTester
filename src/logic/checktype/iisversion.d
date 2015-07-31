module logic.checktype.iisversion;

import logic;
import std.typecons;

import std.conv:to;

/* 
reg query 
"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp"| 
findstr VersionString
*/

static class IisVersion : CheckLogic {
    static this() {
        LogicList.addLogic!IisVersion;
    }
    static string rExStr = 
        `\s6(\.\d)?|\s7(\.\d)?|\s8(\.\d)?|\s9(\.\d)?`;
    // version >= 6
    public static _InitChW getInitInfo() {
        dstring title = "IIS version"d;
        _CheckRunner run_check = delegate() {
            Report r = checkCmd(
                `reg query `
                ~ `"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\InetStp"`
                ~ `| findstr VersionString`
                , rExStr
            );
            return tuple(r.answer, 
                        to!dstring(r.comments));
        };
        _CheckRunner run_fix = null; 
        return tuple(title, run_check, run_fix);
    }
}
