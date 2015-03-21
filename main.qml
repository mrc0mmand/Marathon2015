import QtQuick 2.2
import QtQuick.Window 2.0
import Bacon2D 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtMultimedia 5.0

Window {
    id: window
    width: 800
    height: 600
    visible: true
    property int speed: -10
    property bool firstRun: true
    property int timeSave;

    onFocusObjectChanged: {
        if(firstRun == false) {
            if(game.gameState == Bacon2D.Running || game.gameState == Bacon2D.Active) {
                scoreTimer.stop()
                gameScene.generatorTimer.stop()
                hud.clocks.clocksTimer.stop()
                window.timeSave = game.startTime
                game.gameState = Bacon2D.Paused
                backgroundloop.stop()
            } else {
                scoreTimer.start()
                gameScene.generatorTimer.start()
                hud.clocks.clocksTimer.start()
                game.startTime = window.timeSave
                game.gameState = Bacon2D.Running
                backgroundloop.play()
            }
        }
    }

    FontLoader {
        id: baconFont
        source: "qrc:/fonts/Bacon_Bad.ttf"
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
        gameName: "marathon2015"

        property real startTime
        property int score: 0
        currentScene: gameScene

        Settings {
            id: settings
            property variant scores: []
            property bool soundEnabled: true

            Component.onCompleted: {
                settings.scores = scoresSaver.load()
            }
        }

        SoundEffect {
            id: holyShit
            source: "qrc:/sounds/holyshit.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: unstoppable
            source: "qrc:/sounds/unstoppable.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: prepare
            source: "qrc:/sounds/prepare.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: wickedsick
            source: "qrc:/sounds/wickedsick.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: godlike
            source: "qrc:/sounds/godlike.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: rampage
            source: "qrc:/sounds/rampage.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: humiliation
            source: "qrc:/sounds/humiliation.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: dominating
            source: "qrc:/sounds/dominating.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: firstblood
            source: "qrc:/sounds/firstblood.wav"
            volume: settings.soundEnabled ? 1 : 0
        }

        SoundEffect {
            id: backgroundloop
            source: "qrc:/sounds/background.wav"
            loops: SoundEffect.Infinite
            volume: settings.soundEnabled ? 1 : 0
        }

        SceneGame {
            id: gameScene
            height: parent.height
            Connections {
                target: gameScene.piggie
                onHitpointsChanged: {
                    if(gameScene.piggie.hitpoints <= 0) {
                        backgroundloop.stop()
                        hud.visible = false
                        scoreTimer.running = false
                        gameover.finalScore = game.score
                        game.currentScene = gameover
                        console.log("Game Over")
                    }
                }
            }
        }

        SceneGameover {
            id: gameover
            width: parent.width
            height: parent.height
        }

        SceneScoreboard {
            id: scoreboard
            width: parent.width
            height: parent.height
        }

        Timer {
            id: scoreTimer
            running: false
            interval: 1000
            repeat: true
            onTriggered: game.score += 10
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
