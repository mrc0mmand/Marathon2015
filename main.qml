import QtQuick 2.2
import QtQuick.Window 2.0
import Bacon2D 1.0

Window {
    id: window
    width: 800
    height: 600
    visible: true
    property int speed: -10

    FontLoader {
        id: baconFont
        source: "qrc:/assets/Bacon_Bad.ttf"
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
        currentScene: scene

        Scene {
            id: scene

            focus: true
            physics: true
            gravity: Qt.point(0, 10)
            width: parent.width
            height: parent.height

            Keys.onRightPressed: {
                piggie.linearVelocity = Qt.point(5, piggie.linearVelocity.y)
            }
            Keys.onLeftPressed: {
                piggie.linearVelocity = Qt.point(-5, piggie.linearVelocity.y)
            }
            Keys.onUpPressed: {
                if (piggie.onFloor)
                    piggie.linearVelocity = Qt.point(piggie.linearVelocity.x, -5)
            }

            ImageLayer {
                id: layer
                anchors.fill: parent
                source: "qrc:/assets/sky.png"

                behavior: ScrollBehavior {
                    horizontalStep: -2
                }
            }

            ImageLayer {
                id: layer2
                anchors.fill: parent
                source: "qrc:/assets/sky2.png"

                behavior: ScrollBehavior {
                    horizontalStep: -5
                }
            }

            // Stuff in scene
            Piggie {
                id: piggie
            }
            Slaughter {
                id: slaughter
                y: parent.height - height
                x: parent.width + 300
            }

            Floor {
                id: floor
                anchors.fill: parent
            }

            Ramp {
                //anchors.bottom: parent.bottom
                //anchors.horizontalCenter:  parent.horizontalCenter
                y: parent.height - height
                x: parent.width
                width: 200
                height: 100
                //linearVelocity: Qt.point(-10, 0)
            }

            Sawblade {
                id: sawbladeEntity
                y: parent.height - height
                x: parent.width

            }

            MouseArea {
                id: globalMouse
                anchors.fill: parent
                hoverEnabled: true
            }

            Component.onCompleted: {
                for (var i = 0; i < 10; i++) {
                    for (var j = 0; j < 10; j++) {
                        //var newBox = ball.createObject(scene);
                        //newBox.x = scene.width / 2 + 100 + 32*j;
                        //newBox.y = (15*i) - 10;
                    }
                }
                parent.startTime = new Date().valueOf()
            }
        }
        Timer {
            running: true
            interval: 1000
            repeat: true
            onTriggered: game.score++
        }
    }

    HUD {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 8
        }
        height: 64
    }
}
