import QtQuick
import QtQuick.Controls
import Quickshell
import qs.services
import qs.components
import qs.config

Popup {
    id: processContextMenu

    property var processData: null

    function show(x, y) {
        if (!processContextMenu.parent && typeof Overlay !== "undefined" && Overlay.overlay) {
            processContextMenu.parent = Overlay.overlay;
        }

        const menuWidth = 180;
        const menuHeight = menuColumn.implicitHeight + Appearance.padding.small * 2;
        const screenWidth = Screen.width;
        const screenHeight = Screen.height;

        let finalX = x;
        let finalY = y;

        if (x + menuWidth > screenWidth - 20) {
            finalX = x - menuWidth;
        }
        if (y + menuHeight > screenHeight - 20) {
            finalY = y - menuHeight;
        }

        processContextMenu.x = Math.max(20, finalX);
        processContextMenu.y = Math.max(20, finalY);
        open();
    }

    width: 180
    height: menuColumn.implicitHeight + Appearance.padding.small * 2
    padding: 0
    modal: false
    closePolicy: Popup.CloseOnEscape

    onClosed: {
        closePolicy = Popup.CloseOnEscape;
    }

    onOpened: {
        outsideClickTimer.start();
    }

    Timer {
        id: outsideClickTimer
        interval: 100
        onTriggered: {
            processContextMenu.closePolicy = Popup.CloseOnEscape | Popup.CloseOnPressOutside;
        }
    }

    background: StyledRect {
        color: "transparent"
    }

    contentItem: StyledRect {
        id: menuContent
        color: Colours.palette.m3surfaceContainerHigh
        radius: Appearance.rounding.small

        Column {
            id: menuColumn
            anchors.fill: parent
            anchors.margins: Appearance.padding.small
            spacing: 1

            StyledRect {
                width: parent.width
                height: 28
                radius: Appearance.rounding.small
                color: copyPidArea.containsMouse ? Qt.rgba(Colours.palette.m3primary.r, Colours.palette.m3primary.g, Colours.palette.m3primary.b, 0.12) : "transparent"

                StyledText {
                    anchors.left: parent.left
                    anchors.leftMargin: Appearance.padding.small
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Copy PID"
                    font.pointSize: Appearance.font.size.small
                    color: Colours.palette.m3onSurface
                    font.weight: Font.Normal
                }

                MouseArea {
                    id: copyPidArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (processContextMenu.processData) {
                            Quickshell.execDetached(["wl-copy", processContextMenu.processData.pid.toString()]);
                        }
                        processContextMenu.close();
                    }
                }
            }

            StyledRect {
                width: parent.width
                height: 28
                radius: Appearance.rounding.small
                color: copyNameArea.containsMouse ? Qt.rgba(Colours.palette.m3primary.r, Colours.palette.m3primary.g, Colours.palette.m3primary.b, 0.12) : "transparent"

                StyledText {
                    anchors.left: parent.left
                    anchors.leftMargin: Appearance.padding.small
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Copy Process Name"
                    font.pointSize: Appearance.font.size.small
                    color: Colours.palette.m3onSurface
                    font.weight: Font.Normal
                }

                MouseArea {
                    id: copyNameArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (processContextMenu.processData) {
                            let processName = processContextMenu.processData.displayName || processContextMenu.processData.command;
                            Quickshell.execDetached(["wl-copy", processName]);
                        }
                        processContextMenu.close();
                    }
                }
            }

            StyledRect {
                width: parent.width - Appearance.padding.small * 2
                height: 5
                anchors.horizontalCenter: parent.horizontalCenter
                color: "transparent"

                StyledRect {
                    anchors.centerIn: parent
                    width: parent.width
                    height: 1
                    color: Colours.palette.m3outlineVariant
                }
            }

            StyledRect {
                width: parent.width
                height: 28
                radius: Appearance.rounding.small
                color: killArea.containsMouse ? Qt.rgba(Colours.palette.m3onErrorContainer.r, Colours.palette.m3onErrorContainer.g, Colours.palette.m3onErrorContainer.b, 0.12) : "transparent"
                enabled: processContextMenu.processData
                opacity: enabled ? 1 : 0.5

                StyledText {
                    anchors.left: parent.left
                    anchors.leftMargin: Appearance.padding.small
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Kill Process"
                    font.pointSize: Appearance.font.size.small
                    color: parent.enabled ? (killArea.containsMouse ? Colours.palette.m3onErrorContainer : Colours.palette.m3onSurface) : Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.5)
                    font.weight: Font.Normal
                }

                MouseArea {
                    id: killArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: parent.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                    enabled: parent.enabled
                    onClicked: {
                        if (processContextMenu.processData) {
                            Quickshell.execDetached(["kill", processContextMenu.processData.pid.toString()]);
                        }
                        processContextMenu.close();
                    }
                }
            }

            StyledRect {
                width: parent.width
                height: 28
                radius: Appearance.rounding.small
                color: forceKillArea.containsMouse ? Qt.rgba(Colours.palette.m3onErrorContainer.r, Colours.palette.m3onErrorContainer.g, Colours.palette.m3onErrorContainer.b, 0.12) : "transparent"
                enabled: processContextMenu.processData && processContextMenu.processData.pid > 1000
                opacity: enabled ? 1 : 0.5

                StyledText {
                    anchors.left: parent.left
                    anchors.leftMargin: Appearance.padding.small
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Force Kill Process"
                    font.pointSize: Appearance.font.size.small
                    color: parent.enabled ? (forceKillArea.containsMouse ? Colours.palette.m3onErrorContainer : Colours.palette.m3onSurface) : Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.5)
                    font.weight: Font.Normal
                }

                MouseArea {
                    id: forceKillArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: parent.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                    enabled: parent.enabled
                    onClicked: {
                        if (processContextMenu.processData) {
                            Quickshell.execDetached(["kill", "-9", processContextMenu.processData.pid.toString()]);
                        }
                        processContextMenu.close();
                    }
                }
            }
        }
    }
}
