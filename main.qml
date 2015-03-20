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

                x: scene.width / 2 - spriteItem.width / 2
                y: scene.height / 2 - spriteItem.height / 2

                animation: "falling"

                animations: SpriteAnimation {
                    name: "falling"
                    source: "qrc:/astronaut.png"
                    frames: 3
                    duration: 450
                    loops: Animation.Infinite
                }

                NumberAnimation on rotation {
                    from: 0
                    to: 360
                    running: game.gameState === Bacon2D.Running
                    loops: Animation.Infinite
                    duration: 1800
                }
            }
        }
    }
}
