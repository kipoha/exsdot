import QtQuick
import QtQuick.Controls
import qs.services
import qs.components
import qs.config

ScrollView {
    anchors.fill: parent
    clip: true
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

    Component.onCompleted: {
        SysMonitorService.addRef();
    }

    Component.onDestruction: {
        SysMonitorService.removeRef();
    }

    Column {
        width: parent.width
        spacing: Appearance.padding.smaller

        StyledRect {
            width: parent.width
            height: systemInfoColumn.implicitHeight + 2 * Appearance.padding.normal
            radius: Appearance.rounding.small
            color: Qt.rgba(Colours.palette.m3surfaceContainer.r, Colours.palette.m3surfaceContainer.g, Colours.palette.m3surfaceContainer.b, 0.6)
            border.width: 0

            Column {
                id: systemInfoColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: Appearance.padding.normal
                spacing: Appearance.padding.normal

                Row {
                    width: parent.width
                    spacing: Appearance.padding.normal

                    SystemLogo {
                        width: 80
                        height: 80
                    }

                    Column {
                        width: parent.width - 80 - Appearance.padding.normal
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: Appearance.padding.small

                        StyledText {
                            text: SysMonitorService.hostname
                            font.pointSize: Appearance.font.size.large
                            font.family: Appearance.font.family.sans
                            font.weight: Font.Light
                            color: Colours.palette.m3onSurfaceVariant
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: SysMonitorService.distribution + " • " + SysMonitorService.architecture + " • " + SysMonitorService.kernelVersion
                            font.pointSize: Appearance.font.size.normal
                            font.family: Appearance.font.family.sans
                            color: Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.7)
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Up " + UserInfoService.uptime + " • Boot: " + SysMonitorService.bootTime
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            color: Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.6)
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Load: " + SysMonitorService.loadAverage + " • " + SysMonitorService.processCount + " processes, " + SysMonitorService.threadCount + " threads"
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            color: Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.6)
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }

                StyledRect {
                    width: parent.width
                    height: 1
                    color: Colours.palette.m3onSurfaceVariant
                }

                Row {
                    width: parent.width
                    spacing: Appearance.padding.normal

                    StyledRect {
                        width: (parent.width - Appearance.padding.normal) / 2
                        height: Math.max(hardwareColumn.implicitHeight, memoryColumn.implicitHeight) + Appearance.padding.smaller
                        radius: Appearance.rounding.small
                        color: Qt.rgba(Colours.palette.m3surfaceContainerHigh.r, Colours.palette.m3surfaceContainerHigh.g, Colours.palette.m3surfaceContainerHigh.b, 0.4)

                        Column {
                            id: hardwareColumn
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: Appearance.padding.smaller
                            spacing: Appearance.padding.small

                            Row {
                                width: parent.width
                                spacing: Appearance.padding.small

                                MaterialIcon {
                                    text: "memory"
                                    font.pointSize: Appearance.font.size.large
                                    color: Colours.palette.m3primary
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                StyledText {
                                    text: "Hardware"
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    font.weight: Font.Bold
                                    color: Colours.palette.m3primary
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            StyledText {
                                text: SysMonitorService.cpuModel
                                font.pointSize: Appearance.font.size.small
                                font.family: Appearance.font.family.sans
                                font.weight: Font.Medium
                                color: Colours.palette.m3onSurfaceVariant
                                width: parent.width
                                elide: Text.ElideRight
                                wrapMode: Text.NoWrap
                                maximumLineCount: 1
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: SysMonitorService.motherboard
                                font.pointSize: Appearance.font.size.small
                                font.family: Appearance.font.family.sans
                                color: Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.8)
                                width: parent.width
                                elide: Text.ElideRight
                                wrapMode: Text.NoWrap
                                maximumLineCount: 1
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: "BIOS " + SysMonitorService.biosVersion
                                font.pointSize: Appearance.font.size.small
                                font.family: Appearance.font.family.sans
                                color: Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.7)
                                width: parent.width
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    StyledRect {
                        width: (parent.width - Appearance.padding.normal) / 2
                        height: Math.max(hardwareColumn.implicitHeight, memoryColumn.implicitHeight) + Appearance.padding.smaller
                        radius: Appearance.rounding.small
                        color: Qt.rgba(Colours.palette.m3surfaceContainerHigh.r, Colours.palette.m3surfaceContainerHigh.g, Colours.palette.m3surfaceContainerHigh.b, 0.4)

                        Column {
                            id: memoryColumn
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: Appearance.padding.smaller
                            spacing: Appearance.padding.small

                            Row {
                                width: parent.width
                                spacing: Appearance.padding.small

                                MaterialIcon {
                                    text: "developer_board"
                                    font.pointSize: Appearance.font.size.large
                                    color: Colours.palette.m3tertiary
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                StyledText {
                                    text: "Memory"
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    font.weight: Font.Bold
                                    color: Colours.palette.m3tertiary
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            StyledText {
                                text: SysMonitorService.formatSystemMemory(SysMonitorService.totalMemoryKB) + " Total"
                                font.pointSize: Appearance.font.size.small
                                font.family: Appearance.font.family.sans
                                font.weight: Font.Medium
                                color: Colours.palette.m3onSurfaceVariant
                                width: parent.width
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: SysMonitorService.formatSystemMemory(SysMonitorService.usedMemoryKB) + " Used • " + SysMonitorService.formatSystemMemory(SysMonitorService.totalMemoryKB - SysMonitorService.usedMemoryKB) + " Available"
                                font.pointSize: Appearance.font.size.small
                                font.family: Appearance.font.family.sans
                                color: Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.7)
                                width: parent.width
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            Item {
                                width: parent.width
                                height: Appearance.font.size.small + Appearance.padding.small
                            }
                        }
                    }
                }
            }
        }

        StyledRect {
            width: parent.width
            height: storageColumn.implicitHeight + 2 * Appearance.padding.normal
            radius: Appearance.rounding.small
            color: Qt.rgba(Colours.palette.m3surfaceContainer.r, Colours.palette.m3surfaceContainer.g, Colours.palette.m3surfaceContainer.b, 0.6)
            border.width: 0

            Column {
                id: storageColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: Appearance.padding.normal
                spacing: Appearance.padding.small

                Row {
                    width: parent.width
                    spacing: Appearance.padding.small

                    MaterialIcon {
                        text: "storage"
                        font.pointSize: Appearance.font.size.large
                        color: Colours.palette.m3onSurfaceVariant
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: "Storage & Disks"
                        font.pointSize: Appearance.font.size.large
                        font.family: Appearance.font.family.sans
                        font.weight: Font.Bold
                        color: Colours.palette.m3onSurfaceVariant
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Column {
                    width: parent.width
                    spacing: 2

                    Row {
                        width: parent.width
                        height: 24
                        spacing: Appearance.padding.small

                        StyledText {
                            text: "Device"
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            font.weight: Font.Bold
                            color: Colours.palette.m3onSurfaceVariant
                            width: parent.width * 0.25
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Mount"
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            font.weight: Font.Bold
                            color: Colours.palette.m3onSurfaceVariant
                            width: parent.width * 0.2
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Size"
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            font.weight: Font.Bold
                            color: Colours.palette.m3onSurfaceVariant
                            width: parent.width * 0.15
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Used"
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            font.weight: Font.Bold
                            color: Colours.palette.m3onSurfaceVariant
                            width: parent.width * 0.15
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Available"
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            font.weight: Font.Bold
                            color: Colours.palette.m3onSurfaceVariant
                            width: parent.width * 0.15
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Use%"
                            font.pointSize: Appearance.font.size.small
                            font.family: Appearance.font.family.sans
                            font.weight: Font.Bold
                            color: Colours.palette.m3onSurfaceVariant
                            width: parent.width * 0.1
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Repeater {
                        id: diskMountRepeater

                        model: SysMonitorService.diskMounts

                        StyledRect {
                            id: individualDiskMount
                            required property var modelData

                            width: parent.width
                            height: 24
                            radius: Appearance.rounding.small
                            color: diskMouseArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurfaceVariant.r, Colours.palette.m3onSurfaceVariant.g, Colours.palette.m3onSurfaceVariant.b, 0.04) : "transparent"

                            MouseArea {
                                id: diskMouseArea

                                anchors.fill: parent
                                hoverEnabled: true
                            }

                            Row {
                                anchors.fill: parent
                                spacing: Appearance.padding.small

                                StyledText {
                                    text: individualDiskMount.modelData.device
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    color: Colours.palette.m3onSurfaceVariant
                                    width: parent.width * 0.25
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                StyledText {
                                    text: individualDiskMount.modelData.mount
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    color: Colours.palette.m3onSurfaceVariant
                                    width: parent.width * 0.2
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                StyledText {
                                    text: individualDiskMount.modelData.size
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    color: Colours.palette.m3onSurfaceVariant
                                    width: parent.width * 0.15
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                StyledText {
                                    text: individualDiskMount.modelData.used
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    color: Colours.palette.m3onSurfaceVariant
                                    width: parent.width * 0.15
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                StyledText {
                                    text: individualDiskMount.modelData.avail
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    color: Colours.palette.m3onSurfaceVariant
                                    width: parent.width * 0.15
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                StyledText {
                                    text: individualDiskMount.modelData.percent
                                    font.pointSize: Appearance.font.size.small
                                    font.family: Appearance.font.family.sans
                                    color: {
                                        const percent = parseInt(individualDiskMount.modelData.percent);
                                        if (percent > 90)
                                            return Colours.palette.error;

                                        if (percent > 75)
                                            return Colours.palette.warning;

                                        return Colours.palette.m3onSurfaceVariant;
                                    }
                                    width: parent.width * 0.1
                                    elide: Text.ElideRight
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
