import QtQuick 2.0

Item {
    id: root
    property alias clocks: clocks
    property alias volumeControl: volumeControl

    function multiplierText(text)
    {
        idMulti.text = text
        multiplier.visible = true
        multiAnimation.start()
    }

    Item {
        id: hitpointBar
        width: childrenRect.width * (gameScene.piggie.hitpoints / gameScene.piggie.maxHitpoints)
        height: parent.height
        clip: true

        onWidthChanged: {
            if ((gameScene.piggie.hitpoints + 1) == gameScene.piggie.maxHitpoints)
            {
                hud.multiplierText("First blood!")
                firstblood.play()
            }

            if (width != childrenRect.width) {
                for(var a = 0; a < 64; a++)
                {
                    var newBloodDrop = Qt.createQmlObject("BloodDrop{x:"+(width + Math.random() * 100)+";y:"+(10 + Math.random() * 100)+"}", root)
                }
                bounceAnimation.start()
            }
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
            id: gameScoreText
            text: parent.text
            anchors.centerIn: parent
            font.family: baconFont.name
            color: "dark red"
            font.pointSize: 60
        }

        transform: Scale {
            id: scoreMultiScale
            property real scale: 1
            xScale: scale
            yScale: scale
            origin.x: gameScoreText.width / 2
            origin.y: gameScoreText.height / 2
        }

        SequentialAnimation {
            id: scoreMultiAnimation
            loops:4
            onStopped: multiplier.visible = false
            PropertyAnimation {
                target: scoreMultiScale
                properties: "scale"
                from: 1.0
                to: 1.4
                easing.type: Easing.InOutBack
                duration: 50
            }
            PropertyAnimation {
                target: scoreMultiScale
                properties: "scale"
                to: 1.0
                easing.type: Easing.InOutBack
                duration: 50
            }
        }

        onTextChanged: {
            if(game.score != 0 && game.score % 100 == 0)
                scoreMultiAnimation.start()
        }
    }

    Item {
        id: clocks
        property alias clockBody: clockBody
        property alias clocksTimer: clocksTimer
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
            property alias secondHand: secondHand
            anchors.fill: parent
            transformOrigin: Item.Center
            Item {
                id: secondHand
                property alias clockAnimation: clockAnimation
                rotation: 0
                function move() {
                    rotation += 4 //(new Date().valueOf()) / 1000 * 6 + 6.2
                }
                Behavior on rotation {
                    id: clockAnimation
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
                //Component.onCompleted: rotation = 6.2
            }
            Item {
                visible: false
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
            id:clocksTimer
            repeat: true
            running: false
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
        visible: false

        Text {
            id: idMulti
            text: ""
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
            font.family: baconFont.name
            color: "brown"
            font.pointSize: 40
            font.weight: Font.Bold
            Text {
                text: parent.text
                anchors.centerIn: parent
                font.family: baconFont.name
                textFormat: Text.RichText
                horizontalAlignment: parent.horizontalAlignment
                color: "dark red"
                font.pointSize: 40
            }
        }

        transform: Scale {
            id: multiScale
            property real scale: 1
            xScale: scale
            yScale: scale
            origin.x: idMulti.x + idMulti.width / 2
            origin.y: idMulti.y + idMulti.height / 2
        }

        SequentialAnimation {
            id: multiAnimation
            onStarted: idMulti.opacity = 1
            onStopped: multiplier.visible = false
            PropertyAnimation {
                target: multiScale
                properties: "scale"
                from: 1.0
                to: 1.4
                easing.type: Easing.OutBounce
                duration: 500
            }
            PauseAnimation {
                duration: 500
            }
            PropertyAnimation {
                target: idMulti
                properties: "opacity"
                to: 0
                easing.type: Easing.InOutBack
                duration: 500
            }
        }
    }

    Item {
        id: volumeControl
        property alias volumeIcon: volumeIcon
        Image {
            id: volumeIcon
            width: 16
            height: 16
            source: "qrc:/assets/volumeon.png"
        }
    }
}

