module lua;

import luad.all;
import std.conv:to;

import std.file, std.array : replace;

class Config {
    static: 
    LuaState lua;// = new LuaState();
    
    public dstring hello_world_from_string() {
        lua = new LuaState();
        lua.openLibs();
        lua.doString(`out = "Hello, world! (from string val)";`);
        return to!dstring(lua.globals["out"]);
    }
    
    public dstring hello_world_from_file() {
        
        string fName = "tmp.lua";
        
        /*
        std.file.write(
            fName
            , cast(byte[])([0xef, 0xbb, 0xbf]) // byte order mark (BOM) for Unicode
        ); 
        std.file.append(fName, `out = "Hello, world! (from file)";`);
        /*/
        std.file.write(fName, `out = "Hello, world! (from file) (а ещё, Lua может в русский!)";`);
        //*/
        
        scope(exit) std.file.remove(fName);
        
        lua = new LuaState();
        lua.openLibs();
        lua.doFile(fName);
        return  //"testing"d;
                to!dstring(lua.globals["out"]);
    }
}