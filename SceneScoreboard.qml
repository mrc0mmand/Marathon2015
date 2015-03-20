import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import Bacon2D 1.0


Scene {
    id: scoreboard
    width: parent.width
    height: parent.height

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
            height: 50
        }

        ListView {
            id: scoreboardlist
            width: window.width / 2
            height: window.height - 100
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
                        font.family: baconFont.name
                        color: "dark red"
                        font.pointSize: parent.font.pointSize
                        horizontalAlignment: parent.horizontalAlignment
                    }
                }
            }
        }

        Button {
            id: scoreboardok
            Layout.alignment: Qt.AlignCenter
            text: "RESTART"

            style: ButtonStyle {
                background: Rectangle {
                    /*color: "brown"
                    implicitWidth: 75
                    implicitHeight: 40
                    radius: 4
                    border.color: "brown"*/
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
                game.currentScene = scene
            }
        }
    }
}
