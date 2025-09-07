pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.utils
import qs.config
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.components.effects

Item {
    id: root

    required property int index
    required property var occupied
    required property int groupOffset
    required property int focusedWindowId

    readonly property bool isWorkspace: true // Flag for finding workspace children
    // Unanimated prop for others to use as reference
    readonly property real size: childrenRect.height + (hasWindows ? Appearance.padding.smaller : 0)

    readonly property int ws: groupOffset + index + 1
    readonly property bool isOccupied: occupied[ws] ?? false
    readonly property bool hasWindows: isOccupied && Config.bar.workspaces.showWindows

    readonly property int currentWorkspace: Niri.focusedWorkspaceIndex + 1 // + 1 cuz Niri index starts with 0 this needs 1.

    Layout.preferredWidth: childrenRect.width
    Layout.preferredHeight: size

    // To make the windows repopulate.

    onGroupOffsetChanged: {
        windows.active = false;
        windows.active = true;
    }

    StyledText {
        id: indicator

        readonly property string label: Config.bar.workspaces.label || root.ws
        readonly property string occupiedLabel: Config.bar.workspaces.occupiedLabel || label
        readonly property string activeLabel: root.currentWorkspace || (root.isOccupied ? occupiedLabel : label)

        animate: true
        text: root.currentWorkspace === root.ws ? activeLabel : root.isOccupied ? occupiedLabel : label
        // color: Config.bar.workspaces.occupiedBg || root.isOccupied || root.currentWorkspace === root.ws ? Colours.palette.m3onSurface : (Colours.palette.m3outlineVariant, 2)

        color: root.currentWorkspace === root.ws ? Colours.palette.m3onPrimary // <--- customize to your active color
         : (root.isOccupied ? Colours.palette.m3onSurface : Colours.palette.m3outlineVariant)

        horizontalAlignment: StyledText.AlignHCenter
        verticalAlignment: StyledText.AlignVCenter

        width: Config.bar.sizes.innerHeight
        height: Config.bar.sizes.innerHeight
    }

    Loader {
        id: windows

        active: Config.bar.workspaces.showWindows
        asynchronous: true

        anchors.horizontalCenter: indicator.horizontalCenter
        anchors.top: indicator.bottom
        anchors.topMargin: -Config.bar.sizes.innerHeight / 10

        sourceComponent: Column {
            spacing: 0

            add: Transition {
                Anim {
                    properties: "scale"
                    from: 0
                    to: 1
                    easing.bezierCurve: Appearance.anim.curves.standardDecel
                }
            }

            move: Transition {
                Anim {
                    properties: "scale"
                    to: 1
                    easing.bezierCurve: Appearance.anim.curves.standardDecel
                }
                Anim {
                    properties: "x,y"
                }
            }

            Repeater {
                model: ScriptModel {
                    // WARNING DEFAULT:
                    // values: Niri.toplevels.filter(c => c.workspace_id === root.ws)

                    readonly property int targetWorkspaceId: {
                        const niriWorkspace = Niri.allWorkspaces[root.index + root.groupOffset];
                        return niriWorkspace.id;
                    }

                    values: Niri.windows.filter(c => c.workspace_id === targetWorkspaceId)
                    // .slice(0, Config.bar.workspaces.shown) //max windows shown
                }

                // TODO Setting to show App Images instead Material Icons, in config :)

                // IconImage {
                //     id: icon
                //     required property var modelData
                //     // grade: 0

                //     // Layout.alignment: Qt.AlignVCenter
                //     implicitSize: 25
                //     source: Icons.getAppIcon(modelData.app_id ?? "", "image-missing")
                //     Layout.margins: Appearance.padding.small

                MaterialIcon {
                    id: icon
                    required property var modelData

                    // The shadow
                    Loader {
                        active: root.focusedWindowId === parent.modelData.id
                        asynchronous: true
                        z: -1
                        anchors.fill: parent

                        sourceComponent: ElevationGlow {
                            level: 1 // Change this to set shadow depth (0-5)
                        }
                    }

                    font.pointSize: root.focusedWindowId === modelData.id ? Appearance.font.size.large : Appearance.font.size.larger

                    anchors.horizontalCenter: parent.horizontalCenter

                    grade: 0
                    text: Icons.getAppCategoryIcon(modelData.app_id, "help_center")
                    // color: root.focusedWindowId === modelData.id ? Colours.palette.m3primary : Colours.palette.m3onSurfaceVariant

                    color: root.currentWorkspace === root.ws ? (Colours.palette.m3onPrimary) : Colours.palette.m3onSurfaceVariant

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        cursorShape: Qt.PointingHandCursor

                        onClicked: mouse => {
                            if (mouse.button === Qt.LeftButton) {
                                console.log("Right-clicked on window:", icon.modelData.title, "ID:", icon.modelData.id);
                                if (icon.modelData && Niri.focusWindow) {
                                    Niri.focusWindow(icon.modelData.id);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Behavior on Layout.preferredWidth {
        Anim {}
    }

    Behavior on Layout.preferredHeight {
        Anim {}
    }

    component Anim: NumberAnimation {
        duration: Appearance.anim.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.standard
    }
}
