module gui.mwidget;

import gui: _CheckRunner, _InitChW, getRandColor;
import gui.checker;

import dlangui;

class MWidget : VerticalLayout {
    //Checker[] checkList;
    
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
        btnStart = new Button("btnStart", "Start"d);
        btn2 = new Button("btn2", "dbg"d);
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
        btnStart.click = delegate(Widget w) {
            for(int i = 0; i < div000_content.childCount(); i++) {
                Checker chw 
                    = cast(Checker)div000_content.child(i);
                chw.runCheck();
            }
            return true;
        };
        
    }
    
    public void addChecker(E...)(E vals) {
        div000_content.addChild(new Checker(vals));
    }
}
