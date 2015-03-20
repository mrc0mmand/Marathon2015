import QtQuick 2.2
import QtQuick.Window 2.0
import Bacon2D 1.0
import QtQuick.Layouts 1.1

Window {
    id: window
    width: 800
    height: 600
    visible: true
    property int speed: -10

    FontLoader {
        id: baconFont
        source: "qrc:/assets/Bacon_Bad.ttf"
    }

    Component {
        id: ball
        PhysicsEntity {
            id: ballEntity
            height: 32
            width: 32

            bodyType: Body.Dynamic

            Rectangle {
                // This is the drawn ball

                radius: 16
                color: Qt.rgba(0.86, 0.28, 0.07, 1)  // #DD4814

                height: parent.height
                width: parent.width
                Text {
                    color: "white"
                    text: "place<br>holder"
                }
            }
            fixtures: Circle {
                radius: 15
                density: 1
                friction: 0
                restitution: 0.5
            }
        }
    }

    Game {
        id: game
        anchors.fill: parent

        property real startTime
        property int score: 0
        currentScene: scene

        Scene {
            id: scene

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
            /*
            ImageLayer {
                id: layer
                anchors.fill: parent
                source: "qrc:/assets/sky.png"

                behavior: ScrollBehavior {
                    horizontalStep: -2
                }

            }

            ImageLayer {
                id: layer2
                anchors.fill: parent
                source: "qrc:/assets/sky2.png"


                behavior: ScrollBehavior {
                    horizontalStep: -5
                }
            }
*/
            // Stuff in scene
            Piggie {
                id: piggie
                linearVelocity: Qt.point(15, 0)
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

        Scene {
            id: gameover
            width: parent.width
            height: parent.height
            opacity: 0

            enterAnimation: NumberAnimation {
                target: gameover
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }

            Rectangle {
                id: gobg
                color: "black"
                anchors.fill: parent
            }

            ColumnLayout {
                anchors.centerIn: parent

                /*Image {
                    anchors.fill: parent
                    Layout.alignment: Qt.AlignCenter
                    source: "qrc:/assets/pig.png"
                }*/

                Text {
                    id: textgo
                    text: "Game over"
                    Layout.alignment: Qt.AlignCenter
                    font.family: baconFont.name
                    color: "brown"
                    font.pointSize: 60
                    font.weight: Font.Bold
                    Text {
                        text: parent.text
                        anchors.centerIn: parent
                        font.family: baconFont.name
                        color: "dark red"
                        font.pointSize: 60
                        font.weight: Font.SemiBold
                    }
                }

                Text {
                    id: testscore
                    text: game.score
                    Layout.alignment: Qt.AlignCenter
                    font.family: baconFont.name
                    color: "brown"
                    font.pointSize: 60
                    font.weight: Font.Bold
                    Text {
                        text: parent.text
                        anchors.centerIn: parent
                        font.family: baconFont.name
                        color: "dark red"
                        font.pointSize: 60
                        font.weight: Font.SemiBold
                    }
                }
            }
        }

        Timer {
            id: scoreTimer
            running: true
            interval: 1000
            repeat: true
            onTriggered: game.score += 25
        }
    }



    HUD {
        id: hud
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 8
        }
        height: 64
    }
}
