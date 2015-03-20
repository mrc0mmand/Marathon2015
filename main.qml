import QtQuick 2.2
import QtQuick.Window 2.0
import Bacon2D 1.0

Window {
    width: 512
    height: 512
    visible: true


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
                restitution: 1
            }
        }
    }


    Game {
        id: game
        anchors.fill: parent

        currentScene: scene

        Scene {
            id: scene

            focus: true
            physics: true
            gravity: Qt.point(0, 1)
            width: parent.width
            height: parent.height

            ImageLayer {
                id: layer
                anchors.fill: parent
                source: "qrc:/sky.png"

                behavior: ScrollBehavior {
                    horizontalStep: -15
                }
            }

            Bowl {
                anchors.fill: parent
            }

            PhysicsEntity {
                id: entity
                x: 100
                y: 300
                width: 80
                height: 80
                bodyType: Body.Kinematic

                behavior: ScriptBehavior {
                    script: {
                        if (globalMouse.mouseY - entity.y > 40)
                            entity.linearVelocity = Qt.point(0, 10)
                        else if (globalMouse.mouseY - entity.y < -40)
                            entity.linearVelocity = Qt.point(0, -10)
                        else
                            entity.linearVelocity = Qt.point(0, 0)
                    }
                }

                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "white"
                    anchors.centerIn: parent

                    Text {
                        text: "placeholder"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }


                fixtures: Box {
                    density: 10000000
                    width: 80
                    height: 80
                    friction: 0.5
                    restitution: 0.2
                }
            }

            Sprite {
                id: spriteItem
visible: false
                x: 64
                y: globalMouse.mouseY


                animation: "falling"

                Rectangle{
                    width: childrenRect.width + 20
                    height: width
                    color: "transparent"
                    border.color: "white"
                    anchors.centerIn: parent

                    Text {
                        text: "placeholder"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }


                animations: SpriteAnimation {
                    name: "falling"
                    //source: "qrc:/astronaut.png"
                    frames: 3
                    duration: 450
                    loops: Animation.Infinite
                }

                Behavior on y {
                    NumberAnimation {
                        duration: 250
                    }
                }

                NumberAnimation on rotation {
                    from: 0
                    to: 360
                    running: game.gameState === Bacon2D.Running
                    loops: Animation.Infinite
                    duration: 1800
                }
            }

            MouseArea {
                id: globalMouse
                anchors.fill: parent
                hoverEnabled: true
            }
            Component.onCompleted: {
                for (var i = 0; i < 10; i++) {
                    for (var j = 0; j < 10; j++) {
                        var newBox = ball.createObject(scene);
                        newBox.x = scene.width / 2 + 100 + 32*j;
                        newBox.y = (15*i) - 10;
                    }
                }
            }
        }
    }
}
