module gui;

import dlangui;
import std.random;

Window window;
MainWidget _mW = null;
@property MainWidget mainWidget() { return MainWidget.getInst(); }

class MainWidget : VerticalLayout {
    Widget _tab1, _tab2;
    TextWidget _dbg_out;
    public static MainWidget getInst() {
        if(_mW is null) 
            _mW = new MainWidget("mW");
        return _mW;
    }
    private this(string ID) {
        super(ID);
        
        _tab1 = new VerticalLayout("checkTab");
        _tab2 = new VerticalLayout("settingsTab");
        TabWidget tabs = new TabWidget();
        tabs.addTab(_tab1, "Information"d);
        tabs.addTab(_tab2, "Settings"d);
        tabs.selectTab("checkTab");
        
        auto btnRun  = (new Button("btnRun", "Run"d))
            .margins(Rect(20,20,20,20))
                .maxWidth(200);
        auto btnLights = new ImageButton("ib0", "lightOff");
        btnLights.click = delegate(Widget w) {
            switch (platform.instance.uiTheme) {
                case "theme_dark":
                    platform.instance.uiTheme = "theme_default";
                    (cast(ImageWidget)(w)).drawableId = "lightOff";
                    break;
                default:
                    platform.instance.uiTheme = "theme_dark";
                    (cast(ImageWidget)(w)).drawableId = "lightOn";
                    break;
            }
            return true;
        };
        auto btnExit = (new Button("btnExit", "Exit"d))
            .margins(Rect(20,20,20,20))
                .maxWidth(200);
        btnExit.click = delegate(Widget w) {

            window.close();
            
            version(Windows) { //dirty hack for Windows
                window = null;
                window.update(true);
            }
            
			return true;
        };
        HorizontalLayout hlayout = (new HorizontalLayout());
        hlayout.addChild(btnRun);
        hlayout.addChild(btnLights);
        hlayout.addChild(btnExit);
        
        _dbg_out = new TextWidget("dbg_out", "TextWidget dbg_out"d);
        hlayout.addChild(_dbg_out);
        
        addChild(tabs)
            .addChild(hlayout);
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
    
    public void dbg_out(dstring s) {
        _dbg_out.text(s);
    }
}

public static void init() {
    embeddedResourceList
        .addResources(embedResourcesFromList!("resources.list")());
}

public static void showMainWindow() {
    window = Platform.instance
        .createWindow("sysTester", null, WindowFlag.Resizable, 385, 380);
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