import QtQuick 2.0

Item {
    id: root

    Image {
        source: "qrc:/baconstrip.png"
        height: parent.height
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 8
        height: parent.height * 2
        width: height
        radius: height / 2
        color: "black"
        Rectangle {
            anchors.fill: parent
            anchors.margins: 4
            color: "white"
            radius: height / 2

            Item {
                id: clockBody
                anchors.fill: parent
                transformOrigin: Item.Center
                Item {
                    id: secondHand
                    rotation: 6.2
                    function move() {
                        rotation = (new Date().valueOf() - game.startTime) / 1000 * 6 + 6.2
                        console.log(rotation)
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
                        source: "qrc:/baconstrip.png"
                        width: clockBody.height / 2
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                        rotation: 90
                        y: -height
                        transformOrigin: Image.BottomLeft
                    }
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
                        source: "qrc:/baconstrip.png"
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
    }
}

