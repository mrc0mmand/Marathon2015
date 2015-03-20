import QtQuick 2.2
import QtQuick.Window 2.0
import Bacon2D 1.0

Window {
    width: 512
    height: 512
    visible: true

    Game {
        id: game
        anchors.fill: parent

        currentScene: scene

        Scene {
            id: scene

            focus: true
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

            Sprite {
                id: spriteItem

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
        }
    }
}
