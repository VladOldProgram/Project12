import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    id: w

    visible: true

    minimumWidth: 750
    maximumWidth: 750
    width: 750

    minimumHeight: gameplay.height
    maximumHeight: gameplay.height
    height: gameplay.height

    title: qsTr("Simple Race")

    Gameplay {
        id: gameplay

        anchors.centerIn: w.contentItem
    }

    Toolbar {
        id: toolbar

        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.left: parent.left

        onNewGame: gameplay.newGame()
        onQuitApp: Qt.quit()
    }

    Text {
        anchors.rightMargin: 40
        anchors.right: parent.right
        anchors.bottomMargin: 40
        anchors.bottom: parent.bottom

        font.pixelSize: 24

        color: "Orange"

        text: "Your score: " + gameplay.currentScore
    }

    Dialog {
        id: gameOverDialog
        modal: true

        x: (parent.width - width)/2
        y: (parent.height - height)/2

        contentItem: Rectangle {
            Text {
                id: gameOverText

                anchors.centerIn: parent

                font.pointSize: 28
            }
        }

        standardButtons: Dialog.Ok
    }
}
