module gui;

import dlangui;
import std.random;

import std.typecons;

Window window;
MainWidget _mW = null;
//@property MainWidget mainWidget() { return MainWidget.getInst(); }

CheckerWidget[] cwArr;

class CheckerWidget : VerticalLayout {
    dstring _title = "(check with no name)"d;
    int _num_check_stetus = 0;
    dstring _check_status = "none"d;
    int _num_fix_stetus = 0;
    dstring _fix_status = "none"d;
    
    Tuple!(bool, dstring) delegate() _run_check;
    Tuple!(bool, dstring) delegate() _run_fix;
    
    // debugging purposes
    public this() {
        super();
        
        //logic
        
        _title = "debug check"d;
        
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
        
        
        // gui
        
        addChild(
            (new TextWidget()).text(".---.-...- .-.-..- .-"d)
        );
        
    }
    
    
    
}

class MainWidget : VerticalLayout {
    VerticalLayout div0_mainContainer;
    ListWidget div00_list;
    HorizontalLayout div01_btnContainer;
    FrameLayout div1_status;
    Button btnStart;
    Button btn2;
    
    public this(string ID) {
        super(ID);
        
        // inits
        div0_mainContainer = new VerticalLayout("div0_mainContainer");
        div00_list = new ListWidget();
        div01_btnContainer = new HorizontalLayout("div01_btnContainer");
        div1_status = new FrameLayout("div1_status");
        btnStart = new Button("btnStart", "btnStart"d);
        btn2 = new Button("btn2", "btn2"d);
        
        //structure
        
        this.addChild(div0_mainContainer);
            div0_mainContainer.addChild(div00_list);
            div0_mainContainer.addChild(div01_btnContainer);
                div01_btnContainer.addChild(btnStart);
                div01_btnContainer.addChild(btn2);
        this.addChild(div1_status);
        
        
        // styles
        this
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10));
        div0_mainContainer
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10));
        div00_list
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10));
        div01_btnContainer
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10));
        div1_status
            .padding(Rect(10, 10, 10, 10))
            .margins(Rect(10, 10, 10, 10));
        
    }
}


class MainWidget_old : VerticalLayout {
    Widget _tab1, _tab2;
    /*public static MainWidget_old getInst() {
        if(_mW is null) 
            _mW = new MainWidget_old("mW");
        return _mW;
    }*/
    private this(string ID) {
        super(ID);
        auto hl = new HorizontalLayout();
        addChild(hl);
        
        auto btnLights = new ImageTextButton("ib0", "48settings");
        btnLights.text = "start";
        
        btnLights.click = delegate(Widget w) {
            //cwArr[0].run();
            //addChild(new ImageTextButton("ib1", "lightOn"));
            /*
            window.showMessageBox(
                "Results",
                "Everything is OK!"
            );
            //*/
            //window.showPopup((new TextWidget()).text("hi!"));

            return true;
        };

        //btnLights.padding(Rect(10, 10, 10, 10));
        hl.padding(Rect(10, 10, 10, 10));
        hl.addChild(btnLights);
        ListWidget list = new ListWidget("list1", Orientation.Vertical);
        WidgetListAdapter listAdapter = new WidgetListAdapter();
        list.ownAdapter = listAdapter;
        //list.layoutWidth(FILL_PARENT).layoutHeight(FILL_PARENT);
        
        cwArr = [new CheckerWidget()];

        listAdapter.add(cwArr[0]);
        //*
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        listAdapter.add((new TextWidget()).text("This is a list of widgets"d));
        //*/
        list.layoutWidth(200).layoutHeight(60);
        //list.padding(Rect(10, 10, 10, 10));
        //
        hl.addChild(list);
        //list.addChild((new TextWidget()).text("[1]"));
        //list.addChild((new TextWidget()).text("[2]"));
        //list.addChild((new TextWidget()).text("[3]"));
    }
    public void addChecks(Widget w) { _tab1.addChild(w); }
    public void addSettings(Widget w) { _tab2.addChild(w); }
    public void addChecks(Widget[] w) {
        foreach(Widget e; w)
            addChecks(e);
    }
    public void addSettings(Widget[] w) {
        foreach(Widget e; w)
            addSettings(e);
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