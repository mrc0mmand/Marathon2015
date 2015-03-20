import QtQuick 2.0
import Bacon2D 1.0

Sprite {
    id: root
    animation: "explosion"

    animations: SpriteAnimation {
        name: "explosion"
        source: "qrc:/assets/explosion.png"
        frames: 4
        duration: 400
        loops: Animation.Infinite
    }
    Timer {
        running: true
        interval: 400
        onTriggered: root.destroy()
    }
}

