module logic.checktype.dotnetversion;

import logic;
import std.typecons;

import std.conv:to;

/*
C:\Users\User>reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5"| findstr Install
    Install    REG_DWORD    0x1
    InstallPath    REG_SZ    C:\Windows\Microsoft.NET\Framework64\v3.5\
*/

static class DotNetVersion : CheckLogic {
    static this() {
        LogicList.addLogic!DotNetVersion;
    }
    static string rExStr = 
        `Install\s+REG_DWORD\s+0x1`;
    public static _InitChW getInitInfo() {
        dstring title = ".Net version"d;
        _CheckRunner run_check = delegate() {
            Report r = checkCmd(
                `reg query `
                ~ `"HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5"`
                ~ `| findstr Install`
                , rExStr
            );
            return tuple(r.answer, 
                        to!dstring(r.comments));
        };
        _CheckRunner run_fix = null; 
        return tuple(title, run_check, run_fix);
    }
}
