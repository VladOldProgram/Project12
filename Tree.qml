import QtQuick 2.12

Rectangle {
    id: tree

    width: 70
    height: 120

    color: "transparent"

    property int moveSpeed: 3000
    property var imageNumber: 0

    function stopAnimation() {
        treeAnimation.stop()
    }

    Image {
        source: "/TreeImages/" + imageNumber + ".png"

        anchors.fill: parent
    }

    NumberAnimation on y {
        id: treeAnimation

        from: y
        to: parent.height + 120
        duration: moveSpeed
        running: true
    }

    onYChanged: {
        if (tree.y >= parent.height + 120) {
            treesListPop()
            tree.destroy()
        }
    }
}
