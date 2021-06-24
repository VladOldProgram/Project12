import QtQuick 2.12

Rectangle {
    id: car

    x: 355
    y: 500

    width: 40
    height: 90

    color: "transparent"

    property var imageNumber: 1

    Image {
        source: "/CarImages/" + imageNumber + ".png"

        anchors.fill: parent
    }
}
