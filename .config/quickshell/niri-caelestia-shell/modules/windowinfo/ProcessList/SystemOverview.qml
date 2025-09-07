import QtQuick
import qs.services
import qs.components
import qs.config

Row {
    width: parent.width
    spacing: Appearance.padding.normal

    Component.onCompleted: {
        SysMonitorService.addRef();
    }

    Component.onDestruction: {
        SysMonitorService.removeRef();
    }

    Rectangle {
        width: (parent.width - Appearance.padding.normal * 2) / 3
        height: 80
        radius: Appearance.rounding.small
        color: {
            if (SysMonitorService.sortBy === "cpu")
                return Qt.rgba(Colours.palette.m3primary.r, Colours.palette.m3primary.g, Colours.palette.m3primary.b, 0.16);
            else if (cpuCardMouseArea.containsMouse)
                return Qt.rgba(Colours.palette.m3primary.r, Colours.palette.m3primary.g, Colours.palette.m3primary.b, 0.12);
            else
                return Qt.rgba(Colours.palette.m3primary.r, Colours.palette.m3primary.g, Colours.palette.m3primary.b, 0.08);
        }

        MouseArea {
            id: cpuCardMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: SysMonitorService.setSortBy("cpu")
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Appearance.padding.normal
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            StyledText {
                text: "CPU"
                font.pointSize: Appearance.font.size.small
                font.weight: Font.Medium
                color: SysMonitorService.sortBy === "cpu" ? Colours.palette.m3primary : Colours.palette.m3secondary
                opacity: SysMonitorService.sortBy === "cpu" ? 1 : 0.8
            }

            StyledText {
                text: SysMonitorService.totalCpuUsage.toFixed(1) + "%"
                font.pointSize: Appearance.font.size.large
                font.family: Appearance.font.family.mono
                font.weight: Font.Bold
                color: Colours.palette.m3onSurface
            }

            StyledText {
                text: SysMonitorService.cpuCount + " cores"
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                color: Colours.palette.m3onSurface
                opacity: 0.7
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: Appearance.anim.durations.small
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: Appearance.anim.durations.small
            }
        }
    }

    Rectangle {
        width: (parent.width - Appearance.padding.normal * 2) / 3
        height: 80
        radius: Appearance.rounding.small
        color: {
            if (SysMonitorService.sortBy === "memory")
                return Qt.rgba(Colours.palette.m3tertiary.r, Colours.palette.m3tertiary.g, Colours.palette.m3tertiary.b, 0.16);
            else if (memoryCardMouseArea.containsMouse)
                return Qt.rgba(Colours.palette.m3tertiary.r, Colours.palette.m3tertiary.g, Colours.palette.m3tertiary.b, 0.12);
            else
                return Qt.rgba(Colours.palette.m3tertiary.r, Colours.palette.m3tertiary.g, Colours.palette.m3tertiary.b, 0.08);
        }

        MouseArea {
            id: memoryCardMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: SysMonitorService.setSortBy("memory")
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Appearance.padding.normal
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            StyledText {
                text: "Memory"
                font.pointSize: Appearance.font.size.small
                font.weight: Font.Medium
                color: SysMonitorService.sortBy === "memory" ? Colours.palette.m3tertiary : Colours.palette.m3secondary
                opacity: SysMonitorService.sortBy === "memory" ? 1 : 0.8
            }

            StyledText {
                text: SysMonitorService.formatSystemMemory(SysMonitorService.usedMemoryKB)
                font.pointSize: Appearance.font.size.large
                font.family: Appearance.font.family.mono
                font.weight: Font.Bold
                color: Colours.palette.m3onSurface
            }

            StyledText {
                text: "of " + SysMonitorService.formatSystemMemory(SysMonitorService.totalMemoryKB)
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                color: Colours.palette.m3onSurface
                opacity: 0.7
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: Appearance.anim.durations.small
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: Appearance.anim.durations.small
            }
        }
    }

    Rectangle {
        width: (parent.width - Appearance.padding.normal * 2) / 3
        height: 80
        radius: Appearance.rounding.small
        color: SysMonitorService.totalSwapKB > 0 ? Qt.rgba(Colours.palette.warning.r, Colours.palette.warning.g, Colours.palette.warning.b, 0.08) : Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.04)

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Appearance.padding.normal
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            StyledText {
                text: "Swap"
                font.pointSize: Appearance.font.size.small
                font.weight: Font.Medium
                color: SysMonitorService.totalSwapKB > 0 ? Colours.palette.warning : Colours.palette.m3onSurface
                opacity: 0.8
            }

            StyledText {
                text: SysMonitorService.totalSwapKB > 0 ? SysMonitorService.formatSystemMemory(SysMonitorService.usedSwapKB) : "None"
                font.pointSize: Appearance.font.size.large
                font.family: Appearance.font.family.mono
                font.weight: Font.Bold
                color: Colours.palette.m3onSurface
            }

            StyledText {
                text: SysMonitorService.totalSwapKB > 0 ? "of " + SysMonitorService.formatSystemMemory(SysMonitorService.totalSwapKB) : "No swap configured"
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                color: Colours.palette.m3onSurface
                opacity: 0.7
            }
        }
    }
}
