import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RowLayout {
    signal newGame()
    signal quitApp()

    Button {
        text: "New Game"

        onClicked: newGame()
    }

    Button {
        text: "Quit"

        onClicked: quitApp()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequences: ["Ctrl+N"]
        onActivated: newGame()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequences: [StandardKey.Close, "Ctrl+Q"]
        onActivated: quitApp()
    }
}
