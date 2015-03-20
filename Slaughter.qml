import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: slaughterEntity
    x: 300
    y: window.height - height - 10
    width: slaughter.width
    height: slaughter.height
    bodyType: Body.Kinematic
    property real rota: 0
    property int rotaDirection: 1
    property alias hitbox: box
    transformOrigin: "Center"

    //linearVelocity: Qt.point(window.speed, 0)

    Image {
        id: slaughter
        source: "qrc:/assets/slaughter.png"
        height: 120
        fillMode: Image.PreserveAspectFit
    }

    fixtures: Box {
        id: box
        density: 10000000
        width: slaughter.width
        height: slaughter.height
        friction: 0.5
        restitution: 0.2
        property string entityType: "slaughter"
    }

    behavior: ScriptBehavior {
        script: {
            // Rotation
            if(slaughterEntity.rota > 45)
            {
                slaughterEntity.rotaDirection *= -1

            } else if (slaughterEntity.rota < -45) {
                slaughterEntity.rotaDirection *= -1
            }

            slaughterEntity.rota = slaughterEntity.rota + (slaughterEntity.rotaDirection * 5)
            slaughterEntity.rotation = slaughterEntity.rota
        }
    }
}


