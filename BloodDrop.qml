import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    width: bloodDrop.width
    height: bloodDrop.height
    bodyType: Body.Kinematic
    transformOrigin: "Center"

    linearVelocity: Qt.point(-10, -10)

    Image {
        id: bloodDrop
        source: "qrc:/bloodDrop.png"
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
}
