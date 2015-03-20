import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    x: 100
    y: scene.height - height -10
    focus: true
    width: 110
    height: 110
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
        Image {
            id:rocket
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            source: "qrc:/assets/pigRocket.png"
            fillMode: Image.PreserveAspectFit
            width: 240
        }
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
            if(linearVelocity.x < 5) {
                entity.linearVelocity = Qt.point(15, entity.linearVelocity.y)
            }
        }
    }

    fixtures: [
        Box {
            onBeginContact: {
                if (other.entityType == "floor") {
                    onFloor = true
                    rocket.visible = false
                }
                if (other.entityType == "mine") {
                    entity.hitpoints -= 1
                }
                if (other.entityType == "ramp") {
                    entity.linearVelocity = Qt.point(entity.linearVelocity.x + 5, entity.linearVelocity.y)
                    powerUpAnimation.running = true
                    holyShit.play()
                    rocket.visible = true
                }
                if (other.entityType == "slaughter" || other.entityType == "sawblade") {
                    entity.hitpoints -= 1
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
