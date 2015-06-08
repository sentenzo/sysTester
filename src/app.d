//module main;

import dlangui;
import gui;
//import logic;

mixin APP_ENTRY_POINT;

extern (C) int UIAppMain(string[] args) {
    //Log.setStderrLogger();
    //Log.setLogLevel(LogLevel.Fatal);


    //SystemCheck sch0 = new SystemCheck("test", "ver");
    //sch0.run();
    
    embeddedResourceList.addResources(embedResourcesFromList!("resources.list")());
    platform.instance.uiTheme = "theme_dark";
    
    
    Window window = Platform.instance.createWindow("Tester", null, WindowFlag.Resizable, 300, 150);
    
    
    
    
    /*
    
    TabWidget wtabs = new TabWidget();
    //wtabs.addTab((new TextWidget("x")).text(std.conv.dtext(sch0.information().info)).margins(Rect(20,20,20,20)), "Information"d);
    wtabs.addTab((new TextWidget("x")).text("checks"d).margins(Rect(20,20,20,20)), "Information"d);
    wtabs.addTab((new TextWidget("y")).text("settings"d).margins(Rect(20,20,20,20)), "Settings"d);
    wtabs.selectTab("x");
    //wtabs.removeTab("MOREe");    
    
    //*/
    
    
    auto vlayout = new VerticalLayout(); 
    auto hlayout = new HorizontalLayout();
    //vlayout.addChild((new TextWidget()).text("пример HorizontalLayout:"d).margins(Rect(20,20,20,20)));
    
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
    

    window.mainWidget = vlayout;

    window.show();

    // run message loop
    return Platform.instance.enterMessageLoop();
}



