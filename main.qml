import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

import ia2.project 1.0
import "qmlsource"

Window {

    visible: true
    width: 740
    height: 580
    title: qsTr("Voice Classifier")
    maximumHeight: height
    minimumHeight: height
    maximumWidth: width
    minimumWidth: width

    Item {
        id: mainContainer
        anchors.fill: parent

        TrainningScreen {
            id: trainningScreen
            onModelReadyChanged: {
                if(modelReady == true) {
                    predictionMenuButton.enabled = true
                    predictionMenuButton.opacity = 0.6
                } else {
                    predictionMenuButton.enabled = false
                    predictionMenuButton.opacity = 0.2
                }
            }
        }

        PredictionScreen {
            id: predictionScreen
            visible: false
        }

        Row {
            id: buttons
            anchors.bottom: mainContainer.bottom
            anchors.left: mainContainer.left
            anchors.bottomMargin: 20
            anchors.leftMargin: 20
            spacing: 10

            MButton {
                id: trainningMenuButton
                iconSource: "../assets/knowledge5.png"
                text: "T"

                onClicked: {
                    predictionMenuButton.opacity = 0.4
                    opacity = 1.0
                    predictionScreen.visible = false
                    trainningScreen.visible = true
                }
            }

            MButton {
                id: predictionMenuButton
                iconSource: "../assets/results2.png"
                text: "P"
                enabled: false
                opacity: 0.2
                onClicked: {
                    trainningMenuButton.opacity = 0.4
                    opacity = 1.0
                    trainningScreen.visible = false
                    predictionScreen.visible = true
                }                
            }            
        }       
    }

}
