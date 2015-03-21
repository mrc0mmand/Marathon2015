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
    gravity: Qt.point(0, 100)
    x: 0



    Connections {
        target: piggie
        onXChanged: {
            if (-piggie.x - piggie.width / 2 + 300 < scene.x)
                scene.x = -piggie.x - piggie.width / 2 + 300
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


    Keys.onPressed: {
        if(event.key == Qt.Key_Enter || event.key == Qt.Key_Space || event.key == Qt.Key_Return) {
            if(game.gameState == Bacon2D.Paused) {
                scoreTimer.start()
                gameScene.generatorTimer.start()
                hud.clocks.clocksTimer.start()

                parent.startTime = new Date().valueOf()
                game.gameState = Bacon2D.Running
                backgroundloop.play()
                window.firstRun = false
            }
        }

        if(event.key == Qt.Key_Escape) {
            window.close()
        }

        if(event.key == Qt.Key_S) {
            if(settings.soundEnabled == true) {
                settings.soundEnabled = false
                hud.volumeControl.volumeIcon.source = "qrc:/assets/volumeoff.png"
            } else {
                settings.soundEnabled = true
                hud.volumeControl.volumeIcon.source = "qrc:/assets/volumeon.png"
            }
        }
    }

    Keys.onRightPressed: {
        if(piggie.onFloor) {
            piggie.linearVelocity = Qt.point(piggie.linearVelocity.x + 5, piggie.linearVelocity.y)
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
            piggie.linearVelocity = Qt.point(piggie.linearVelocity.x - 2, -50)
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
        interval: 500 - piggie.linearVelocity.x
        repeat: true
        running: false
        onTriggered: {
            var rand = Math.random()
            var obj
            var forceY = -1

            console.log(interval)

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
            }else if (rand < 0.5) {
                obj = Qt.createQmlObject("Corn{}", scene)
                forceY = 300
            }

            // Sounds
            if (game.score % 100 == 0 && game.score != 0) {
                if (game.score % 200 == 0)
                {
                    rampage.play()
                    hud.multiplierText("Rampage!")
                }
                else if(game.score % 300 == 0)
                {
                    dominating.play()
                    hud.multiplierText("Dominating!")
                }
                else
                {
                    unstoppable.play()
                    hud.multiplierText("Unstoppable!")
                }

                game.score += 10
            }

            if (obj) {
                obj.x = piggie.x + game.width
                obj.y = (forceY != -1) ? forceY : game.height - obj.height
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

        game.gameState = Bacon2D.Paused
    }
}
