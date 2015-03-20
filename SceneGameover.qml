import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import Bacon2D 1.0

Scene {
    id: gameover
    width: parent.width
    height: parent.height
    opacity: 0

    property int finalScore

    enterAnimation: NumberAnimation {
        target: gameover
        property: "opacity"
        from: 0
        to: 1
        duration: 500
    }

    Rectangle {
        id: gobg
        color: "black"
        anchors.fill: parent
    }

    ColumnLayout {

        anchors.fill: parent
        Layout.fillHeight: true
        Layout.fillWidth: true

        anchors.centerIn: parent

        /*Image {
            anchors.fill: parent
            Layout.alignment: Qt.AlignCenter
            source: "qrc:/assets/pig.png"
        }*/

        Text {
            id: textgo
            text: "Game over"
            Layout.alignment: Qt.AlignCenter
            font.family: baconFont.name
            color: "brown"
            font.pointSize: 60
            font.bold: true
            Text {
                text: parent.text
                anchors.fill: parent
                Layout.alignment: Qt.AlignCenter
                font.family: baconFont.name
                color: "dark red"
                font.pointSize: 60
            }
        }

        Item {
            Layout.alignment: Qt.AlignCenter
            height: 100
        }

        Text {
            id: testscoretext
            text: "Score:"
            Layout.alignment: Qt.AlignCenter
            font.family: baconFont.name
            color: "brown"
            font.pointSize: 45
            font.bold: true
            Text {
                text: parent.text
                anchors.fill: parent
                Layout.alignment: Qt.AlignCenter
                font.family: baconFont.name
                color: "dark red"
                font.pointSize: 45
            }
        }

        Text {
            id: testscore
            text: gameover.finalScore
            Layout.alignment: Qt.AlignCenter
            font.family: baconFont.name
            color: "brown"
            font.pointSize: 55
            font.bold: true
            Text {
                text: parent.text
                anchors.fill: parent
                Layout.alignment: Qt.AlignCenter
                font.family: baconFont.name
                color: "dark red"
                font.pointSize: 55
            }
        }

        Button {
            id: gameoverok
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            text: "OK"

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
                    color: "brown"
                    font.bold: true
                    font.pointSize: 50
                    font.family: baconFont.name
                    text: gameoverok.text
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
                game.currentScene = scoreboard
            }
        }
    }
}
