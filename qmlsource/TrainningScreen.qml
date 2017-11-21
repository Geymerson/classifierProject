import QtQuick 2.9
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

import ia2.project 1.0

Rectangle {
    id: trainningScreenContainer
    anchors.fill: parent
    color: "#3399ff"

    property bool modelReady: false

    Text {
        id: trainningTitle
        text: qsTr("Trainning")
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
        width: trainningScreenContainer.width
        height: trainningScreenContainer.height * 0.7
        contentHeight: trainningScreenContainer * 0.8
        contentWidth: trainningScreenContainer.width
        anchors.top: trainningTitle.bottom
        anchors.topMargin: parent.height * 0.02
        clip: true       

        Column {
            spacing: 10
            anchors.fill: parent

            //Rectangle for selecting
            //the dataset
            Rectangle {
                id: myDataSet
                width: flickArea.width * 0.8
                height: flickArea.height * 0.2
                color: trainningScreenContainer.color
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter


                Text {
                    text: "My Dataset"
                    font.pixelSize: 18
                    font.bold: true
                    anchors.left: myDataSet.left
                    anchors.leftMargin: myDataSet.width * 0.02
                }

                Label {
                    id: myDataSetLabel
                    text: "/path/to/file"
                    anchors.verticalCenter: myDataSet.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: myDataSet.width * 0.1

                    property string filePath: ""
                }

                Image {
                    id: loadDataButton
                    width: 40
                    height: width
                    source: "../assets/loadData3.png"
                    anchors {
                        right: parent.right
                        rightMargin: trainningScreenContainer.width * 0.02
                        verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        onClicked: fileDialog.visible = true
                        anchors.fill: parent
                    }
                }
            }

            //Rectangle for viewing
            //the selected dataset
            Rectangle {
                id: dataOverview
                width: flickArea.width * 0.8
                height: flickArea.height * 0.3
                color: trainningScreenContainer.color
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    width: parent.width
                    spacing: 15

                    Text {
                        id: dataOverviewText
                        text: "Data overview"
                        font.bold: true
                        font.pixelSize: 18
                        anchors.left: parent.left
                        anchors.leftMargin: myDataSet.width * 0.02
                    }

                    Text {
                        id: dataOverviewInfoText
                        text: "Make sure that your data classes are not unbalanced,"+
                              " otherwise you will need to do a\ndata over-sampling"+
                              " or under-sampling. Unbalanced datasets will generate"+
                              " biased and\n probably wrong predictions."
                        anchors.left: parent.left
                        anchors.leftMargin: myDataSet.width * 0.02
                    }

                    Image {
                        id: dataChart
                        width: parent.width * 0.95
                        height: 600
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: false
                    }
                }
            }

            //Show the trainning results
            //plots and log
            Rectangle {
                id: trainningResults
                width: flickArea.width * 0.8
                height: flickArea.height * 0.3
                color: trainningScreenContainer.color
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    width: parent.width
                    spacing: 15

                    Text {
                        id: trainningResultsText
                        text: "Trainning Results"
                        font.bold: true
                        font.pixelSize: 18
                        anchors.left: parent.left
                        anchors.leftMargin: myDataSet.width * 0.02
                    }

                    Image {
                        id: trainningResultsPlot
                        width: parent.width * 0.95
                        height: 600
                        visible: false
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Image {
                    id: logButton
                    width: 40
                    height: width
                    source: "../assets/log.png"
                    opacity: 0.4
                    enabled: false

                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        rightMargin: trainningScreenContainer.width * 0.02
                        bottomMargin: trainningScreenContainer.height * 0.02
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            logbox.title = "Your trainning results"
                            logbox.text = mediator.modelSummary()
                            logbox.visible = true
                        }
                    }
                }
            }

            //Show the model evaluation results
            //plots and log
            Rectangle {
                id: modelEvaluation
                width: flickArea.width * 0.8
                height: flickArea.height * 0.3
                color: trainningScreenContainer.color
                border.color: "white"
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    width: parent.width
                    spacing: 15

                    Text {
                        id: modelEvaluationText
                        text: "Test data overview and model evaluation results"
                        font.bold: true
                        font.pixelSize: 18
                        anchors.left: parent.left
                        anchors.leftMargin: myDataSet.width * 0.02
                    }

                    Image {
                        id: modelEvaluationPlot
                        width: parent.width * 0.95
                        height: 600
                        visible: false
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Image {
                    id: evalLogButton
                    width: 40
                    height: width
                    source: "../assets/log.png"
                    opacity: 0.4
                    enabled: false

                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        rightMargin: trainningScreenContainer.width * 0.02
                        bottomMargin: trainningScreenContainer.height * 0.02
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            logbox.title = "Your model evaluation results"
                            logbox.text = mediator.eval_Model()
                            logbox.visible = true
                        }
                    }
                }
            }
        }
    }

    //File dialog for picking files
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            var str = "" + fileDialog.fileUrls
            var strSplit = str.split("/")
            myDataSetLabel.text = strSplit[strSplit.length - 1]
            mediator.setFilePath(str.substring(7))
            startTrainningButton.enabled = true
            startTrainningButton.opacity = 1.0
            mediator.functionCallType = 0
            mediatorTimer.start()
        }
        onRejected: { }
    }

    MButton {
        id: startTrainningButton
        iconSource: "../assets/trainning.png"
        anchors.right: parent.right
        anchors.bottom: startButtonText.top
        anchors.rightMargin: 60
        enabled: false
        opacity: 0.4
        property bool isTrainning: false

        onClicked: {
            visible = false
            startButtonText.text = "Trainning in progress"
            mediator.functionCallType = 1
            mediatorTimer.start()
        }
    }

    Text {
        id: startButtonText
        text: qsTr("Start trainning")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: startTrainningButton.horizontalCenter
        anchors.bottomMargin: 20
        color: "white"
        font.bold: true
    }

    //Mediator for R function
    //calls
    Mediator {
        id: mediator
        property int functionCallType: 0
        onTrainningFinished: {
            startTrainningButton.opacity = 1.0
            startTrainningButton.visible = true            
            trainningResultsPlot.source = "../plots/trainningPlot.png"
            trainningResultsPlot.visible = true
            trainningResults.height = 120 + trainningResultsPlot.height

            modelEvaluationPlot.source = "../plots/data_test.jpg"
            modelEvaluationPlot.visible = true
            modelEvaluation.height = 120 + modelEvaluationPlot.height

            logButton.enabled = true
            logButton.opacity = 1.0

            evalLogButton.enabled = true
            evalLogButton.opacity = 1.0

            modelReady = true
            startButtonText.text = "Start trainning"           
            console.log("Trainning has been finished")
        }

        onPlotingFinished: {
            dataChart.source = "../plots/data.jpg"
            dataOverview.height = 120 + dataChart.height
            dataChart.visible = true
            console.log("Data ploting has been finished")
        }
    }

    MLogBox {
        id: logbox
        anchors.centerIn: parent
        visible: false
        z: 10
    }

    //The timer is required to delay
    //trainning start, which can freeze
    //the qml interface
    Timer {
        id: mediatorTimer
        interval: 1500
        repeat: false

        onTriggered: {
            if(mediator.functionCallType == 0) {
                mediator.createDataPlot()
            }
            else if(mediator.functionCallType == 1) {
                mediator.startTrainning()
            }         
        }                    
    }
}
