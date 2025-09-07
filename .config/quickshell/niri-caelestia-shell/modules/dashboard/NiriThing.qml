import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    // Layout.fillWidth: true
    // Layout.fillHeight: true

    property var client: null

    Connections {
        target: Niri // Listen to the Niri singleton
        function onFocusedWindowChanged(): void {
            root.client = Niri.focusedWindow || Niri.lastFocusedWindow || null;
        }
    }

    Component.onCompleted: {
        root.client = Niri.focusedWindow || Niri.lastFocusedWindow;
    }

    // ***************************************************
    CollapsibleSection {
        id: moveWorkspaceDropdown // Give it an ID to reference its functions
        Layout.preferredWidth: 800
        title: qsTr("Move Window to Workspace")
        GridLayout {
            id: wsGrid
            columns: 5

            Repeater {
                model: Niri.getWorkspaceCount()

                Button {
                    required property int index
                    readonly property int wsId: Math.floor((Niri.focusedWorkspaceIndex) / 10) * 10 + index + 1
                    readonly property bool isCurrent: (wsId - 1) % 10 === Niri.focusedWorkspaceIndex

                    color: isCurrent ? Colours.palette.m3surfaceContainerHighest : Colours.palette.m3tertiaryContainer
                    onColor: isCurrent ? Colours.palette.m3onSurface : Colours.palette.m3onTertiaryContainer
                    text: (Niri.allWorkspaces[wsId - 1].name) || "Workspace: " + wsId
                    disabled: isCurrent

                    function onClicked(): void {
                        Niri.moveWindowToWorkspace(wsId);
                    }
                }
            }
        }
    }

    CollapsibleSection {
        id: utilities // Give it an ID to reference its functions
        title: qsTr("Window Utilities")
        backgroundMarginTop: 0
        expanded: true

        //  toggleWindowOpacity
        //  expandColumnToAvailable
        //  centerWindow
        //  screenshotWindow
        //  keyboardShortcutsInhibitWindow
        //  toggleWindowedFullscreen
        //  toggleFullscreen
        //  toggleMaximize

        RowLayout {
            ColumnLayout {
                RowLayout {
                    // toggleFullscreen - Button 3
                    Button {
                        color: Colours.palette.m3secondaryContainer
                        onColor: Colours.palette.m3onSecondaryContainer
                        text: qsTr("Toggle Fullscreen")
                        icon: "fullscreen"
                        function onClicked(): void {
                            Niri.toggleFullscreen();
                        }
                    }

                    // toggleWindowedFullscreen - Button 4
                    Button {
                        color: Colours.palette.m3secondaryContainer
                        onColor: Colours.palette.m3onSecondaryContainer
                        icon: "disabled_visible"
                        text: qsTr("Toggle Fake Fullscreen")
                        function onClicked(): void {
                            Niri.toggleWindowedFullscreen();
                        }
                    }

                    // expandColumnToAvailable - Button 6
                    // Button {
                    //     color: Colours.palette.m3secondaryContainer
                    //     onColor: Colours.palette.m3onSecondaryContainer
                    //     icon: "view_column"
                    //     text: qsTr("Expand Column")
                    //     function onClicked(): void {
                    //         Niri.expandColumnToAvailable();
                    //     }
                    // }
                }
                // Center - Button 1
                Button {
                    color: Colours.palette.m3secondaryContainer
                    onColor: Colours.palette.m3onSecondaryContainer
                    text: qsTr("Center")
                    icon: "center_focus_strong"
                    function onClicked(): void {
                        Niri.centerWindow();
                    }
                }
                // Inhibit Shortcuts - Button 2
                Button {
                    color: Colours.palette.m3secondaryContainer
                    onColor: Colours.palette.m3onSecondaryContainer
                    icon: "disabled_visible"
                    text: qsTr("Inhibit Shortcuts")
                    function onClicked(): void {
                        Niri.keyboardShortcutsInhibitWindow();
                    }
                }
            }

            // Screenshot - Button 3

            Button {
                Layout.fillHeight: true
                color: Colours.palette.m3secondaryContainer
                onColor: Colours.palette.m3onSecondaryContainer
                text: qsTr("Screenshot Window")
                icon: "photo_camera"
                function onClicked(): void {
                    Niri.screenshotWindow();
                }
            }

            // // toggleWindowOpacity - Button 5
            // Button {
            //     color: Colours.palette.m3secondaryContainer
            //     onColor: Colours.palette.m3onSecondaryContainer
            //     icon: "opacity"
            //     text: qsTr("Toggle Opacity")
            //     function onClicked(): void {
            //         Niri.toggleWindowOpacity();
            //     }
            // }
        }
    }

    // Rect {
    //     Layout.row: 1
    //     Layout.column: 4
    //     Layout.preferredWidth: resources.implicitWidth
    //     Layout.fillHeight: true
    // }

    // Rect {
    //     Layout.row: 0
    //     Layout.column: 5
    //     Layout.rowSpan: 2
    //     Layout.preferredWidth: media.implicitWidth
    //     Layout.fillHeight: true
    // }

    // ***************************************************

    component Rect: StyledRect {
        radius: Appearance.rounding.small
        color: Colours.palette.m3surfaceContainerLow
    }

    // Your global Button component (if defined here)
    component Button: StyledRect {
        property color onColor: Colours.palette.m3onSurface
        property alias disabled: stateLayer.disabled
        property alias text: label.text
        property alias icon: icon.text

        function onClicked(): void {
        }

        Layout.fillWidth: true

        radius: Appearance.rounding.small

        implicitHeight: (icon.implicitHeight + Appearance.padding.small * 2)
        implicitWidth: (52 + Appearance.padding.small * 2)

        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            // anchors.left: parent.left

            Item {
                Layout.fillWidth: true
            }
            MaterialIcon {
                id: icon
                color: parent.parent.onColor
                // font.pointSize: Appearance.font.size.large
                text: "radio_button_unchecked"
                font.pointSize: label.font.pointSize * 3.0

                // anchors.verticalCenter: parent.verticalCenter
                Layout.alignment: Qt.AlignVCenter

                // opacity: icon.text ? !stateLayer.containsMouse : true
                // Behavior on opacity {
                //     PropertyAnimation {w
                //         property: "opacity"
                //         duration: Appearance.anim.durations.normal
                //         easing.type: Easing.BezierSpline
                //         easing.bezierCurve: Appearance.anim.curves.standard
                //     }
                // }
            }
            StyledText {
                id: label
                color: parent.parent.onColor
                font.pointSize: Appearance.font.size.small
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                Layout.preferredWidth: 90 // Adjust as needed for your layout
                // Optionally, set elide if text is too long
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                // horizontalAlignment: Text.AlignLeft
                // opacity: icon.text ? stateLayer.containsMouse : true
                // Behavior on opacity {
                //     PropertyAnimation {
                //         property: "opacity"
                //         duration: Appearance.anim.durations.normal
                //         easing.type: Easing.BezierSpline
                //         easing.bezierCurve: Appearance.anim.curves.standard
                //     }
                // }
            }
        }

        StateLayer {
            id: stateLayer
            color: parent.onColor
            function onClicked(): void {
                parent.onClicked();
            }
        }
    }
}
