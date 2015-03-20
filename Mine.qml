import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: root
    width: mine.width
    height: mine.height
    bodyType: Body.Dynamic
    transformOrigin: "Center"

    Image {
        id: mine
        source: "qrc:/assets/mine.png"
        height: 60
        fillMode: Image.PreserveAspectFit
    }

    fixtures: Box {
        id: box
        property string entityType: "mine"
        density: 1000
        width: mine.width
        height: mine.height
        friction: 0.5
        restitution: 0.2
    }
}

