import QtQuick 2.4
import Bacon2D 1.0

PhysicsEntity {
    id: root
    property alias box: floorBox

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
            id: floorBox
            y: parent.height - 2
            height: 1
            width: parent.width
            property string entityType: "floor"
            onBeginContact: {
                if (other.objectName == "piggie") {
                    other.onFloor = true
                }
            }
            onEndContact: {
                if (other.objectName == "piggie") {
                    other.onFloor = false
                }
            }
        },
        Box {
            y: 0
            x: -64
            width: parent.width * 2
            height: 1
        },
        Box {
            x: -64
            height: parent.height
            width: 1
        }

    ]

    Rectangle {
        width: parent.width
        y: parent.height - 10
        height: 20
        color: "brown"
    }
}
