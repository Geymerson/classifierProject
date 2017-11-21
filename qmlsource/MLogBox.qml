import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: mLogBoxContainer
    width: 400
    height: 220
    color: "#27A927"
    border.color: "black"

    property string title: ""
    property var text: ""

    Image {
        id: closeIcon
        width: 30
        height: width
        source: "../assets/close.png"
        anchors.right: mLogBoxContainer.right
        anchors.rightMargin: mLogBoxContainer.width * 0.01
        MouseArea {
            anchors.fill: parent
            onClicked: {
                mLogBoxContainer.visible = false
            }
        }
    }

    Column {
        spacing: 15
        width: parent.width

        Text {
            id: logBoxTitle
            text: mLogBoxContainer.title
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        TextArea {
            text: mLogBoxContainer.text
            readOnly: true
            width: parent.width * 0.95
            anchors.horizontalCenter: parent.horizontalCenter
            height: mLogBoxContainer.height * 0.8
            font.bold: true
        }
    }
}
