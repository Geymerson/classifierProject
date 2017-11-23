import QtQuick 2.9

Item {
    height: elementFieldBox.height + predictionFieldBox.height
    width: 160
    property string elementFieldText: ""
    property string predictionFieldText: ""

    Column {
        width: parent.width
        Rectangle {
            id: elementFieldBox
            width: 150
            height: 30
            color: "#00ff55"
            border.color: "black"
            opacity: 0.7

            Text {
                id: elementField
                text: elementFieldText
                anchors.centerIn: parent
                font.bold: true
                font.italic: true
            }
        }

        Rectangle {
            id: predictionFieldBox
            width: 150
            height: 50
            border.color: "black"
            color: "#7800FF"

            Text {
                id: predictionField
                text: predictionFieldText
                anchors.centerIn: parent
                font.bold: true
            }
        }
    }
}
