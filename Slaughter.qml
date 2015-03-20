import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: slaughterEntity
    x: window.width - width
    y: window.height - height - 10
    width: slaughter.width
    height: slaughter.height
    bodyType: Body.Kinematic
    property real rota: 0
    property int rotaDirection: 1
    transformOrigin: "Center"

    Image {
        id: slaughter
        source: "qrc:/slaughter.png"
        height: 150
        fillMode: Image.PreserveAspectFit
    }

    fixtures: Box {
        density: 10000000
        width: slaughter.width
        height: slaughter.height
        friction: 0.5
        restitution: 0.2
    }

    behavior: ScriptBehavior {
        script: {
            var rota = 0
            var newPos = slaughterEntity.x - 5
            slaughterEntity.x = newPos

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


