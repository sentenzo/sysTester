module logic;

import std.typecons;
import std.process;

import std.regex;
import std.conv;

struct LoggedAnswer {
    dstring log;
    bool answer;
}

class CheckTask {
    private:
        dstring _name;
        dstring _info;
        State _state;
    protected:
        enum Status {
            Init,
            Passed,
            Fixable,
            Failed
        }
        struct State {
            dstring info;
            Status status;
            bool stuck;
        }
        
        
        LoggedAnswer delegate() _checker = null;
        LoggedAnswer delegate() _fixer = null;
        
        
    public:
        this(dstring name, LoggedAnswer delegate() checker, LoggedAnswer delegate() fixer = null) {
            _name = name;
            _checker = checker;
            _fixer = fixer;
            _state.info = "..."d;
            _state.status = Status.Init;
            _state.stuck = false;
        }
        dstring getName()      { return _name; }
        dstring getInfo()      { return _info; }
        
        void    run() { 
            LoggedAnswer la;
            switch(_state.status) {
                case Status.Init:
                    la = _checker();
                    _state.info = la.log;
                    if(la.answer) {
                        _state.status = Status.Passed;
                        _state.stuck = true;
                    } else {
                        if (_fixer == null) {
                            _state.status = Status.Failed;
                            _state.stuck = true;
                        } else {
                            _state.status = Status.Fixable;
                        }
                    }
                    break;
                case Status.Passed:
                    _state.stuck = true;
                    break;
                case Status.Fixable:
                    la = _fixer();
                    _state.info = la.log;
                    if(la.answer) {
                        _state.status = Status.Passed;
                        _state.stuck  = true;
                    } else {
                        _state.status = Status.Failed;
                        _state.stuck = true;
                    }
                    break;
                case Status.Failed:
                    _state.stuck = true;
                    break;
                default:
                    _state.info = "Finite-state machine error!"d;
                    _state.stuck = true;
                    break;
            }
            return; 
        } 
}
