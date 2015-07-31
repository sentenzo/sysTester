module logic.checktype.osversion;

import logic;
import std.typecons;

import std.conv:to;


/*
C:\Users\User>wmic os get Caption,CSDVersion /value


Caption=Microsoft Windows 7 Home Premium
CSDVersion=Service Pack 1
*/
static class OsVersion : CheckLogic {
// NOTE: This rExStr rule needs to be checked 
    static string rExStr = 
        `Windows ([7,8]|XP Professional|Server (2003|2008 R2|2012))`;
/*
Windows 7
Windows 8
Windows XP Professional
Windows Server 2008 R2
Windows Server 2003
Windows Server 2012
*/
    static this() {
        LogicList.addLogic!OsVersion;
    }
    public static _InitChW getInitInfo() {
        dstring title = "OS version"d;
        _CheckRunner run_check = delegate() {
            Report r = checkCmd(
                "wmic os get Caption,CSDVersion /value"
                , rExStr
                , "i" // Case insensitive matching
            );
            return tuple(r.answer, 
                        to!dstring(r.comments));
        };
        _CheckRunner run_fix = null; 
        return tuple(title, run_check, run_fix);
    }
}


