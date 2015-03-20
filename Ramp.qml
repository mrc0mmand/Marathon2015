import QtQuick 2.4
import Bacon2D 1.0

PhysicsEntity {
    id: root
    clip: true

    fixtures: [
        Polygon {
            vertices: [
                Qt.point(0, root.height),
                Qt.point(root.width, root.height),
                Qt.point(root.width, 0)
            ]
        }
    ]

    Rectangle {
        anchors.fill: parent
        color: "blue"
    }

    Rectangle {
        transformOrigin: Item.LeftCenter
        rotation: -Math.atan(height / width) / Math.PI * 180
        width: Math.sqrt(parent.width * parent.width + parent.height * parent.height)
        height: width
        color: "red"
    }
}
