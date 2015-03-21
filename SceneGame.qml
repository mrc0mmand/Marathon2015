import QtQuick 2.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import Bacon2D 1.0


Scene {
    id: scene

    property alias piggie: piggie
    property alias generatorTimer: generatorTimer

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
        loops: 6
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

    Floor {
        id: floor
        anchors.fill: parent
    }

    Timer {
        id: generatorTimer
        interval: 500
        repeat: true
        running: true
        onTriggered: {
            var rand = Math.random()
            var obj
            if (rand < 0.1) {
                obj = Qt.createQmlObject("Ramp{}", scene)
            }
            else if (rand < 0.2) {
                obj = Qt.createQmlObject("Slaughter{}", scene)
            }
            else if (rand < 0.3) {
                obj = Qt.createQmlObject("Mine{}", scene)
            }
            else if (rand < 0.4) {
                obj = Qt.createQmlObject("Sawblade{}", scene)
            }

            // Sounds
            if (game.score % 100 == 0 && game.score != 0) {
                game.score += 10
                unstoppable.play()
                hud.multiplierText("Unstoppable!")
            }

            if (obj) {
                obj.x = piggie.x + game.width
                obj.y = game.height - obj.height
                obj.destroy(7000)
            }
        }
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
        backgroundloop.play()
    }
}
