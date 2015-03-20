import QtQuick 2.4
import Bacon2D 1.0

PhysicsEntity {
    id: root

    property variant model: [
        Qt.point(0, height),
        Qt.point(64, height - 20),
        Qt.point(128, height - 32),
        Qt.point(192, height - 24),
        Qt.point(256, height - 12),
        Qt.point(320, height - 6),
        Qt.point(384, height - 6),
        Qt.point(448, height - 6),
        Qt.point(512, height - 6),
        Qt.point(576, height - 6),
    ]

    fixtures: [
        Box {
            y: parent.height - 2
            height: 1
            width: parent.width
        },
        Box {
            y: 0
            width: parent.width
            height: 1
        }

    ]

    Rectangle {
        width: parent.width
        y: parent.height - 10
        height: 20
        color: "brown"
    }
}
