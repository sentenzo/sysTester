module gui.checker;

import gui: _CheckRunner, _InitChW, getRandColor;

import std.algorithm.iteration:each;

import dlangui;
import std.random;

import std.typecons;

class Checker : TableLayout {
    int _num_check_status = 0;
    int _num_fix_status = 0;
    
    TextWidget tw_title;
    TextWidget tw_checkStatus;
    TextWidget tw_fixStatus;
    Button btn_fix;
    
    ImageWidget iw_title;
    ImageWidget iw_checkStatus;
    ImageWidget iw_fixStatus;
    
    _CheckRunner _run_check;
    _CheckRunner _run_fix;
    
    public this(dstring title
                , _CheckRunner run_check
                , _CheckRunner run_fix = null) {
// ======
// inits
// ======
        super();
        this.colCount = 3;
        tw_title = new TextWidget(null, title);
        tw_checkStatus = new TextWidget(null, "-"d);
        tw_fixStatus = new TextWidget(null, "-"d);
        btn_fix = new Button(null, "fix"d);
        btn_fix.enabled(false);
        _num_check_status = _num_fix_status = 0;
        iw_title = (new ImageWidget());
            //.drawableId("information-button"); 
        iw_checkStatus = (new ImageWidget())
            .drawableId("gear_16"); 
        iw_fixStatus = (new ImageWidget());
            //.drawableId("information-button"); 
        
        
// ======
// structure
// ======
        // row 1
        this.addChild(
            iw_title
        );
        this.addChild(
            (new TextWidget(null, "Title:"d))
            .alignment(Align.Right | Align.VCenter)
        );
        this.addChild(
            tw_title
            .alignment(Align.Left | Align.VCenter)
        );
        // row 2
        this.addChild(
            iw_checkStatus
        );
        this.addChild(
            (new TextWidget(null, "Status:"d))
            .alignment(Align.Right | Align.VCenter)
        );
        this.addChild(
            tw_checkStatus
            .alignment(Align.Left | Align.VCenter)
        );
        if(!(run_fix is null)) {
            // row 3
            this.addChild(
                iw_fixStatus
            );
            this.addChild(
                btn_fix
                //.alignment(Align.Right | Align.VCenter)
            );
            this.addChild(
                tw_fixStatus
                .alignment(Align.Left | Align.VCenter)
            );
        }
        
// ======
// styles 
// ======
        this.backgroundColor(getRandColor());
        ([iw_title, iw_checkStatus, iw_fixStatus])
            .each!(x => x.alignment(Align.Center));

// ======
// logic
// ======
        _run_check = run_check;
        _run_fix = run_fix;
        btn_fix.click = delegate(Widget w) {
            this.runFix();
            return true;
        };
    }
    
    public this(_InitChW inChW) {
        this(inChW[0], inChW[1], inChW[2]);
    }
    
    // debugging purposes
    public this() {
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
        this("debug check"d, run_check, run_fix);
        //btn_fix.enabled(true);
    }
    
    public void runCheck() {
        auto a = _run_check();
        _num_check_status = a[0]?1:-1;
        tw_checkStatus.text = a[1];
        if(_num_check_status == -1 && !(_run_fix is null)) {
            btn_fix.enabled(true);
        } else {
            btn_fix.enabled(false);
        }
        return;
    }
    public void runFix() {
        auto a = _run_fix();
        _num_fix_status = a[0]?1:-1;
        tw_fixStatus.text = a[1];
        return;
    }
    
}