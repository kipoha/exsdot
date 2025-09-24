import QtQuick
import qs.services
import qs.components
import qs.config

StyledRect {
    id: processItem

    property var process: null
    property var contextMenu: null

    width: parent ? parent.width : 0
    height: 40
    radius: Appearance.rounding.large
    color: processMouseArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.08) : "transparent"

    MouseArea {
        id: processMouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                if (processItem.process && processItem.process.pid > 0 && processItem.contextMenu) {
                    processItem.contextMenu.processData = processItem.process;
                    let globalPos = processMouseArea.mapToGlobal(mouse.x, mouse.y);
                    let localPos = processItem.contextMenu.parent ? processItem.contextMenu.parent.mapFromGlobal(globalPos.x, globalPos.y) : globalPos;
                    processItem.contextMenu.show(localPos.x, localPos.y);
                }
            }
        }
        onPressAndHold: {
            if (processItem.process && processItem.process.pid > 0 && processItem.contextMenu) {
                processItem.contextMenu.processData = processItem.process;
                let globalPos = processMouseArea.mapToGlobal(processMouseArea.width / 2, processMouseArea.height / 2);
                processItem.contextMenu.show(globalPos.x, globalPos.y);
            }
        }
    }

    Item {
        anchors.fill: parent
        anchors.margins: 8

        MaterialIcon {
            id: processIcon

            text: SysMonitorService.getProcessIcon(processItem.process ? processItem.process.command : "")
            font.pointSize: Appearance.font.size.small * 2
            color: {
                if (processItem.process && processItem.process.cpu > 80)
                    return Colours.palette.error;

                if (processItem.process && processItem.process.cpu > 50)
                    return Colours.palette.warning;

                return Colours.palette.m3onSurface;
            }
            opacity: 0.8
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        StyledText {
            text: processItem.process ? processItem.process.displayName : ""
            font.pointSize: Appearance.font.size.small
            font.family: Appearance.font.family.mono
            font.weight: Font.Medium
            color: Colours.palette.m3onSurface
            width: 250
            elide: Text.ElideRight
            anchors.left: processIcon.right
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
        }

        StyledRect {
            id: cpuBadge

            width: 80
            height: 20
            radius: Appearance.rounding.normal
            color: {
                if (processItem.process && processItem.process.cpu > 80)
                    return Qt.rgba(Colours.palette.m3onErrorContainer.r, Colours.palette.m3onErrorContainer.g, Colours.palette.m3onErrorContainer.b, 0.12);

                if (processItem.process && processItem.process.cpu > 50)
                    return Qt.rgba(Colours.palette.warning.r, Colours.palette.warning.g, Colours.palette.warning.b, 0.12);

                return Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08);
            }
            anchors.right: parent.right
            anchors.rightMargin: 194
            anchors.verticalCenter: parent.verticalCenter

            StyledText {
                text: SysMonitorService.formatCpuUsage(processItem.process ? processItem.process.cpu : 0)
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                font.weight: Font.Bold
                color: {
                    if (processItem.process && processItem.process.cpu > 80)
                        return Colours.palette.error;

                    if (processItem.process && processItem.process.cpu > 50)
                        return Colours.palette.warning;

                    return Colours.palette.m3onSurface;
                }
                anchors.centerIn: parent
            }
        }

        StyledRect {
            id: memoryBadge

            width: 80
            height: 20
            radius: Appearance.rounding.normal
            color: {
                if (processItem.process && processItem.process.memoryKB > 1024 * 1024)
                    return Qt.rgba(Colours.palette.m3onErrorContainer.r, Colours.palette.m3onErrorContainer.g, Colours.palette.m3onErrorContainer.b, 0.12);

                if (processItem.process && processItem.process.memoryKB > 512 * 1024)
                    return Qt.rgba(Colours.palette.warning.r, Colours.palette.warning.g, Colours.palette.warning.b, 0.12);

                return Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08);
            }
            anchors.right: parent.right
            anchors.rightMargin: 102
            anchors.verticalCenter: parent.verticalCenter

            StyledText {
                text: SysMonitorService.formatMemoryUsage(processItem.process ? processItem.process.memoryKB : 0)
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                font.weight: Font.Bold
                color: {
                    if (processItem.process && processItem.process.memoryKB > 1024 * 1024)
                        return Colours.palette.error;

                    if (processItem.process && processItem.process.memoryKB > 512 * 1024)
                        return Colours.palette.warning;

                    return Colours.palette.m3onSurface;
                }
                anchors.centerIn: parent
            }
        }

        StyledText {
            text: processItem.process ? processItem.process.pid.toString() : ""
            font.pointSize: Appearance.font.size.small
            font.family: Appearance.font.family.mono
            color: Colours.palette.m3onSurface
            opacity: 0.7
            width: 50
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
        }

        StyledRect {
            id: menuButton

            width: 28
            height: 28
            radius: Appearance.rounding.normal
            color: menuButtonArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08) : "transparent"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            MaterialIcon {
                text: "more_vert"
                font.pointSize: Appearance.font.size.small * 2
                color: Colours.palette.m3onSurface
                opacity: 0.6
                anchors.centerIn: parent
            }

            MouseArea {
                id: menuButtonArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (processItem.process && processItem.process.pid > 0 && processItem.contextMenu) {
                        processItem.contextMenu.processData = processItem.process;
                        let globalPos = menuButtonArea.mapToGlobal(menuButtonArea.width / 2, menuButtonArea.height);
                        let localPos = processItem.contextMenu.parent ? processItem.contextMenu.parent.mapFromGlobal(globalPos.x, globalPos.y) : globalPos;
                        processItem.contextMenu.show(localPos.x, localPos.y);
                    }
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Appearance.anim.durations.small
                }
            }
        }
    }
}
