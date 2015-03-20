import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    x: 100
    y: 300
    focus: true
    width: 80
    height: 80
    bodyType: Body.Dynamic
    linearDamping: 0.1
    angularDamping: 0

    property bool onFloor: false

    Image {
        id: piggie
        source: "qrc:/pig.png"
        anchors.fill: parent
        smooth: true
        fillMode: Image.PreserveAspectFit
    }

    fixtures: [
        Circle {
            onBeginContact: {
                if (other.entityType == "floor")
                    onFloor = true
                if (other.entityType == "ramp") {
                    entity.linearVelocity = Qt.point(entity.linearVelocity.x + 10, entity.linearVelocity.y)
                }
                if (other.entityType == "slaughter") {
                    console.log("slaughter")
                }
            }
            onEndContact: {
                if (other.entityType == "floor")
                    onFloor = false
            }

            id: pigCircle
            density: 100
            radius: entity.width / 2
            friction: 0.5
            restitution: 0.2
        }
    ]

}
