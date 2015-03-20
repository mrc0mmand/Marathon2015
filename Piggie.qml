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
    angularDamping: 1
    property int hitpoints: 100

    property bool onFloor: false

    Image {
        id: piggie
        source: "qrc:/assets/pig.png"
        anchors.fill: parent
        smooth: true
        fillMode: Image.PreserveAspectFit
    }

    fixtures: [
        Box {
            onBeginContact: {
                if (other.entityType == "floor")
                    onFloor = true
                if (other.entityType == "ramp") {
                    //entity.linearVelocity = Qt.point(entity.linearVelocity.x + 10, entity.linearVelocity.y)
                    window.speed -= 10
                }
                if (other.entityType == "slaughter" || other.entityType == "sawblade") {
                    entity.hitpoints -= 10
                    console.log("Hitpoints: ", entity.hitpoints)
                    for(var i = 0; i < 3; i++)
                    {
                        var startX = entity.x
                        var startY = entity.y
                        var newBacon = Qt.createQmlObject("Bacon{}", scene)
                        newBacon.x = startX - i
                        newBacon.y = startY - i
                        for(var a = 0; a < 3; a++)
                        {
                            var newBloodDrop = Qt.createQmlObject("BloodDrop{}", scene)
                            newBloodDrop.x = startX
                            newBloodDrop.y = startY
                        }
                     }
                }
            }
            onEndContact: {
                if (other.entityType == "floor")
                    onFloor = false
            }

            id: pigCircle
            density: 100
            width: entity.width
            height: entity.width
            friction: 0.5
            restitution: 0.2
        }
    ]

}
