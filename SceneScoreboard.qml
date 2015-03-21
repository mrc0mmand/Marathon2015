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

    Keys.onReturnPressed: {
        scoreboardok.clicked.call()
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
                    color: "brown"
                    font.family: baconFont.name
                    font.bold: true
                    font.pointSize: 15
                    text: settings.scores[index][1]
                    width: parent.width / 2
                    Text {
                        text: parent.text
                        anchors.fill: parent
                        Layout.alignment: Qt.AlignCenter
                        verticalAlignment: parent.verticalAlignment
                        horizontalAlignment: parent.horizontalAlignment
                        font.family: parent.font.family
                        color: "dark red"
                        font.pointSize: parent.font.pointSize
                    }
                }
            }
        }

        Row {
            width: window.width / 2
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            height: 50

            TextInput {
                id: scoresubmitinput
                focus: true
                text: "Your name"
                width: 200
                height: parent.height
                color: Qt.lighter("brown")
                font.family: baconFont.name
                font.bold: true
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                validator: RegExpValidator {
                    regExp: /^[0-9a-zA-Z]{1,10}$/
                }

                maximumLength: 10
                font.pointSize: 25
                Text {
                    text: parent.text
                    anchors.fill: parent
                    font.family: baconFont.name
                    color: "red"
                    font.pointSize: parent.font.pointSize
                    horizontalAlignment: Text.AlignHCenter
                }

                onEditingFinished: {
                    scoresubmitbutton.clicked.call()
                }

            }

            Button {
                id: scoresubmitbutton
                text: "Submit"
                height: parent.height
                isDefault: true

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
                        verticalAlignment: Text.AlignVCenter
                        Text {
                            text: parent.text
                            anchors.fill: parent
                            font.family: baconFont.name
                            color: "dark red"
                            font.pointSize: parent.font.pointSize
                            verticalAlignment: parent.verticalAlignment
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

                    console.log("settings.scores: ", settings.scores)
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
                    color: "brown"
                    font.pointSize: 50
                    font.bold: true
                    font.family: baconFont.name
                    text: scoreboardok.text
                    Text {
                        text: parent.text
                        anchors.fill: parent
                        Layout.alignment: Qt.AlignCenter
                        verticalAlignment: parent.verticalAlignment
                        horizontalAlignment: parent.horizontalAlignment
                        font.family: parent.font.family
                        color: "dark red"
                        font.pointSize: parent.font.pointSize
                    }
                }
            }

            onClicked: {
                gameScene.piggie.hitpoints = gameScene.piggie.maxHitpoints
                gameScene.piggie.x = 100
                gameScene.piggie.y = gameScene.height - gameScene.piggie.height - 10
                gameScene.piggie.linearVelocity = Qt.point(15, 0)
                gameScene.x = 0
                gameScene.generatorTimer.restart()
                game.startTime = new Date().valueOf()
                game.score = 0
                hud.clocks.clockBody.secondHand.rotation = 0

                hud.visible = true
                scoreTimer.restart()
                scoreTimer.running = true
                isSubmitted = false
                backgroundloop.play()
                game.currentScene = gameScene
            }
        }
    }
}
