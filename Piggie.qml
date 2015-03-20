import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    x: 100
    y: scene.height - height -10
    focus: true
    width: 80
    height: 80
    bodyType: Body.Dynamic
    angularDamping: 0
    linearDamping: 0
    property int hitpoints: 100

    property bool onFloor: true

    Image {
        id: piggie
        source: "qrc:/assets/pig.png"
        anchors.fill: parent
        smooth: true
        fillMode: Image.PreserveAspectFit
    }

    onHitpointsChanged: {
        if(entity.hitpoints <= 0) {
            hud.visible = false
            scoreTimer.running = false
            game.currentScene = gameover
            console.log("Game Over")
        }
    }

    behavior: ScriptBehavior {
        script: {
            if(linearVelocity.x < 10) {
                entity.linearVelocity = Qt.point(15, entity.linearVelocity.y)
            }
        }
    }

    fixtures: [
        Box {
            onBeginContact: {
                if (other.entityType == "floor") {
                    onFloor = true
                    piggie.source = "qrc:/assets/pig.png"
                }
                if (other.entityType == "ramp") {
                    entity.linearVelocity = Qt.point(entity.linearVelocity.x + 5, entity.linearVelocity.y)
                    piggie.source = "qrc:/assets/pigRocket.png"
                }
                if (other.entityType == "slaughter" || other.entityType == "sawblade") {
                    entity.hitpoints -= 10

                    console.log("Hitpoints: ", entity.hitpoints)
                    for(var i = 0; i < 3; i++)
                    {
                        var startX = 300
                        var startY = 20
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
                {
                    //onFloor = false
                }
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
