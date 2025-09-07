pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components
import qs.components.misc
import qs.config

Item {
    id: processListItem

    property int currentTab: 0
    property var tabNames: ["Processes", "Performance", "System"]

    width: 900
    height: 680
    // color: Colours.palette.m3surfaceContainerLow
    // radius: Appearance.rounding.small
    Layout.fillHeight: true
    // Remove enableShadow and keyboardFocus, unless you want to reimplement them

    // If you want to control visibility, you can still use visible property
    // visible: true

    Ref {
        service: SysMonitorService
    }

    // Remove onBackgroundClicked, as it's modal-specific

    focus: true
    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Escape) {
            // Optionally, you can hide the item or do something else
            // processListItem.visible = false;
            event.accepted = true;
        } else if (event.key === Qt.Key_1) {
            currentTab = 0;
            event.accepted = true;
        } else if (event.key === Qt.Key_2) {
            currentTab = 1;
            event.accepted = true;
        } else if (event.key === Qt.Key_3) {
            currentTab = 2;
            event.accepted = true;
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Appearance.padding.normal

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 52
            color: Colours.palette.m3surfaceContainer
            radius: Appearance.rounding.small

            RowLayout {
                anchors.fill: parent
                anchors.margins: Appearance.padding.small
                spacing: Appearance.padding.small

                Repeater {
                    model: processListItem.tabNames

                    Rectangle {
                        id: individualTab

                        required property int index
                        required property var modelData

                        Layout.alignment: Qt.AlignCenter
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        radius: Appearance.rounding.small
                        color: processListItem.currentTab === index ? Colours.palette.m3primaryContainer : (tabMouseArea.containsMouse ? Qt.rgba(Colours.palette.m3primaryContainer.r, Colours.palette.m3primaryContainer.g, Colours.palette.m3primaryContainer.b, 0.12) : "transparent")
                        border.color: processListItem.currentTab === index ? Colours.palette.m3primaryContainer : "transparent"
                        border.width: processListItem.currentTab === index ? 1 : 0

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: Appearance.padding.small

                            MaterialIcon {
                                text: {
                                    switch (individualTab.index) {
                                    case 0:
                                        return "list_alt";
                                    case 1:
                                        return "analytics";
                                    case 2:
                                        return "settings";
                                    default:
                                        return "tab";
                                    }
                                }
                                font.pointSize: Appearance.font.size.small * 2
                                color: processListItem.currentTab === individualTab.index ? Colours.palette.m3onPrimaryContainer : Colours.palette.m3onSurfaceVariant
                                opacity: processListItem.currentTab === individualTab.index ? 1 : 0.7
                                // anchors.verticalCenter: parent.verticalCenter

                                Behavior on color {
                                    ColorAnimation {
                                        duration: Appearance.anim.durations.small
                                    }
                                }
                            }

                            StyledText {
                                text: individualTab.modelData
                                font.pointSize: Appearance.font.size.normal
                                font.weight: Font.Medium
                                color: processListItem.currentTab === individualTab.index ? Colours.palette.m3onPrimaryContainer : Colours.palette.m3onSurfaceVariant
                                // anchors.verticalCenter: parent.verticalCenter
                                // anchors.verticalCenterOffset: -1

                                Behavior on color {
                                    ColorAnimation {
                                        duration: Appearance.anim.durations.small
                                    }
                                }
                            }
                        }

                        MouseArea {
                            id: tabMouseArea

                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                processListItem.currentTab = individualTab.index;
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
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: Appearance.rounding.small
            color: Colours.palette.m3surfaceContainerLow

            Loader {
                id: processesTab

                anchors.fill: parent
                anchors.margins: Appearance.padding.small
                active: processListItem.currentTab === 0
                visible: processListItem.currentTab === 0
                opacity: processListItem.currentTab === 0 ? 1 : 0
                sourceComponent: processesTabComponent

                Behavior on opacity {
                    NumberAnimation {
                        duration: Appearance.anim.durations.normal
                        easing.bezierCurve: Appearance.anim.curves.emphasizedDecel
                    }
                }
            }

            Loader {
                id: performanceTab

                anchors.fill: parent
                anchors.margins: Appearance.padding.small
                active: processListItem.currentTab === 1
                visible: processListItem.currentTab === 1
                opacity: processListItem.currentTab === 1 ? 1 : 0
                sourceComponent: performanceTabComponent

                Behavior on opacity {
                    NumberAnimation {
                        duration: Appearance.anim.durations.normal
                        easing.bezierCurve: Appearance.anim.curves.emphasizedDecel
                    }
                }
            }

            Loader {
                id: systemTab

                anchors.fill: parent
                anchors.margins: Appearance.padding.small
                active: processListItem.currentTab === 2
                visible: processListItem.currentTab === 2
                opacity: processListItem.currentTab === 2 ? 1 : 0
                sourceComponent: systemTabComponent

                Behavior on opacity {
                    NumberAnimation {
                        duration: Appearance.anim.durations.normal
                        easing.bezierCurve: Appearance.anim.curves.emphasizedDecel
                    }
                }
            }
        }
    }

    Component {
        id: processesTabComponent
        ProcessesTab {
            contextMenu: processContextMenu
        }
    }

    Component {
        id: performanceTabComponent
        PerformanceTab {}
    }

    Component {
        id: systemTabComponent
        SystemTab {}
    }

    ProcessContextMenu {
        id: processContextMenu
    }
}
