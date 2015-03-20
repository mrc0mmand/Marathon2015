import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    x: Math.abs(Math.floor(Math.random() * window.width - (window.width / 2))) + (window.width / 4)
    y: Math.abs(Math.floor(Math.random() * window.height - (window.height / 2))) + (window.height / 4)
    focus: false
    width: 80
    height: 80
    bodyType: Body.Dynamic
    linearDamping: 0.5
    angularDamping: 0
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

    NumberAnimation on rotation {
        from: 0
        to: 360
        loops: Animation.Infinite
        duration: 1800
    }

    behavior: ScriptBehavior {
        script: {
           /* var newX = sawbladeEntity.x + Math.floor(Math.random() * ((Math.random() * 2) > 1 ? -5 : 5))
            var newY = sawbladeEntity.y + Math.floor(Math.random() * ((Math.random() * 2) > 1 ? -5 : 5))*/


            /*sawbladeEntity.x = newX > parent.width ? parent.width : newX
            sawbladeEntity.y = newY > parent.height ? parent.height : newY*/
        }
    }

    fixtures: [
        Circle {
            property string entityType: "sawblade"
            id: circle
            density: 100000

            radius: entity.width / 2
            friction: 0
            restitution: 1
        }
    ]
}
