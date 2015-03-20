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
                if (other == floor.box)
                    onFloor = true
            }
            onEndContact: {
                if (other == floor.box)
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
