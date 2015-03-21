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
    property QtObject gameSceneComp

    FontLoader {
        id: baconFont
        source: "qrc:/fonts/Bacon_Bad.ttf"
    }

    Audio {
        id: holyShit
        source: "qrc:/sounds/holyshit.wav"
    }

    Audio {
        id: unstoppable
        source: "qrc:/sounds/unstoppable.mp3"
        autoLoad: true
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

    Component.onCompleted: {
       console.log("Component.onCompleted")
      /*  try {
            var gameSceneObject = Qt.createQmlObject('SceneGame {
                 id: gameScene
                 height: parent.height
             }', game, gameScene)
        }
        catch (error) {
            console.log(error)
        }
        console.log(gameSceneObject.id)
        currentScene = gameSceneObject
        hitpointWatcher.target = currentScene.piggie*/

        var scene

        createSceneObject()

        function createSceneObject() {
            console.log("Creating component.")
            gameSceneComp = Qt.createComponent("SceneGameComponent.qml")
            console.log("Created component.")
            console.log(gameSceneComp)
            if(gameSceneComp.status == Component.Ready) {
                console.log("Component is ready.")
                finishCreation()
            } else {
                console.log("Component is not ready: ", gameSceneComp.errorString())
                gameSceneComp.statusChanged.connect(finishCreation)
            }
        }

        function finishCreation() {
            console.log("Finishing creation.")
            if(gameSceneComp.status == Component.Ready) {
                console.log("Component is finally ready. Trying to create an object.")
                console.log("game.height: ", window.height)
                scene = gameSceneComp.createObject(game, {"height" : window.height})
                console.log("Object created: ", gameSceneComp.errorString())
                console.log("Scene height: ", scene.height)
                game.gameScene = scene
                game.currentScene = game.gameScene
                var connections = Qt.createQmlObject(game.gameScene, 'Connections {
                    id: gameSceneConn
                    target: gameScene.piggie
                    onHitpointsChanged: {
                        if(parent.target.hitpoints <= 0) {
                            hud.visible = false
                            scoreTimer.running = false
                            gameover.finalScore = game.score
                            game.currentScene = gameover
                            console.log("Game Over")
                        }
                    }
                }')
                if(scene == null) {
                    // Something's fucked up
                    console.log("Unable to create scene object. God knows why.")
                }
            } else if(gameSceneComp.status == Component.Error){
                console.log("Unable to create scene object: ", gameSceneComp.errorString())
            }
        }


        console.log(game.gameScene)

    }

    Game {
        id: game
        anchors.fill: parent
        gameName: "marathon2015"

        property real startTime
        property int score: 0
        property Scene gameScene

        Settings {
            id: settings
            property variant scores: []
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



        Component.onCompleted: {
            if(window.gameSceneComp == Component.Ready) {
                waitForComponent()
            } else {
                window.gameSceneComp.statusChanged.connect(waitForComponent)
            }

            function waitForComponent() {
                console.log("gameScene is available, creating Connections.")
                var connections = Qt.createQmlObject(game, 'Connections {
                    id: gameSceneConn
                    target: gameScene.piggie
                    onHitpointsChanged: {
                        if(parent.target.hitpoints <= 0) {
                            hud.visible = false
                            scoreTimer.running = false
                            gameover.finalScore = game.score
                            game.currentScene = gameover
                            console.log("Game Over")
                        }
                    }
                }')

                console.log("Hitpoints: ", gameScene.piggie.hitpoints)
            }
        }

        Timer {
            id: scoreTimer
            running: true
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
