module logic.checktype.sqlsvrversion;

import logic;
import std.typecons;

import std.conv:to;

static class SqlSvrVersion : CheckLogic, CheckLogicNoShell {
    static this() {
        LogicList.addLogic!SqlSvrVersion;
    }
    static dstring title = "SQL Server version"d;

    // MS SQL Server 2005, 2008(R2), 2012
    // http://sqlserverbuilds.blogspot.ru/
    
    
    
    static string rExStr = 
        `9\.0|10\.5|11\.`;
    public static _InitChW getInitInfo() {
        _CheckRunner run_check = delegate() {
            dstring comm = "";
            bool ans = false;
            if(findRegSqlVersion("90"))
                comm ~= "MSSQLServer2005 ";
            if(findRegSqlVersion("100"))
                comm ~= "MSSQLServer2008 ";
            if(findRegSqlVersion("110"))
                comm ~= "MSSQLServer2012 ";
            
            return tuple(comm.length>0, 
                        to!dstring(comm));
        };
        _CheckRunner run_fix = null; 
        return tuple(title, run_check, run_fix);
    }
    
    private static bool findRegSqlVersion(string minorVersion) {
        Report r = checkCmd(
            `reg query `
            ~ `"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\`
            ~ minorVersion ~ `\Tools\ClientSetup\CurrentVersion"`
            ~ `| findstr CurrentVersion`
            , `REG_SZ`
        );
        return r.answer;
    }

    public static _InitChW getInitInfoNoShell() {
        _CheckRunner run_check = delegate() {
            return tuple(false, 
                        to!dstring("System shell is unavailable"));
        };
        _CheckRunner run_fix = null; 
        return tuple(title, run_check, run_fix);
    }
}
