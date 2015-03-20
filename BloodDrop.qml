import QtQuick 2.0
import Bacon2D 1.0

Image {
    id: bloodDrop
    source: Math.random() > 0.1 ? "qrc:/assets/bloodDrop.png" : "qrc:/assets/bacon.png"
    height: source == "qrc:/assets/bloodDrop.png" ? 20 : 40
    fillMode: Image.PreserveAspectFit

    SequentialAnimation {
        running: true
        loops: -1
        RotationAnimation {
            target: bloodDrop
            property: "rotation"
            direction: RotationAnimation.Clockwise
            to: 180
        }
        RotationAnimation {
            target: bloodDrop
            property: "rotation"
            direction: RotationAnimation.Clockwise
            to: 360
        }
    }

    NumberAnimation {
        running: true
        target: bloodDrop
        property: "x"
        to: Math.random() * (window.width + 64)
        duration: Math.random() * 4000
    }

    NumberAnimation {
        running: true
        target: bloodDrop
        property: "y"
        to: Math.random() * (window.height + 64)
        duration: Math.random() * 4000
    }

    Timer {
        running: true
        interval: 2000
        onTriggered: bloodDrop.destroy()
    }
}
