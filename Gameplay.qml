import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtMultimedia 5.15

GridLayout {
    width: 750
    height: 600

    property var currentScore: 0
    property var obstaclesList: []
    property var treesList: []
    property var newObstacleSpawner: 0
    property var newTreeSpawner: 0
    property var stage: 0
    property var spawnSpeedForObstacles: 1200
    property var spawnSpeedForTrees: 600
    property var obstacleMoveSpeed: 3000
    property var treeMoveSpeed: 3500
    property var elapsedTime: 0
    property var carXVelocity: 0

    function obstaclesListPop() {
        obstaclesList.pop()
    }

    function treesListPop() {
        treesList.pop()
    }

    function newGame() {
        carEngine.stop()
        backgroundMusic.stop()
        if (newObstacleSpawner !== 0)
            newObstacleSpawner.destroy()
        if (newTreeSpawner !== 0)
            newTreeSpawner.destroy()
        for (var i = 0; i < obstaclesList.length; i++)
            obstaclesList[i].destroy()
        obstaclesList = []
        for (i = 0; i < treesList.length; i++)
            treesList[i].destroy()
        treesList = []
        carMoving.stop()
        carXVelocity = 0
        stage = 0
        spawnSpeedForObstacles = 1200
        spawnSpeedForTrees = 600
        obstacleMoveSpeed = 3000
        treeMoveSpeed = 3500
        elapsedTime = 0
        currentScore = 0
        car.imageNumber = helper.randomCarImage()
        car.x = parent.width/2 - car.width/2
        car.y = parent.height - car.height - 10
        carMoving.restart()
        createObstacleSpawner()
        createTreeSpawner()
        speedBooster.restart()
        backgroundMusic.play()
        carEngine.play()
        car.focus = true
    }

    function gameOver() {
        car.focus = false
        carXVelocity = 0
        for (var i = 0; i < obstaclesList.length; i++)
            obstaclesList[i].stopAnimation()
        for (i = 0; i < treesList.length; i++)
            treesList[i].stopAnimation()
        carMoving.stop()
        carCrash.play()
        speedBooster.stop()
        newObstacleSpawner.stop()
        newTreeSpawner.stop()
        carEngine.stop()
        backgroundMusic.stop()
        gameOverDialog.open()
        gameOverText.text = "Game over! Your score: " + currentScore
    }

    function createObstacle() {
        var component = Qt.createComponent("Obstacle.qml")
        if (component.status === Component.Ready) {
            var newObstacle = component.createObject(road, {"x": helper.randomXForRoad(),
                                                         "y": -40,
                                                         "moveSpeed": obstacleMoveSpeed,
                                                         "imageNumber": helper.randomObstacleImage()})
            obstaclesList.unshift(newObstacle)
        }
    }

    function createTree() {
        var component = Qt.createComponent("Tree.qml")
        if (component.status === Component.Ready) {
            var newTree = component.createObject(road, {"x": helper.randomXForOffroad(),
                                                     "y": -120,
                                                     "moveSpeed": treeMoveSpeed,
                                                     "imageNumber": helper.randomTreeImage()})
            treesList.unshift(newTree)
        }
    }

    function createObstacleSpawner() {
        var component = Qt.createComponent("obstacleSpawner.qml")
        if (component.status === Component.Ready) {
            newObstacleSpawner = component.createObject(road, {"spawnSpeed": spawnSpeedForObstacles})
        }

    }

    function createTreeSpawner() {
        var component = Qt.createComponent("treeSpawner.qml")
        if (component.status === Component.Ready) {
            newTreeSpawner = component.createObject(road, {"spawnSpeed": spawnSpeedForTrees})
        }
    }

    Road {
        id: road

        Audio {
            id: backgroundMusic

            source: "/Audio/backgroundMusic.mp3"

            loops: Audio.Infinite

            volume: 1.0
        }

        Timer {
            id: speedBooster

            interval: 5000
            running: false
            repeat: true

            onTriggered: {
                stage += 1
                newObstacleSpawner.destroy()
                newTreeSpawner.destroy()
                spawnSpeedForObstacles -= 130
                spawnSpeedForTrees -= 50
                obstacleMoveSpeed -= 300
                treeMoveSpeed -= 350
                createObstacleSpawner()
                createTreeSpawner()
                elapsedTime += 10
                if (elapsedTime == 60)
                    speedBooster.stop()
            }
        }

        Car {
            id: car

            Audio {
                id: carEngine

                source: "/Audio/carEngineLoop.wav"

                loops: Audio.Infinite

                volume: 0.1
            }

            Audio {
                id: carCrash

                source: "/Audio/carCrash.mp3"

                volume: 1.0
            }

            imageNumber: helper.randomCarImage()

            Timer {
                id: carMoving

                interval: 5
                triggeredOnStart: true
                running: true
                repeat: true

                onTriggered: {
                    if (car.x > 455)
                        car.x = 455
                    if (car.x < 255)
                        car.x = 255
                    if (car.x <= 455 && car.x >= 255)
                        car.x += carXVelocity
                }
            }

            Keys.onPressed: {
                if (event.isAutoRepeat) {
                    return
                }
                switch (event.key) {
                case Qt.Key_Left:
                    carXVelocity -= 3
                    break
                case Qt.Key_Right:
                    carXVelocity += 3
                    break
                }
            }
            Keys.onReleased: {
                if (event.isAutoRepeat) {
                    return
                }
                switch (event.key) {
                case Qt.Key_Left:
                    carXVelocity += 3
                    break
                case Qt.Key_Right:
                    carXVelocity -= 3
                    break
                }
            }
        }
    }
}
