import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import io.qt.Backend 1.0
import io.qt.AdminConnector 1.0


Window {
    visible: true
    width: 1920
    height: 1080
    visibility: "FullScreen"
    property int __error: 0
    property string _op_msg: ""
    property int mImageToggle: 0

    Backend {
        id: backend
    }
    AdminConnector{
        id: admin
    }

    FontLoader {
        id: fontBold
        source: "font/lotteDreamBold.ttf"
    }
    FontLoader {
        id: fontLight
        source: "font/lotteDreamLight.ttf"
    }


    Image{
        id: imageBackground
        anchors.fill: parent
        source: "image/background.png"


        RightItem{
            id: item_1_1
            x: 1108
            y: 522
            width: 357
            height: 114
        }
        RightItem{
            id: item_1_2
            x: 1108
            y: 635
            width: 357
            height: 114
        }
        RightItem{
            id: item_1_3
            x: 1108
            y: 749
            width: 357
            height: 114
        }

        RightItem {
            id: item_2_1
            x: 1471
            y: 522
            width: 356
            height: 114
        }

        RightItem {
            id: item_2_2
            x: 1471
            y: 635
            width: 356
            height: 114
        }
        
        RightItem {
            id: item_2_3
            x: 1471
            y: 749
            width: 356
            height: 114
        }
    }



    //LEFTTTTTTTTTTTTTTTTTTT
    // Waiting Order & Processing Order =================================================
    function waitingReload(){
        gridViewOrder1.model.clear()
        var num = admin.getLeftSize();
        //        console.log("leftview");
        //        console.log(admin.getRightPin(0,0));
        //        console.log(admin.getRightMenu(0,0));
        //        console.log(admin.getRightStatus(0,0));
        //        console.log("done");

        //        console.log(num)
        if(num >= 6){
            num = 6;
        }
        for(var i = 0; i < num; i++){//리스트의 개수만큼 for문을 돌린다.
            gridViewOrder1.model.append({"pin_text": admin.getLeftPin(i), "menu_text": admin.getLeftMenu(i), "is_making": admin.getLeftIsMaking(i)})
        }
    }

    function maintenance(){
        __error = 0;
        //        console.log("main qml");
        imagePrepare.visible = false;
        rect_error.visible = false;
        //        text_error_1.visible = false;
        //        text_error_2.visible = false;
        //        lnotice.__image = "image/left/left_maintenance.png";
        //        lnotice.show();
    }

    function preoperation(){
        __error = 0;
        //        console.log("preoperation qml");
        imagePrepare.visible = true;
        rect_error.visible = false;
        //        text_error_1.visible = false;
        //        text_error_2.visible = false;
        //        lnotice.__image = "image/left/left_preoperation.png";
        //        lnotice.show();
    }

    function restart(){
        __error = 0;
        //        console.log("restart qml");
        imagePrepare.visible = false;
        rect_error.visible = false;
        //        text_error_1.visible = false;
        //        text_error_2.visible = false;
        //        lnotice.close();
    }

    //    function error(){
    //        __error = 1;
    //        rect_error.visible = true;
    //        text_error_1.visible = true;
    //        text_error_2.visible = true;
    //    }

    Component {//리스트 뷰의 틀을 만든다.
        id: contactDelegateOrder
        Item {
            width: 960//823
            height: 450/6//93

            LeftItem{
                id: gridView_OrderItem
                __pin_text: pin_text
                __menu_text: menu_text
                __is_making: is_making
            }
        }
    }

    ListView {
        id: gridViewOrder1
        x: 62
        y: 452
        width: 960
        height: 450
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.HorizontalFlick
        model: ListModel {
        }
        delegate: contactDelegateOrder
    }

    Rectangle {
        id: rect_error
        x: 0
        y: 0
        width: 1920
        height: 148
        color: "#d90000"

        Text {
            id: text_msg
            x: 0
            y: 0
            color: "#ffffff"
            text: _op_msg
            font.bold: true
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 120
            font.family: fontBold
            styleColor: "#00000000"
        }
    }


    // Completed Order =================================================
    function completedReload(){
        item_1_1.__pin_text = admin.getRightPin(0,0);
        item_1_1.__menu_text = admin.getRightMenu(0,0);
        item_1_1.__outlet_status = admin.getRightStatus(0,0);


        item_1_2.__pin_text = admin.getRightPin(0,1);
        item_1_2.__menu_text = admin.getRightMenu(0,1);
        item_1_2.__outlet_status = admin.getRightStatus(0,1);

        item_1_3.__pin_text = admin.getRightPin(0,2);
        item_1_3.__menu_text = admin.getRightMenu(0,2);
        item_1_3.__outlet_status = admin.getRightStatus(0,2);


        item_2_1.__pin_text = admin.getRightPin(1,0);
        item_2_1.__menu_text = admin.getRightMenu(1,0);
        item_2_1.__outlet_status = admin.getRightStatus(1,0);

        item_2_2.__pin_text = admin.getRightPin(1,1);
        item_2_2.__menu_text = admin.getRightMenu(1,1);
        item_2_2.__outlet_status = admin.getRightStatus(1,1);

        item_2_3.__pin_text = admin.getRightPin(1,2);
        item_2_3.__menu_text = admin.getRightMenu(1,2);
        item_2_3.__outlet_status = admin.getRightStatus(1,2);

    }

    Timer{
        id: imageTimer
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered:{
            _op_msg = admin.getOpMsg();
            text_msg.text = _op_msg;
            if(_op_msg == ""){
                rect_error.visible = false;
                text_msg.visible = false;
                //                text_error_1.visible = false;
                //                text_error_2.visible = false;
            }else{
                if(mImageToggle == 0){
                    mImageToggle = 1;
                }else if(mImageToggle == 1){
                    mImageToggle = 2;
                }else{
                    mImageToggle = 0;
                }

                if(mImageToggle == 0){
                    //                    rect_error.visible = false;
                    text_msg.visible = false;
                }else{
                    rect_error.visible = true;
                    text_msg.visible = true;
                }
            }
        }
    }

    Image {
        id: imagePrepare
        visible: false
        anchors.fill: parent
        source: "image/background_prepare.png"
        fillMode: Image.PreserveAspectFit
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.25}
}
##^##*/
