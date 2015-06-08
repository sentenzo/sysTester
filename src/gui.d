module gui;

import dlangui;
import std.random;

public static void init() {
    embeddedResourceList.addResources(embedResourcesFromList!("resources.list")());
    platform.instance.uiTheme = "theme_dark";
}

static Widget _getMainWidget() {
    auto vlayout = new VerticalLayout(); 
    auto hlayout = new HorizontalLayout();
    
    //vlayout.addChild(wtabs);
    vlayout.addChild(tabWidget());

    auto btnRun  = (new Button("btnRun",  "Run"d           )).margins(Rect(20,20,20,20)).maxWidth(200);
    auto btnExit = (new Button("btnExit", "Exit"d          )).margins(Rect(20,20,20,20)).maxWidth(200);   
    btnRun .alignment(Align.Center).backgroundColor(getRandColor());
    btnExit.alignment(Align.Center).backgroundColor(getRandColor());
     
    hlayout.layoutWidth(FILL_PARENT);
    
    hlayout.addChild(btnRun);
    //hlayout.addChild(new ResizerWidget());
    hlayout.addChild(btnExit);
    
    hlayout.addChild(new ImageTextButton("btn5", "text-plain", "Enabled"d));
    
    vlayout.addChild(hlayout);
    
    
    vlayout.alignment(Align.HCenter).backgroundColor(getRandColor());
    return vlayout;
}

public static void showMainWindow() {
    Window window = Platform.instance.createWindow("sysTester", null, WindowFlag.Resizable, 300, 150);
    window.mainWidget = _getMainWidget();
    window.show();
}

TabWidget tabWidget() {
    //CheckTask _ct = new CheckTask("kkkkkkkkkkkkkkkkkkkkk ", delegate LoggedAnswer() {LoggedAnswer la; return la;});
    
    TabWidget wtabs = new TabWidget();
    wtabs.addTab((new TextWidget("x")).text("checks"d).margins(Rect(20,20,20,20)), "Information"d);
    wtabs.addTab((new TextWidget("y")).text("settings"d).margins(Rect(20,20,20,20)), "Settings"d);
    
    
    //wtabs.addTab(makeTile(_ct), "Settings"d);
    wtabs.selectTab("x");

    return wtabs;
}

uint getRandColor() {
    uint ret = 0xdd000000;
    ret += uniform(0x00, 0xff) * 0x10000;
    ret += uniform(0x00, 0xff) * 0x100;
    ret += uniform(0x00, 0xff);
    return ret;
}