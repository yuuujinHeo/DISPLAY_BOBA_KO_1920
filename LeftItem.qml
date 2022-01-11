import QtQuick 2.0

Item {
    property string __pin_text: "00001"
    property string __menu_text: "블랙티"
    property bool __is_making: false

    id: leftItemOrder
    width: 960//823
    height: 450/6//93

    Text {
        x: 0
        y: 0
        width: 216
        height: 75
        color: "#ffffff"
        text: __pin_text
        font.family: fontLight.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pixelSize: 35
    }

    Text {
        x: 222
        y: 0
        width: 493
        height: 75
        color: "#ffffff"
        text: __menu_text
        font.family: fontLight.name
        verticalAlignment: Text.AlignVCenter
        minimumPixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pixelSize: 30
    }

    Rectangle {
        x: 824
        y: 18
        width: 40
        height: 40
        radius: 25
        border.width: 5
        border.color: "#ffffff"
        color: __is_making ? "#ffffff" : "transparent"
    }



}
