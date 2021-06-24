import QtQuick 2.12

Rectangle {
    width: 750
    height: 600

    color: "green"

    property int moveSpeed: 3000

    Rectangle {
        width: 250
        height: 600

        color: "grey"

        anchors.horizontalCenter: parent.horizontalCenter
    }
}
