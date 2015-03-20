import QtQuick 2.4
import Bacon2D 1.0

PhysicsEntity {
    height: 300
    width: 250

    fixtures: [
        // Left border
        Edge {
            vertices: [
                Qt.point(0, 0),
                Qt.point(0, target.height * 2/5)
            ]
        },
        Edge {
            vertices: [
                Qt.point(0, target.height * 2/5),
                Qt.point(target.width * 3/8, target.height * 3/5)
            ]
        },
        Edge {
            vertices: [
                Qt.point(target.width * 3/8, target.height * 3/5),
                Qt.point(target.width * 3/8, target.height)
            ]
        },

        // Right border
        Edge {
            vertices: [
                Qt.point(target.width, 0),
                Qt.point(target.width, target.height * 2/5)
            ]
        },
        Edge {
            vertices: [
                Qt.point(target.width, target.height * 2/5),
                Qt.point(target.width * 5/8, target.height * 3/5)
            ]
        },
        Edge {
            vertices: [
                Qt.point(target.width * 5/8, target.height * 3/5),
                Qt.point(target.width * 5/8, target.height)
            ]
        },

        // Top pyramid
        Edge {
            vertices: [
                Qt.point(target.width / 4, target.height / 4),
                Qt.point(target.width / 2, target.height / 8),
            ]
        },
        Edge {
            vertices: [
                Qt.point(target.width / 2, target.height / 8),
                Qt.point(target.width * 3/4, target.height / 4)
            ]
        }
    ]

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var context = canvas.getContext("2d")
            context.beginPath();
            context.lineWidth = 5;

            // Left border
            context.moveTo(0, 0);
            context.lineTo(0, height * 2/5);
            context.lineTo(width * 3/8, height * 3/5);
            context.lineTo(width * 3/8, height);

            // Right border
            context.moveTo(width, 0);
            context.lineTo(width, height * 2/5);
            context.lineTo(width * 5/8, height * 3/5);
            context.lineTo(width * 5/8, height);

            // Pyramid
            context.moveTo(width / 4, parent.height / 4);
            context.lineTo(width / 2, parent.height / 8);
            context.lineTo(width * 3/4, parent.height / 4);

            context.strokeStyle = "pink";
            context.stroke();
        }
    }
}
