module gui;

import dlangui;
import std.random;



static Widget _tab1, _tab2;
static TabWidget _tabs;

public static void init() {
    embeddedResourceList.addResources(embedResourcesFromList!("resources.list")());
    //platform.instance.uiTheme = "theme_dark";
    
    //_tab1 = (new TextWidget("x")).text("checks"d).margins(Rect(20,20,20,20));
    //_tab2 = (new TextWidget("y")).text("settings"d).margins(Rect(20,20,20,20));
    
    _tab1 = new VerticalLayout("checkTab");
    _tab2 = new VerticalLayout("settingsTab");
    
    
    _tabs = new TabWidget();
    _tabs.addTab(_tab1, "Information"d);
    _tabs.addTab(_tab2, "Settings"d);
    
    //_tab1.addChild((new TextWidget("x")).text("checks"d).margins(Rect(20,20,20,20)));
    
    _tabs.selectTab("checkTab");
}


//something terrible below

public static void addChecks(Widget w) {_tab1.addChild(w);}
public static void addChecks(Widget[] w) {foreach (e; w) addChecks(e);}
public static void clearChecks() {_tab1.removeAllChildren(); }

public static void addSettings(Widget w) {_tab2.addChild(w);}
public static void addSettings(Widget[] w) {foreach (e; w) addSettings(e);}
public static void clearSettings() {_tab2.removeAllChildren(); }
//

static Widget _getMainWidget() {
    auto vlayout = new VerticalLayout(); 
    auto hlayout = new HorizontalLayout();
    
    
    
    vlayout.addChild(_tabs);

    auto btnRun  = (new Button("btnRun",  "Run"d           )).margins(Rect(20,20,20,20)).maxWidth(200);
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
        //(platform.instance.uiTheme == "theme_dark") ? (platform.instance.uiTheme = "theme_default") : (platform.instance.uiTheme = "theme_dark");
        return true;
    };
    auto btnExit = (new Button("btnExit", "Exit"d          )).margins(Rect(20,20,20,20)).maxWidth(200);   
    btnRun .alignment(Align.Center).backgroundColor(getRandColor());
    btnExit.alignment(Align.Center).backgroundColor(getRandColor());
     
    hlayout.layoutWidth(FILL_PARENT);
    
    hlayout.addChild(btnRun);
    hlayout.addChild(btnExit);
    
    hlayout.addChild(new ImageTextButton("btn5", "text-plain", "Enabled"d));
    hlayout.addChild(btnLights);
    
    vlayout.addChild(hlayout);
    
    
    vlayout.alignment(Align.HCenter).backgroundColor(getRandColor());
    return vlayout;
}

public static void showMainWindow() {
    Window window = Platform.instance.createWindow("sysTester", null, WindowFlag.Modal || WindowFlag.Resizable, 300, 150);
    window.mainWidget = _getMainWidget();
    window.show();
}

uint getRandColor() {
    uint ret = 0xdd000000;
    ret += uniform(0x00, 0xff) * 0x10000;
    ret += uniform(0x00, 0xff) * 0x100;
    ret += uniform(0x00, 0xff);
    return ret;
}