pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config

import qs.components.widgets

Rectangle {
    id: root

    readonly property int contextWidth: Config.bar.workspaces.windowContextWidth
    readonly property int baseRadius: Appearance.rounding.normal
    readonly property int hPadding: Appearance.padding.small
    readonly property int textWidth: mouseArea.containsMouse ? contextWidth - hPadding * 2 - windowDecs.implicitWidth : contextWidth

    required property bool onPrimary
    required property bool isFocused
    required property int itemH
    required property bool popupActive
    required property var mainWindow

    property bool activated: false

    Component.onCompleted: activated = true

    color: "transparent"

    anchors.left: parent.left

    required property string displayTitle
    required property string displaySubtitle

    clip: true

    implicitWidth: root.popupActive && Niri.wsContextAnchor && root.activated ? root.contextWidth + root.hPadding : 0
    // implicitHeight: root.activated && root.popupActive && Niri.wsContextAnchor ? root.itemH : 0
    implicitHeight: root.itemH

    Behavior on implicitWidth {
        Anim {
            duration: Appearance.anim.durations.large
            easing.bezierCurve: Appearance.anim.curves.emphasized
        }
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        ColumnLayout {
            spacing: 0
            Layout.alignment: Qt.AlignVCenter
            AnimatedText {
                Layout.leftMargin: 0
                text: root.displayTitle
                font.pointSize: Appearance.font.size.extraSmall
                font.italic: root.isFocused
                color: root.onPrimary ? Colours.palette.m3onPrimary : Colours.palette.m3onSurfaceVariant
            }

            Rectangle {
                implicitWidth: classText.width + Appearance.padding.small * 2
                implicitHeight: classText.height
                color: root.onPrimary ? Colours.palette.m3tertiary : "transparent"

                radius: root.baseRadius / 2

                Behavior on color {
                    CAnim {}
                }

                AnimatedText {
                    id: classText

                    anchors.centerIn: parent

                    text: root.displaySubtitle
                    font.pointSize: Appearance.font.size.ultraSmall
                    font.family: Appearance.font.family.mono
                    font.bold: root.isFocused
                    color: root.onPrimary ? Colours.palette.m3onTertiary : Colours.palette.m3tertiaryContainer
                }
            }
        }

        Rectangle {
            id: windowDecs
            Layout.alignment: Qt.AlignVCenter
            color: "transparent"

            implicitWidth: decs.implicitWidth + root.hPadding
            implicitHeight: root.itemH
            radius: Appearance.rounding.small

            WindowDecorations {
                id: decs
                anchors.centerIn: parent
                client: root.mainWindow
                opacity: mouseArea.containsMouse ? 1 : 0
                implicitSize: Appearance.font.size.small
                Behavior on opacity {
                    Anim {
                        duration: Appearance.anim.durations.normal
                    }
                }
            }
        }
    }

    StateLayer {
        id: mouseArea
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right

        propagateComposedEvents: true
        hoverEnabled: true

        cursorShape: Qt.ArrowCursor

        width: windowDecs.implicitWidth + root.hPadding * 2
        height: parent.height
    }

    // Local reusable StyledText with common props
    component AnimatedText: StyledText {
        Layout.preferredWidth: root.textWidth
        animate: true
        elide: Text.ElideRight

        Behavior on Layout.preferredWidth {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }

        Behavior on color {
            CAnim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }

        Behavior on font.pointSize {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
    }
}
