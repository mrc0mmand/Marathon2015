import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: root
    width: bacon.width
    height: bacon.height
    bodyType: Body.Dynamic
    transformOrigin: "Center"

    //linearVelocity: Qt.point(-10, -10)

    Image {
        id: bacon
        source: "qrc:/assets/bacon.png"
        height: 60
        fillMode: Image.PreserveAspectFit
    }

    fixtures: Box {
        id: box
        density: 1000
        width: bacon.width
        height: bacon.height
        friction: 0.5
        restitution: 0.2
    }
    Timer {
        running: true
        interval: 2000
        onTriggered: root.destroy()
    }
}
