import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    focus: false
    width: 80
    height: 80
    bodyType: Body.Kinematic
    linearDamping: 0.5
    angularDamping: 0
    transformOrigin: Item.Center
    linearVelocity: Qt.point(window.speed, 0)

    Image {
        id: sawblade
        source: "qrc:/assets/sawblade.png"
        anchors.fill: parent
        smooth: true
        SequentialAnimation {
            running: true
            loops: -1
            RotationAnimation {
                target: sawblade
                property: "rotation"
                to: 180
                direction: RotationAnimation.Clockwise
            }
            RotationAnimation {
                target: sawblade
                property: "rotation"
                to: 360
                direction: RotationAnimation.Clockwise
            }
        }
    }

    fixtures: [
        Circle {
            property string entityType: "sawblade"
            radius: entity.width / 2
            friction: 0
            restitution: 1
            onBeginContact: {
                if (other.entityType == "piggie") {
                    sawblade.source = "qrc:/assets/sawbladeBlood.png"
                }
            }
        }
    ]
}
