import QtQuick 2.2
import QtQuick.Window 2.0
import Bacon2D 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtMultimedia 5.0

Window {
    id: window
    width: 800
    height: 600
    visible: true
    property int speed: -10

    FontLoader {
        id: baconFont
        source: "qrc:/fonts/Bacon_Bad.ttf"
    }

    Settings {
        id: settings
        property variant scores: [["ofc", 50],["AAA", 0]]
    }

    Audio {
        id: holyShit
        source: "qrc:/sounds/holyshit.wav"
    }

    Component {
        id: ball
        PhysicsEntity {
            id: ballEntity
            height: 32
            width: 32

            bodyType: Body.Dynamic

            Rectangle {
                // This is the drawn ball

                radius: 16
                color: Qt.rgba(0.86, 0.28, 0.07, 1)  // #DD4814

                height: parent.height
                width: parent.width
                Text {
                    color: "white"
                    text: "place<br>holder"
                }
            }
            fixtures: Circle {
                radius: 15
                density: 1
                friction: 0
                restitution: 0.5
            }
        }
    }

    Game {
        id: game
        anchors.fill: parent

        property real startTime
        property int score: 0
        currentScene: gameScene

        SceneGame {
            id: gameScene
            height: parent.height
        }

        SceneGameover {
            id: gameOver
            width: parent.width
            height: parent.height
        }

        SceneScoreboard {
            id: scoreboard
            width: parent.width
            height: parent.height
        }

        Timer {
            id: scoreTimer
            running: true
            interval: 1000
            repeat: true
            onTriggered: game.score += 25
        }
    }

    HUD {
        id: hud
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 8
        }
        height: 64
    }
}
