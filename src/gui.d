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
    static __objCount = 0;
    //dstring _title = "(check with no name)"d;
    int _num_check_stetus = 0;
    //dstring _check_status = "none"d;
    int _num_fix_stetus = 0;
    //dstring _fix_status = "none"d;
    
    TextWidget tw_title;
    TextWidget tw_checkStatus;
    TextWidget tw_fixStatus;
    Button btn_fix;
    
    Tuple!(bool, dstring) delegate() _run_check;
    Tuple!(bool, dstring) delegate() _run_fix;
    
    // debugging purposes
    public this() {
        __objCount++;
        // inits
        super("id_" ~ to!string(__objCount));
        this.colCount = 2;
        tw_title = new TextWidget(null, "debug check"d);
        tw_checkStatus = new TextWidget(null, "none"d);
        tw_fixStatus = new TextWidget(null, "none"d);
        btn_fix = new Button(null, "fix"d);
        //btn_fix.enabled(false);
        _num_check_stetus = _num_fix_stetus = 0;
        
        
        // gui
        this.backgroundColor(getRandColor());
        

        //this.addChild(new Button(null, "teeeeest"d));
        
        //*
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
        /*
        ComboBox combo1 = new ComboBox(null
                                    , ["item value 1"d, "item value 2"d
                                    , "item value 3"d, "item value 4"d
                                    , "item value 5"d, "item value 6"d]);
        combo1.selectedItemIndex = 3;
        this.addChild(combo1);
        /*/
        this.addChild(
            tw_fixStatus
            .alignment(Align.Left | Align.VCenter)
        );
        //*/
        
        //logic
        _run_check = delegate() {
            if(uniform(0,1)) 
                return tuple(true, "dbgChech:True"d);
            else 
                return tuple(false, "dbgChech:False"d);
        };
        _run_fix = delegate() {
            if(uniform(0,1)) 
                return tuple(true, "dbgFix:True"d);
            else 
                return tuple(false, "dbgFix:False"d);
        };
        btn_fix.click = delegate(Widget w) {
            auto a = _run_fix();
            _num_fix_stetus = a[0];
            tw_fixStatus.text = a[1];
            return true;
        };
        
    }
    
    
    
}

class MainWidget : VerticalLayout {
    CheckerWidget[] checkList;
    
    VerticalLayout div0_mainContainer;
    ListWidget div00_list;
    WidgetListAdapter listAdapter;
    HorizontalLayout div01_btnContainer;
    FrameLayout div1_status;
    Button btnStart;
    Button btn2;
    
    public this(string ID) {
        // inits
        super(ID);
        div0_mainContainer = new VerticalLayout("div0_mainContainer");
        div00_list = new ListWidget();
        listAdapter = new WidgetListAdapter();
        div01_btnContainer = new HorizontalLayout("div01_btnContainer");
        div1_status = new FrameLayout("div1_status");
        btnStart = new Button("btnStart", "btnStart"d);
        btn2 = new Button("btn2", "btn2"d);
        
        checkList = new CheckerWidget[10];
        
        //listAdapter.add(new Button(null, "teeeeest"d));
        foreach(CheckerWidget check; checkList) {
            check = new CheckerWidget();
            listAdapter.add(check);
            //listAdapter.add(new Button(null, "teeeeest"d));
        }
        
        //listAdapter.resetItemState(0, State.Enabled);
        
        
        //structure
        this.addChild(div0_mainContainer);
            div0_mainContainer.addChild(div00_list);
                div00_list.ownAdapter = listAdapter;
            div0_mainContainer.addChild(div01_btnContainer);
                div01_btnContainer.addChild(btnStart);
                div01_btnContainer.addChild(btn2);
        this.addChild(div1_status);
        
        // styles
        this
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        div0_mainContainer
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        div00_list
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .layoutHeight(300).layoutWidth(350)
            .backgroundColor(getRandColor());
        div01_btnContainer
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        div1_status
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10))
            .backgroundColor(getRandColor());
        
        
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