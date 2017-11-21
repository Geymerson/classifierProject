import QtQuick 2.0

Item {
    id: mButton
    signal clicked
    property int fontSize: 35
    property string iconSource: ""
    property string text: ""
    height: 50
    width: 50

    Image {
        id: mButtonIcon
        source: mButton.iconSource
        anchors.fill: parent
    }

    Text {
        id: mButtonText
        text: qsTr(mButton.text)
        font.pixelSize: fontSize
        font.bold: true
        font.italic: true
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: mButton.clicked()
    }
}
