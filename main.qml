import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import notepad.example.texteditor 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Notepad")

    Shortcut {
        sequence: StandarKey.Open
        onActivated: openFileDialog.open()
    }
    Shortcut {
        sequence: StandardKey.SaveAs
        onActivated: saveDialog.open()
    }
    Shortcut {
        sequence: StandardKey.Quit
        onActivated: close()
    }

    MenuBar {
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
                onTriggered: openFileDialog.open()
            }
            MenuItem {
                text: qsTr("Save")
                enabled: true
                onTriggered: docController.saveContent()

            }
            MenuItem {
                text: qsTr("Save as")
                enabled: true
                onTriggered: saveDialog.open()
            }
            MenuItem {
                text: qsTr("Print")
                enabled: true
            }
            MenuItem {
                text: qsTr("Exit")
                enabled: true
                onTriggered: close()
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
                onTriggered: textEditArea.cut()
            }
            MenuItem {
                text: qsTr("Copy")
                enabled: true
                onTriggered: textEditArea.copy()
            }
            MenuItem {
                text: qsTr("Paste")
                enabled: true
                onTriggered: textEditArea.paste()
            }
            MenuItem {
                text: qsTr("Select All")
                enabled: true
                onTriggered: textEditArea.selectAll()
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
        Row {
            anchors.fill: parent

            ToolButton {
                id: openButton

                contentItem: Rectangle {
                    color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/Newfile.svg"
                    }
                }
                onClicked: openFileDialog.open()
            }
            ToolButton {
                id: saveButton

                contentItem: Rectangle {
                    color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/save.svg"
                    }
                }
                onClicked: docController.saveContent()
            }
            ToolButton {
                id: saveAsButton

                contentItem: Rectangle {
                    color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/saveas.svg"
                    }
                }
                onClicked: saveDialog.open()
            }
            ToolButton {
                id: printButton

                contentItem: Rectangle {
                    color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/print.svg"
                    }
                }
                // onClicked:
            }
            ToolButton {
                id: undoButton

                contentItem: Rectangle {
                    color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/undo.svg"
                    }
                }
                // onClicked:
            }
            ToolButton {
                id: redoButton

                contentItem: Rectangle {
                    color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/dustin-w-Redo-icon.svg"
                    }
                }
                // onClicked:
            }
            ToolButton {
                id: cutButton

                contentItem: Rectangle {
                    //color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/cut.svg"
                    }
                }
                onClicked: textEditArea.cut()
            }
            ToolButton {
                id: copyButton

                contentItem: Rectangle {
                    //color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/primary-copy.svg"
                    }
                }
                onClicked: textEditArea.copy()
            }
            ToolButton {
                id: pasteButton

                contentItem: Rectangle {
                    //color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/Paste.svg"
                    }
                }
                onClicked: textEditArea.paste()
            }
            ToolButton {
                id: boldButton
                contentItem: Rectangle {
                    //color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/fttext-bold.svg"
                    }
                }
                // onClicked:
            }
            ToolButton {
                id: italicButton
                contentItem: Rectangle {
                    //color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/primary-text-italic.svg"
                    }
                }
                // onClicked:
            }
            ToolButton {
                id: underlineButton

                contentItem: Rectangle {
                    //color: "black"
                    Image {
                        anchors.fill: parent
                        source: "images/mono-text-under.svg"
                    }
                }
                // onClicked:
            }
        }
    }

    FileDialog {
        id: openFileDialog
        nameFilters: ["Text files (*.txt)", "HTML files (*.html, *.htm)"]
        fileMode: FileDialog.OpenFile
        onAccepted: {
            // load file
            docController.openFile(file);
        }
        onRejected: {
            // skip open
        }
    }
    FileDialog {
        id: saveDialog
        nameFilters: ["Text files (*.txt)", "HTML files (*.html, *.htm)"]
        fileMode: FileDialog.SaveFile
        onAccepted: {
            // save file
        }
        onRejected: {
            // skip saving
        }
    }

    DocumentController {
        id: docController
        notepadDoc: textEditArea.textDocument

        onFileContentLoaded: {
            textEditArea.textFormat = format
            textEditArea.text = content
        }
    }

    TextArea {
        id: textEditArea
        width: parent.width
        anchors.top: topToolbar.bottom
        anchors.bottom: parent.bottom
        selectByMouse: true
        persistentSelection: true
        //text:
        textFormat: Qt.RichText
        Component.onCompleted: forceActiveFocus()
    }

    footer: ToolBar {
        id: bottomToolbar
    }
}
