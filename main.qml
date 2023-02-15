import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Notepad")


    Action {
        id: openFile
        text: "open file"
        onTriggered: {
            //open file dialog
            openFileDialog.selectExisting = true
            openFileDialog.open()
        }
    }
    Action {
        id: saveFile
        text: "save"
        onTriggered: {
            openFileDialog.selectExisting = false
            openFileDialog.open()
        }
    }

    menuBar: MenuBar {
        id: notePadMenu

        Menu {
            id: fileMenu
            title: qsTr("File")
            MenuItem {
                text: qsTr("New")
                //onTriggered: //call function open file
                enabled: true
            }
            MenuItem {
                text: qsTr("Open")
                enabled: true
                action: openFile
            }
            MenuItem {
                text: qsTr("Save")
                enabled: true
                action: saveFile
            }
            MenuItem {
                text: qsTr("Save as")
                enabled: true
            }
            MenuItem {
                text: qsTr("Print")
                enabled: true
            }
            MenuItem {
                text: qsTr("Exit")
                enabled: true
            }
        }
        Menu {
            id: editMenu
            title: qsTr("Edit")
            // ...
            MenuItem {
                text: qsTr("Undo")
                enabled: true
            }
            MenuItem {
                text: qsTr("Cut")
                enabled: true
            }
            MenuItem {
                text: qsTr("Copy")
                enabled: true
            }
            MenuItem {
                text: qsTr("Paste")
                enabled: true
            }
            MenuItem {
                text: qsTr("Select All")
                enabled: true
            }
        }
        Menu {
            id: formatMenu
            title: qsTr("Format")
            // ...\
            MenuItem {
                text: qsTr("Font")
                enabled: true
            }
            MenuItem {
                text: qsTr("Word Wrap")
                enabled: true
            }
        }

        Menu {
            id: viewMenu
            title: qsTr("View")
            // ...
            MenuItem {
                text: qsTr("Status Bar")
                enabled: true
                checkable: true
            }
        }

        Menu {
            id: helpMenu
            title: qsTr("Help")
            // ...
            MenuItem {
                text: qsTr("View Help")
                enabled: true
            }
            MenuItem {
                text: qsTr("Send Feedback")
                enabled: true
            }
            MenuItem {
                text: qsTr("About Notepad")
                enabled: true
            }
        }
    }

    header: ToolBar {
        id: topToolbar
    }

    FileDialog {
        id: openFileDialog
        nameFilters: ["Text files (*.txt)", "HTML files (*.html, *.htm)"]
        onAccepted: {
            if (openFileDialog.selectExisting) {
                //open file
            } else {
                // todo save / close
            }
        }
    }

    TextArea {
        id: textEditArea
        width: parent.width
        anchors.top: topToolbar.bottom
        anchors.bottom: parent.bottom
        //text:
        textFormat: Qt.RichText
        Component.onCompleted: forceActiveFocus()
    }

    footer: ToolBar {
        id: bottomToolbar
    }
}
