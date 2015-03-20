import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import Bacon2D 1.0


Scene {
    id: scoreboard
    width: parent.width
    height: parent.height
    property bool isSubmitted: false

    Rectangle {
        color: "black"
        anchors.fill: parent

    }

    ColumnLayout {
        anchors.fill: parent

        Text {
            id: lbtext
            text: "leaderboard"
            Layout.alignment: Qt.AlignCenter
            font.family: baconFont.name
            color: "brown"
            font.pointSize: 60
            font.bold: true
            Text {
                text: parent.text
                anchors.fill: parent
                font.family: baconFont.name
                color: "dark red"
                font.pointSize: 60

            }
        }

        Item {
            height: 15
        }

        ListView {
            id: scoreboardlist
            width: window.width / 2
            height: window.height - 200
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            anchors.centerIn: parent
           // Layout.fillWidth: true
            clip: true

            model: settings.scores
            header: Row {
                width: parent.width
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    color: "brown"
                    text: "Name"
                    font.family: baconFont.name
                    font.bold: true
                    font.pointSize: 20
                    width: parent.width / 2
                    Text {
                        text: parent.text
                        anchors.fill: parent
                        font.family: baconFont.name
                        color: "dark red"
                        font.pointSize: parent.font.pointSize
                        horizontalAlignment: parent.horizontalAlignment
                    }
                }
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    color: "brown"
                    text: "Score"
                    font.family: baconFont.name
                    font.bold: true
                    font.pointSize: 20
                    width: parent.width / 2
                    Text {
                        text: parent.text
                        anchors.fill: parent
                        font.family: baconFont.name
                        color: "dark red"
                        font.pointSize: parent.font.pointSize
                        horizontalAlignment: parent.horizontalAlignment
                    }
                }
            }

            delegate: Row {
                width: parent.width
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    color: "brown"
                    font.family: baconFont.name
                    font.bold: true
                    font.pointSize: 15
                    text: settings.scores[index][0]
                    width: parent.width / 2
                    Text {
                        text: parent.text
                        anchors.fill: parent
                        font.family: baconFont.name
                        color: "dark red"
                        font.pointSize: parent.font.pointSize
                        horizontalAlignment: parent.horizontalAlignment
                    }
                }
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    color: "pink"
                    font.family: baconFont.name
                    font.bold: true
                    font.pointSize: 15
                    text: settings.scores[index][1]
                    width: parent.width / 2
                    Text {
                        text: parent.text
                        anchors.fill: parent
                        font.family: baconFont.name
                        color: "purple"
                        font.pointSize: parent.font.pointSize
                        horizontalAlignment: parent.horizontalAlignment
                    }
                }
            }
        }

        Row {
            width: window.width / 2
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            height: 35

            TextInput {
                id: scoresubmitinput
                focus: true
                text: "Your name"
                width: 200
                color: "brown"
                font.family: baconFont.name
                font.bold: true
                maximumLength: 10
                font.pointSize: 25
                Text {
                    text: parent.text
                    anchors.fill: parent
                    font.family: baconFont.name
                    color: "dark red"
                    font.pointSize: parent.font.pointSize
                }                
            }

            Button {
                id: scoresubmitbutton
                text: "Submit"

                style: ButtonStyle {
                    background: Rectangle {
                        visible: false
                    }
                    label: Text {
                        color: "brown"
                        font.family: baconFont.name
                        font.bold: true
                        font.pointSize: 30
                        text: scoresubmitbutton.text
                        Text {
                            text: parent.text
                            anchors.fill: parent
                            font.family: baconFont.name
                            color: "dark red"
                            font.pointSize: parent.font.pointSize

                        }
                    }
                }

                onClicked: {
                    if(isSubmitted == true)
                        return

                    var tmpArray = []
                    var pushed = false

                    for(var i = 0; i < settings.scores.length; i++) {
                        if(settings.scores[i][1] <= gameover.finalScore) {
                            tmpArray.push([scoresubmitinput.text, gameover.finalScore])
                            tmpArray.push([settings.scores[i][0], settings.scores[i][1]])
                            pushed = true
                            console.log("New HighScore: " + scoresubmitinput.text + ": " + gameover.finalScore)
                        } else {
                            tmpArray.push([settings.scores[i][0], settings.scores[i][1]])
                        }
                    }

                    if(pushed == false)
                        tmpArray.push([scoresubmitinput.text, gameover.finalScore])

                    settings.scores = tmpArray
                    isSubmitted = true
                }
            }
        }

        Button {
            id: scoreboardok
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            height: 55
            text: "RESTART"

            style: ButtonStyle {
                background: Rectangle {
                    visible: false
                }

                label: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.pointSize: 50
                    font.family: baconFont.name
                    text: scoreboardok.text
                }
            }

            onClicked: {
                game.currentScene = gameScene
                isSubmitted = false
            }
        }
    }
}
