module lua;

import luad.all;
import std.conv;

import std.file, std.array : replace;

import std.encoding;
import std.windows.charset;

class Config {
    static: 
    LuaState lua;// = new LuaState();
    
    class Testing {
        static: 
        public dstring hello_world_from_string() {
            lua = new LuaState();
            lua.openLibs();
            lua.doString(`out = "Hello, world! (from string val)";`);
            return to!dstring(lua.globals["out"]);
        }
        
        public dstring hello_world_from_file() {
            
            string fName = "tmp.lua";
            
            /*/
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
        
        public T get_out(T = dstring)(string lua_code) {
            lua = new LuaState();
            lua.openLibs();
            lua.doString(lua_code);
            return to!T(lua.globals["out"]);
        }
        
        
        //`C:\\Program Files (x86)\\Notepad++\\notepad++.exe`
        //`bin/libfreetype-6.dll`
        public dstring testing_file_existence(string file_name) {
            string lua_code = `
local file_name = "%file_name%"
local file_found=io.open(file_name, "r")      

if file_found==nil then
    file_found=file_name .. " ... Error - File Not Found"
else
    file_found=file_name .. " ... File Found"
end
out = file_found
            `;
            return get_out(lua_code.replace("%file_name%", file_name));
        }
        
        public dstring testing_dir_existence(string dir_name) {
            string lua_code = `

            `;
            return get_out!dstring(lua_code.replace("%dir_name%", dir_name));
        }
        
        public dstring get_cmd_output(string cmd_text) {
            string lua_code = `
function getCmdOutput(command)
  local ret = "";
  local tmpfile = 'tmp_cmd_out.txt'
  --os.execute('chcp 65001')
  os.execute(command..' > '..tmpfile)
  local f = io.open(tmpfile)
  if not f then return files end  
  for line in f:lines() do
    ret = ret .. line .. "\n"
  end
  f:close()
  os.remove(tmpfile)
  return ret
end
out = getCmdOutput("%cmd_text%")
            `;
            string s = 
            /*/
            get_out!string(lua_code.replace("%cmd_text%", cmd_text))
            /*/
            fixEncoding(
                get_out!string(lua_code.replace("%cmd_text%", cmd_text)),
                866, 65001
            )
            //*/
            ;
            return dtext(s);
            
        }
        
        private string fixEncoding(string s, int cpFrom, int cpTo) {
            auto sToBytes = cast(immutable)toMBSz(s,cpFrom);
            return fromMBSz(sToBytes,cpTo);
        }
    }
}