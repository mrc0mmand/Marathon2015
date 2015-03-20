import QtQuick 2.0
import Bacon2D 1.0

PhysicsEntity {
    id: entity
    x: window.width - width
    y: 300
    width: slaughter.width
    height: slaughter.height
    bodyType: Body.Static

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
}

