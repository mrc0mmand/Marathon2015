import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: root
    width: bloodDrop.width
    height: bloodDrop.height
    bodyType: Body.Dynamic
    transformOrigin: "Center"

    Image {
        id: bloodDrop
        source: "qrc:/assets/bloodDrop.png"
        height: 20
        fillMode: Image.PreserveAspectFit
    }

    fixtures: Box {
        id: box
        density: 1
        width: bloodDrop.width
        height: bloodDrop.height
        friction: 0.5
        restitution: 0.2
    }
    Timer {
        running: true
        interval: 2000
        onTriggered: root.destroy()
    }
}
