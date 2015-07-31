module logic.checktype.dbg;

import logic;

import std.typecons;
import std.random;

//*
static class LDbg : CheckLogic {
    static this() {
        /*LogicList.addLogic!LDbg;
        //*
        LogicList.addLogic!LDbg;
        LogicList.addLogic!LDbg;
        LogicList.addLogic!LDbg;
        LogicList.addLogic!LDbg;
        LogicList.addLogic!LDbg;
        //*/
    }
    public static _InitChW getInitInfo() {
        dstring title = "class LDbg : CheckLogic"d;
        _CheckRunner run_check = delegate() {
            if(uniform(0,2)) 
                return tuple(true, "dbgChech ::::: True"d);
            else 
                return tuple(false, "dbgChech ::::: False"d);
        };
        _CheckRunner run_fix = null; //not all the checks are fixable
        if(uniform(0,2)) {
            run_fix = delegate() {
                if(uniform(0,2)) 
                    return tuple(true, "dbgFix ::::: True"d);
                else 
                    return tuple(false, "dbgFix ::::: False"d);
            };
        }
        return tuple(title, run_check, run_fix);
    }
}

//*/