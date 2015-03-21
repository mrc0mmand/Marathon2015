import QtQuick 2.4
import Bacon2D 1.0

import WhateverDude 1.0 as Whatever

PhysicsEntity {
    id: root
    bodyType: Body.Kinematic
    width: 230
    height: 100

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
/*
    Whatever.Polygon {
        vertices: [
            Qt.point(0, root.height),
            Qt.point(root.width, root.height),
            Qt.point(root.width, 0)
        ]
        fillColor: "pink"
        borderWidth: 0
    }
*/
    Image {
        source: "qrc:/assets/ramp.png"
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
    }
}
