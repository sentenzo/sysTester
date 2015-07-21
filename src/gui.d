module gui;

import dlangui;
import dlangui.dialogs.msgbox;
import std.random;

Window window;
MainWidget _mW = null;
@property MainWidget mainWidget() { return MainWidget.getInst(); }

CheckerWidget[] cwArr;

//delegate(Widget w) 

class MainWidget : VerticalLayout {
    Widget _tab1, _tab2;
    public static MainWidget getInst() {
        if(_mW is null) 
            _mW = new MainWidget("mW");
        return _mW;
    }
    private this(string ID) {
        super(ID);
        auto hl = new HorizontalLayout();
        addChild(hl);
        
        auto btnLights = new ImageTextButton("ib0", "48settings");
        btnLights.text = "start";
        
        btnLights.click = delegate(Widget w) {
            cwArr[0].run();
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


class CheckerWidget : HorizontalLayout {
    int state;
    TextWidget status;

    dstring delegate() doCheck; 

    public this(dstring delegate() _doCheck = null) {
        super();
        status = new TextWidget();
        status.text = " ";
        addChild(status);
        if(_doCheck is null)
            doCheck = delegate() {
                return "..."d;
            };
        else 
            doCheck = _doCheck;
    }

    public void run() {
        status.text = doCheck();
    }
}


public static void init() {
    embeddedResourceList
        .addResources(embedResourcesFromList!("resources.list")());
}

public static void showMainWindow() {
    window = Platform.instance
        .createWindow("System check"d, null, WindowFlag.Modal);
    //window
    window.mainWidget = mainWidget;//MainWidget.getInst();//new MainWidget("mw");
    window.onCanClose =  delegate bool() { return true; };
    window.show();
}

uint getRandColor() {
    uint ret = 0xdd000000;
    ret += uniform(0x00, 0xff) * 0x10000;
    ret += uniform(0x00, 0xff) * 0x100;
    ret += uniform(0x00, 0xff);
    return ret;
}