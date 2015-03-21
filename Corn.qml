import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: root
    width: corn.width
    height: corn.height
    bodyType: Body.Static
    transformOrigin: "Center"

    property int extraHP: 5

    Image {
        id: corn
        source: "qrc:/assets/corn.png"
        height: 60
        fillMode: Image.PreserveAspectFit
    }

    fixtures: Box {
        id: box
        property string entityType: "corn"
        density: 100
        width: corn.width
        height: corn.height
        friction: 0.5
        restitution: 0.8

        onBeginContact: {
            if(other.entityType == "piggie")
            {
                root.destroy()
                hud.multiplierText("Extra life")
                if((piggie.hitpoints + extraHP) > piggie.maxHitpoints)
                {
                    piggie.hitpoints = piggie.maxHitpoints
                    game.score += 100
                } else {
                    piggie.hitpoints += extraHP
                }
            }
        }
    }
}

