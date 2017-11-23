import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

import ia2.project 1.0


Rectangle {
    id: predictionScreenContainer
    anchors.fill: parent
    color: "#3399ff"

    Text {
        id: predictiontitle
        text: qsTr("Prediction")
        font.pixelSize: 30
        font.bold: true
        color: "white"
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: parent.height * 0.02
        }
    }

    // Flickable area so the elements
    //Can be draged on the screen
    Flickable {
        id: flickArea
        width: predictionScreenContainer.width
        height: predictionScreenContainer.height * 0.7
        contentHeight: predictionScreenContainer * 0.8
        contentWidth: predictionScreenContainer.width
        anchors.top: predictiontitle.bottom
        anchors.topMargin: parent.height * 0.02
        clip: true

        Column {
            spacing: 10
            anchors.fill: parent

            //Rectangle for selecting
            //the dataset
            Rectangle {
                id: myPredictionDataSet
                width: flickArea.width * 0.8
                height: flickArea.height * 0.2
                color: predictionScreenContainer.color
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter


                Text {
                    text: "Data for prediction"
                    font.pixelSize: 18
                    font.bold: true
                    anchors.left: myPredictionDataSet.left
                    anchors.leftMargin: myPredictionDataSet.width * 0.02
                }

                Label {
                    id: myPredictionDataSetLabel
                    text: "/path/to/file"
                    anchors.verticalCenter: myPredictionDataSet.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: myPredictionDataSet.width * 0.1

                    property string filePath: ""
                }

                Image {
                    id: loadPredictionDataButton
                    width: 40
                    height: width
                    source: "../assets/loadData3.png"
                    anchors {
                        right: parent.right
                        rightMargin: predictionScreenContainer.width * 0.02
                        verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        onClicked: predictionFileDialog.visible = true
                        anchors.fill: parent
                    }
                }
            }

            //Rectangle for viewing
            //the prediction results
            Rectangle {
                id: dataPredictionOverview
                width: flickArea.width * 0.8
                height: flickArea.height * 0.3
                color: predictionScreenContainer.color
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    width: parent.width
                    spacing: 15

                    Text {
                        text: "Prediction results"
                        font.pixelSize: 18
                        font.bold: true
                        anchors.left: parent.left
                        anchors.leftMargin: dataPredictionOverview.width * 0.02
                    }

                    Text {
                        id: dataPredictionOverviewInfoText
                        text: "Some prediction results of the data you want to predict will appear here."+
                              " In order to\nmake predictions, previous trainning is required"+
                              " for generating the prediction model."
                        anchors.left: parent.left
                        anchors.leftMargin: myPredictionDataSet.width * 0.02
                    }                    

                    GridView {
                        id: view
                        width: 470
                        height: 600
                        anchors.horizontalCenter: parent.horizontalCenter
                        clip: true
                        cellWidth: width/3
                        cellHeight: 100
                        delegate: numberDelegate
                        visible: false
                    }
                }
            }
        }
    }


    Component {
        id: numberDelegate

        MGridCell {
            elementFieldText: (index + 1) + "º Prediction"
            predictionFieldText: predictionMediator.predictionAt(index)
        }
    }

    Mediator {
        id: predictionMediator
        onPredictFinished: {
            startPredictionButton.visible = true
            startPredictionButton.opacity = 1.0            
            startPredictionButtonText.text = "Generate predictions"
            loadPredictions()
            view.model = count() - 1
            view.visible = true
            dataPredictionOverview.height = view.height*1.2
        }
    }

    //File dialog for picking files
    FileDialog {
        id: predictionFileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            var str = "" + predictionFileDialog.fileUrls
            var strSplit = str.split("/")
            myPredictionDataSetLabel.text = strSplit[strSplit.length - 1]
            predictionMediator.setFilePath(str.substring(7))            
            startPredictionButton.enabled = true
            startPredictionButton.opacity = 1.0            
        }
        onRejected: { }
    }

    MButton {
        id: startPredictionButton
        iconSource: "../assets/predict.png"
        anchors.right: parent.right
        anchors.bottom: startPredictionButtonText.top
        anchors.rightMargin: 60
        enabled: false
        opacity: 0.4
        property bool isTrainning: false

        onClicked: {
            visible = false
            startPredictionButtonText.text = "Predictions in progress"
            predictionMediatorTimer.start()
        }
    }

    Text {
        id: startPredictionButtonText
        text: qsTr("Generate predictions")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: startPredictionButton.horizontalCenter
        anchors.bottomMargin: 20
        color: "white"
        font.bold: true
    }

    //The timer is required to delay the
    //prediction start, which can freeze
    //the qml interface
    Timer {
        id: predictionMediatorTimer
        interval: 1500
        repeat: false

        onTriggered: {
           predictionMediator.predict()
        }
    }
}
