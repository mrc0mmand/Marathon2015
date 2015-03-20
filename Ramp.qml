import QtQuick 2.4
import Bacon2D 1.0

import WhateverDude 1.0 as Whatever

PhysicsEntity {
    id: root
    bodyType: Body.Kinematic
    linearVelocity: Qt.point(window.speed, 0)

    fixtures: [
        Polygon {
            property string entityType: "ramp"
            vertices: [
                Qt.point(0, root.height),
                Qt.point(root.width, root.height),
                Qt.point(root.width, 0)
            ]
        }
    ]

    Whatever.Polygon {
        vertices: [
            Qt.point(0, root.height),
            Qt.point(root.width, root.height),
            Qt.point(root.width, 0)
        ]
        fillColor: "pink"
        borderWidth: 0
    }
}
