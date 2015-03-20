import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    x: 100
    y: 300
    width: 80
    height: 80
    bodyType: Body.Kinematic

    behavior: ScriptBehavior {
        script: {
            if (globalMouse.mouseY - entity.y > 5)
                entity.linearVelocity = Qt.point(0, 10)
            else if (globalMouse.mouseY - entity.y < -5)
                entity.linearVelocity = Qt.point(0, -10)
            else
                entity.linearVelocity = Qt.point(0, 0)
        }
    }

    Image {
        id: piggie
        source: "qrc:/pig.png"
        width: 50
        height: 50
        smooth: true
        fillMode: Image.PreserveAspectFit
    }


    fixtures: Box {
        density: 10000000
        width: piggie.width
        height: piggie.height
        friction: 0.5
        restitution: 0.2
    }
}
