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

    property int hitpoints: 10
    property int maxHitpoints: 10

    property bool onFloor: true

    property string comboType: ""
    property int    comboCount: 0

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

    behavior: ScriptBehavior {
        script: {
            var scoreBoost = 15 + (Math.floor(game.score / 100)) * 2
            if(linearVelocity.x < scoreBoost) {
                entity.linearVelocity = Qt.point(scoreBoost, entity.linearVelocity.y)
            }
            if(entity.y < 0) {
                entity.linearVelocity = Qt.point(entity.linearVelocity.x, 0)
            }
        }
    }

    fixtures: [
        Box {
            onBeginContact: {
                if (["floor", "mine", "slaughter", "ramp", "sawblade"].indexOf(other.entityType) >= 0)
                {
                    rocket.visible = false
                }

                if(comboType == other.entityType) {
                    comboCount += 1
                } else {
                    comboType = other.entityType
                    comboCount = 1
                }

                if (other.entityType == "floor") {
                    onFloor = true
                }
                if (other.entityType == "mine") {
                    entity.hitpoints -= 1
                    humiliation.play()
                    hud.multiplierText("Humiliation<br><br>mine combo " + comboCount + "x")
                    gameScene.animatePowerUp()
                    for(var i = 0; i < 200; i+=10)
                    {
                        var spriteObject = Qt.createQmlObject("Explosion{}", scene)
                        spriteObject.x = entity.x + Math.random() * 400
                        spriteObject.y = entity.y + 200 - i
                        spriteObject.scale = 3
                    }
                }
                if (other.entityType == "ramp") {
                    entity.linearVelocity = Qt.point(entity.linearVelocity.x + 15, entity.linearVelocity.y)
                    entity.angularVelocity = 0
                    gameScene.animatePowerUp()
                    holyShit.play()
                    rocket.visible = true

                    hud.multiplierText("Holy shit<br><br>boost combo " + comboCount + "x")
                }
                if (other.entityType == "slaughter" || other.entityType == "sawblade") {
                    entity.hitpoints -= 1
                    gameScene.animatePowerUp()
                    wickedsick.play()
                    hud.multiplierText("wicked sick<br><br>" + comboType + " combo " + comboCount + "x")
                }
            }
            onEndContact: {
                if (other.entityType == "floor")
                {
                    //onFloor = false
                }
            }

            id: pigCircle
            property string entityType: "piggie"
            density: 0.1
            width: entity.width
            height: entity.width
            friction: 0.5
            restitution: 0.3
        }
    ]

}
