import QtQuick 2.0

Item {
    id: root
    property alias multiplier: idMulti

    Item {
        id: hitpointBar
        width: childrenRect.width * (gameScene.piggie.hitpoints / gameScene.piggie.maxHitpoints)
        height: parent.height
        clip: true

        onWidthChanged: {
            var newBacon = Qt.createQmlObject("Bacon{}", root)
            newBacon.x = width
            newBacon.y = 20
            for(var a = 0; a < 15; a++)
            {
                var newBloodDrop = Qt.createQmlObject("BloodDrop{}", root)
                newBloodDrop.x = width + Math.random() * 100
                newBloodDrop.y = 10 + Math.random() * 100
            }
            bounceAnimation.start()

        }

        transform: Scale {
            id: scaleTransform
            property real scale: 1
            xScale: scale
            yScale: scale
            origin.x: hitpointBar.width / 2
            origin.y: hitpointBar.height / 2
        }

        SequentialAnimation {
            id: bounceAnimation
            loops: 1
            PropertyAnimation {
                target: scaleTransform
                properties: "scale"
                from: 1.0
                to: 1.4
                easing.type: Easing.InOutBack
                duration: 100
            }
            PropertyAnimation {
                target: scaleTransform
                properties: "scale"
                to: 1.0
                easing.type: Easing.InOutBack
                duration: 100
            }
        }

        Image {
            source: "qrc:/assets/baconstrip.png"
            height: parent.height
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }

    Text {
        text: game.score
        anchors.centerIn: parent
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
        }
    }

    Item {
        anchors.right: parent.right
        anchors.top: parent.top
        height: parent.height * 2
        width: height
        Image {
            source: "qrc:/assets/clock.png"
            width: parent.width + 8
            height: parent.height + 8
            anchors.centerIn: parent
        }

        Item {
            id: clockBody
            anchors.fill: parent
            transformOrigin: Item.Center
            Item {
                id: secondHand
                rotation: 0
                function move() {
                    rotation = (new Date().valueOf() - game.startTime) / 1000 * 6 + 6.2
                }
                Behavior on rotation {
                    NumberAnimation {
                        duration: 999
                    }
                }
                width: secondHandInner.height
                height: secondHandInner.width
                x: height - width + width / 2
                transformOrigin: Item.Bottom
                Image {
                    id: secondHandInner
                    source: "qrc:/assets/baconstrip.png"
                    width: clockBody.height / 2
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    rotation: 90
                    y: -height
                    transformOrigin: Image.BottomLeft
                }
                Component.onCompleted: rotation = 6.2
            }
            Item {
                id: minuteHand
                rotation: 0
                function move() {
                    rotation = (new Date().valueOf() - game.startTime) / 1000 * 6 + 6.2
                    console.log(rotation)
                }
                Behavior on rotation {
                    NumberAnimation {
                        duration: 999
                    }
                }
                width: minuteHandInner.height
                height: minuteHandInner.width
                x: height - width + width / 2
                transformOrigin: Item.Bottom
                Image {
                    id: minuteHandInner
                    source: "qrc:/assets/baconstrip.png"
                    height: minuteHandInner.height * 0.8
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    rotation: 90
                    y: -height
                    transformOrigin: Image.BottomLeft
                }
            }
        }
        Timer {
            repeat: true
            running: true
            interval: 1000
            onTriggered: {
                secondHand.move()
            }
        }
    }

    Item {
        id: multiplier
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: 200
        width: idMulti.width

        Text {
            id: idMulti
            text: "Mmmmmonster kill"
            anchors.centerIn: parent
            font.family: baconFont.name
            color: "brown"
            font.pointSize: 40
            font.weight: Font.Bold
            Text {
                text: parent.text
                anchors.centerIn: parent
                font.family: baconFont.name
                color: "dark red"
                font.pointSize: 40
            }
        }

        Component.onCompleted: multiAnimation.start()

        transform: Scale {
            id: multiScale
            property real scale: 1
            xScale: scale
            yScale: scale
            origin.x: idMulti.width / 2
            origin.y: idMulti.height / 2
        }

        SequentialAnimation {
            id: multiAnimation
            loops: -1
            onStopped: multiAnimation.visible = false
            PropertyAnimation {
                target: multiScale
                properties: "scale"
                from: 1.0
                to: 1.4
                easing.type: Easing.InOutBack
                duration: 100
            }
            PropertyAnimation {
                target: multiScale
                properties: "scale"
                to: 1.0
                easing.type: Easing.InOutBack
                duration: 100
            }
        }

    }
}

