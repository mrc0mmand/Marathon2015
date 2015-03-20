import QtQuick 2.4
import Bacon2D 1.0

PhysicsEntity {
    id: root

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
        width: parent.width
        y: parent.height - 10
        height: 20
        color: "brown"
    }
}
