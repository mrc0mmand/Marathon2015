import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    focus: false
    width: 80
    height: 80
    bodyType: Body.Dynamic
    linearDamping: 0.5
    angularDamping: 0
    angularVelocity: -360
    fixedRotation: true
    transformOrigin: Item.Center
    property alias hitbox: circle
    linearVelocity: Qt.point(window.speed, 0)


    ImageLayer {
        id: sawblade
        source: "assets/sawblade.png"
        anchors.fill: parent
        smooth: true
    }

    fixtures: [
        Circle {
            property string entityType: "sawblade"
            id: circle
            density: 100000

            x: - entity.width
            y: - entity.width

            radius: entity.width
            friction: 0
            restitution: 0

            onBeginContact: {
                if (other.entityType == "piggie") {
                    console.log("hit!")
                }
            }
        }
    ]
}
