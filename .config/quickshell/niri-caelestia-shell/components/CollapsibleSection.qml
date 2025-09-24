import qs.services
import qs.config
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    default property alias contentComponent: contentLoader.sourceComponent

    property string title: qsTr("Dropdown Title")
    property bool expanded: false
    property color backgroundColor: expanded ? Colours.palette.m3surfaceContainerLow : "transparent"

    // Margin properties: if backgroundMargins >= 0, use it for all sides; otherwise, use individual margins
    property real backgroundMarginLeft: Appearance.padding.small
    property real backgroundMarginRight: Appearance.padding.small
    property real backgroundMarginTop: Appearance.padding.small
    property real backgroundMarginBottom: 0
    property real backgroundMargins: -1 // -1 means "not set"

    signal collapsed

    // Header height constant
    Rectangle {
        id: backgroundRect

        Layout.alignment: Qt.AlignTop
        Layout.fillWidth: true

        Layout.leftMargin: root.backgroundMargins >= 0 ? root.backgroundMargins : root.backgroundMarginLeft
        Layout.rightMargin: root.backgroundMargins >= 0 ? root.backgroundMargins : root.backgroundMarginRight
        Layout.topMargin: root.backgroundMargins >= 0 ? root.backgroundMargins : root.backgroundMarginTop
        Layout.bottomMargin: root.backgroundMargins >= 0 ? root.backgroundMargins : root.backgroundMarginBottom

        color: root.backgroundColor
        // color: "transparent"
        radius: Appearance.rounding.small

        // Height is header + content (if expanded) + margins
        Layout.preferredHeight: headerRow.implicitHeight + Appearance.padding.small * 2 + (root.expanded ? contentWrapper.implicitHeight : 0) + (anchors.topMargin + anchors.bottomMargin)

        Behavior on Layout.preferredHeight {
            Anim {}
        }

        ColumnLayout {
            anchors.fill: parent

            // Header
            RowLayout {
                id: headerRow
                Layout.topMargin: Appearance.padding.small
                Layout.leftMargin: Appearance.padding.large
                Layout.rightMargin: Appearance.padding.small
                Layout.bottomMargin: Appearance.padding.small

                spacing: Appearance.spacing.normal
                implicitHeight: Appearance.spacing.normal + Appearance.padding.small * 2

                StyledText {
                    Layout.fillWidth: true
                    text: root.title
                    elide: Text.ElideRight
                    font.pointSize: Appearance.font.size.smaller
                    font.family: Appearance.font.family.sans
                }

                StyledRect {
                    // color: Colours.palette.m3primary
                    color: root.expanded ? Colours.palette.m3primary : Colours.palette.m3secondaryContainer

                    radius: Appearance.rounding.small

                    implicitWidth: expandIcon.implicitWidth + Appearance.padding.small * 2
                    implicitHeight: expandIcon.implicitHeight + Appearance.padding.small

                    StateLayer {
                        function onClicked(): void {
                            root.expanded = !root.expanded;
                        }
                    }

                    MaterialIcon {
                        id: expandIcon
                        anchors.centerIn: parent
                        animate: true
                        text: root.expanded ? "expand_more" : "keyboard_arrow_right"
                        color: root.expanded ? Colours.palette.m3onPrimary : Colours.palette.m3onSecondaryContainer

                        font.pointSize: Appearance.font.size.large
                    }
                }
            }

            // Collapsible content
            WrapperItem {
                id: contentWrapper
                Layout.fillWidth: true
                Layout.leftMargin: Appearance.padding.smaller
                Layout.rightMargin: Appearance.padding.smaller

                // Animate height for smooth expand/collapse
                Layout.preferredHeight: root.expanded ? contentLoader.implicitHeight + topMargin + bottomMargin : 0
                clip: true

                // topMargin: Appearance.spacing.smaller
                // bottomMargin: Appearance.spacing.smaller
                bottomMargin: Appearance.padding.large

                Loader {
                    id: contentLoader
                    Layout.fillWidth: true
                    active: root.expanded
                }

                Behavior on Layout.preferredHeight {
                    Anim {}
                }
            }
        }
    }

    function collapse(): void {
        if (expanded) {
            expanded = false;
        }
    }

    onExpandedChanged: {
        if (!expanded) {
            collapsed();
        }
    }
}
