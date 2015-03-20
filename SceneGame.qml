import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import Bacon2D 1.0


Scene {
    id: scene

    property alias piggie: piggie
    function animatePowerUp() {
        powerUpAnimation.running = true
    }

    focus: true
    physics: true
    gravity: Qt.point(0, 10)
    x: 0
    Connections {
        target: piggie
        onXChanged: {
            if (-piggie.x + 200 < scene.x)
                scene.x = -piggie.x + 200
        }
    }

    transform: [rotationTransform, scaleTransform]
    Rotation {
        id: rotationTransform
        origin.x: piggie.x
        origin.y: piggie.y
        axis {
            x: 1
            y: 1
            z: -1
        }
        angle: 0
    }
    Scale {
        id: scaleTransform
        origin.x: piggie.x
        origin.y: piggie.y
        xScale: 1
        yScale: 1
    }
    Translate {
        id: translateTransform
        x: 0
        y: 0
    }

    ParallelAnimation {
        id: powerUpAnimation
        running: false
        loops: 10
        property real speed: 150
        onRunningChanged: {
            rotationTransform.angle = 0
            scaleTransform.xScale = 1
            scaleTransform.yScale = 1
            translateTransform.x = 0
            translateTransform.y = 0
        }

        SequentialAnimation {
            NumberAnimation {
                target: rotationTransform
                property: "angle"
                from: 0
                to: Math.random() > 0.5 ? 6 : -6
                duration: powerUpAnimation.speed
            }
            NumberAnimation {
                target: rotationTransform
                property: "angle"
                to: 0
                duration: powerUpAnimation.speed
            }
        }
        SequentialAnimation {
            NumberAnimation {
                target: scaleTransform
                properties: "xScale,yScale"
                from: 1
                to: Math.random() > 0.5 ? 1.1 : 0.9
                duration: powerUpAnimation.speed
            }
            NumberAnimation {
                target: scaleTransform
                properties: "xScale,yScale"
                to: 1
                duration: powerUpAnimation.speed
            }
        }
        SequentialAnimation {
            NumberAnimation {
                target: translateTransform
                properties: "x, y"
                from: 0
                to: Math.random() > 0.5 ? 6 : -6
                duration: powerUpAnimation.speed
            }
            NumberAnimation {
                target: translateTransform
                properties: "x, y"
                to: 0
                duration: powerUpAnimation.speed
            }
        }
    }

    width: 10000 - x
    height: parent.height

    Keys.onRightPressed: {
        if(piggie.onFloor) {
            piggie.linearVelocity = Qt.point(15, piggie.linearVelocity.y)
        }
    }
    Keys.onLeftPressed: {
        if(piggie.linearVelocity > 5) {
            piggie.linearVelocity = Qt.point(piggie.linearVelocity.x - 5, piggie.linearVelocity.y)
        }
    }
    Keys.onUpPressed: {
        if (piggie.onFloor)
        {
            piggie.onFloor = false
            piggie.linearVelocity = Qt.point(piggie.linearVelocity.x - 2, -15)
        }
    }
    Image {
        anchors.fill: parent
        anchors.leftMargin: -1000
        source: "qrc:/assets/sky.png"
        fillMode: Image.TileHorizontally
    }
    Image {
        anchors.fill: parent
        anchors.leftMargin: -1000 + scene.x / 2
        source: "qrc:/assets/sky2.png"
        fillMode: Image.TileHorizontally
    }
    // Stuff in scene
    Piggie {
        id: piggie
        linearVelocity: Qt.point(15, 0)
    }
    Mine {
        y: parent.height - height
        x: 3000
    }
    Mine {
        y: parent.height - height
        x: 4000
    }
    Mine {
        y: parent.height - height
        x: 5000
    }
    Slaughter {
        id: slaughter
        y: parent.height - height
        x: 900
    }
    Slaughter {
        id: slaughter2
        y: parent.height - height
        x: 1500
    }
    Slaughter {
        id: slaughter3
        y: parent.height - height
        x: 2500
    }

    Floor {
        id: floor
        anchors.fill: parent
    }

    Ramp {
        //anchors.bottom: parent.bottom
        //anchors.horizontalCenter:  parent.horizontalCenter
        y: parent.height - height
        x: 600
        width: 200
        height: 100
        //linearVelocity: Qt.point(-10, 0)
    }

    Sawblade {
        id: sawbladeEntity
        y: parent.height - height
        x: parent.width + 300

    }

    MouseArea {
        id: globalMouse
        anchors.fill: parent
        hoverEnabled: true
    }

    Component.onCompleted: {
        for (var i = 0; i < 10; i++) {
            for (var j = 0; j < 10; j++) {
                //var newBox = ball.createObject(scene);
                //newBox.x = scene.width / 2 + 100 + 32*j;
                //newBox.y = (15*i) - 10;
            }
        }
        parent.startTime = new Date().valueOf()
    }
}
