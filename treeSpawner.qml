import QtQuick 2.12

Timer {
    property var spawnSpeed: 1000

    interval: spawnSpeed
    running: true
    repeat: true

    onTriggered: {
        createTree()
    }
}
