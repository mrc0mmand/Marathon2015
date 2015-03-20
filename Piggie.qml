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
    angularDamping: 0

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.horizontalCenter
        width: 100
        height: 3
        color: "blue"
    }

    Image {
        id: piggie
        source: "qrc:/pig.png"
        anchors.fill: parent
        smooth: true
        fillMode: Image.PreserveAspectFit
    }


    fixtures: Circle {
        density: 100
        radius: entity.width / 2
        friction: 0.5
        restitution: 0.4
    }
}
