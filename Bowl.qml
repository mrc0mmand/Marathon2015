import QtQuick 2.4
import Bacon2D 1.0

PhysicsEntity {
    id: root
    height: 300
    width: 250

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

    fixtures: [         // Left border
        Edge {
            vertices: [
                Qt.point(0, window.height),
                Qt.point(window.width, window.height)
            ]
        }
    ]

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var context = canvas.getContext("2d")
            context.beginPath();
            context.lineWidth = 2;

            // Left border
            if (0) {
                context.moveTo(root.model[0].x, root.model[0].y);
                for (var i = 1; i < root.model.length; i++)
                    context.lineTo(root.model[i].x, root.model[i].y);
            }
            context.moveTo(0, window.height)
            context.lineTo(window.width, window.height)

            context.strokeStyle = "red";
            context.stroke();
        }
    }

    Component.onCompleted: {
        return;
        var j = 0;
        var tmp = []
        for (var i = 1; i < root.model.length; i++) {
            var edge = Qt.createQmlObject('import Bacon2D 1.0; Edge { }', root)
            console.log(edge)
            edge.vertices = [Qt.point(root.model[j], root.model[i])]
            console.log(edge)
            tmp.push(edge)
            j = i;
        }
        root.fixtures = tmp
    }
}
