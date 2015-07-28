module gui;

import dlangui;
import std.random;

import std.typecons;

Window window;
MainWidget _mW = null;
//@property MainWidget mainWidget() { return MainWidget.getInst(); }

CheckerWidget[] cwArr;

class CheckerWidget : //VerticalLayout { 
TableLayout {
    int _num_check_status = 0;
    int _num_fix_status = 0;
    
    TextWidget tw_title;
    TextWidget tw_checkStatus;
    TextWidget tw_fixStatus;
    Button btn_fix;
    
    alias _CheckRunner = Tuple!(bool, dstring) delegate();
    
    _CheckRunner _run_check;
    _CheckRunner _run_fix;
    
    public this(dstring title
                , _CheckRunner run_check
                , _CheckRunner run_fix = null) {
// ======
// inits
// ======
        super();
        this.colCount = 2;
        tw_title = new TextWidget(null, title);
        tw_checkStatus = new TextWidget(null, "-"d);
        tw_fixStatus = new TextWidget(null, "-"d);
        btn_fix = new Button(null, "fix"d);
        btn_fix.enabled(false);
        _num_check_status = _num_fix_status = 0;
        
        
// ======
// structure
// ======
        // row 1
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
            (new TextWidget(null, "Status:"d))
            .alignment(Align.Right | Align.VCenter)
        );
        
        this.addChild(
            tw_checkStatus
            .alignment(Align.Left | Align.VCenter)
        );
        // row 3
        this.addChild(
            btn_fix
            //.alignment(Align.Right | Align.VCenter)
        );
        this.addChild(
            tw_fixStatus
            .alignment(Align.Left | Align.VCenter)
        );
        
// ======
// styles 
// ======
        this.backgroundColor(getRandColor());
        
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
    
    // debugging purposes
    public this() {
        _CheckRunner run_check = delegate() {
            if(uniform(0,2)) 
                return tuple(true, "dbgChech ::::: True"d);
            else 
                return tuple(false, "dbgChech ::::: False"d);
        };
        _CheckRunner run_fix = delegate() {
            if(uniform(0,2)) 
                return tuple(true, "dbgFix ::::: True"d);
            else 
                return tuple(false, "dbgFix ::::: False"d);
        };
        this("debug check"d, run_check, run_fix);
        //btn_fix.enabled(true);
    }
    
    public void runCheck() {
        auto a = _run_check();
        _num_check_status = a[0]?1:-1;
        tw_checkStatus.text = a[1];
        if(_num_check_status == -1) {
            btn_fix.enabled(true);
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

class MainWidget : VerticalLayout {
    CheckerWidget[] checkList;
    
    VerticalLayout div0_mainContainer;
    ScrollWidget div00_scroller;
    WidgetGroup div000_content;
    HorizontalLayout div01_btnContainer;
    FrameLayout div1_status;
    Button btnStart;
    Button btn2;
    
    public this(string ID) {
// ======
// inits
// ======
        super(ID);
        div0_mainContainer = new VerticalLayout("div0_mainContainer");        
        div00_scroller = new ScrollWidget(null, ScrollBarMode.Auto);
        div000_content = new VerticalLayout();
        div01_btnContainer = new HorizontalLayout("div01_btnContainer");
        div1_status = new FrameLayout("div1_status");
        btnStart = new Button("btnStart", "btnStart"d);
        btn2 = new Button("btn2", "dbg"d);
        
        checkList = new CheckerWidget[8];
        foreach(CheckerWidget check; checkList) {
            check = new CheckerWidget();
            div000_content.addChild(check);
        }
// ======
// structure
// ======
        this.addChild(div0_mainContainer);
            div0_mainContainer.addChild(div00_scroller);
                div00_scroller.contentWidget = div000_content;
            div0_mainContainer.addChild(div01_btnContainer);
                div01_btnContainer.addChild(btnStart);
                div01_btnContainer.addChild(btn2);
        this.addChild(div1_status);
// ======
// styles 
// ======
        this
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        div0_mainContainer
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        div00_scroller
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .layoutHeight(300) // makes height for the app itself
            .backgroundColor(getRandColor());
        div000_content
            .layoutHeight(FILL_PARENT)
            .layoutWidth(500) // makes width for the app itself
            .backgroundColor(getRandColor());
        div01_btnContainer
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        div1_status
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        
// ======
// logic
// ======
        btn2.click = delegate(Widget w) {
            for(int i = 0; i < div000_content.childCount(); i++) {
                CheckerWidget chw 
                    = cast(CheckerWidget)div000_content.child(i);
                chw.runCheck();
            }
            return true;
        };
        
    }
}


public static void init() {
    embeddedResourceList
        .addResources(embedResourcesFromList!("resources.list")());
}

public static void showMainWindow() {
    window = Platform.instance
        .createWindow("System check"d, null, WindowFlag.Modal);

    window.mainWidget = new MainWidget("mW");//mainWidget;
    
    window.show();
}

uint getRandColor() {
    uint ret = 0xdd000000;
    ret += uniform(0x00, 0xff) * 0x10000;
    ret += uniform(0x00, 0xff) * 0x100;
    ret += uniform(0x00, 0xff);
    return ret;
}