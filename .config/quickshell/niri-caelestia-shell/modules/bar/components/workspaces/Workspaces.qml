pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    readonly property list<Workspace> workspaces: layout.children.filter(c => c.isWorkspace).sort((w1, w2) => w1.ws - w2.ws)
    readonly property var occupied: Niri.workspaceHasWindows
    readonly property int groupOffset: Math.floor((Niri.focusedWorkspaceIndex) / Config.bar.workspaces.shown) * Config.bar.workspaces.shown
    readonly property int focusedWindowId: Niri.focusedWindow.id

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    ColumnLayout {
        id: layout

        spacing: 0
        layer.enabled: true
        layer.smooth: true

        Repeater {
            model: Config.bar.workspaces.shown > Niri.getWorkspaceCount() ? Niri.getWorkspaceCount() : Config.bar.workspaces.shown

            Workspace {
                occupied: root.occupied
                groupOffset: root.groupOffset
                focusedWindowId: root.focusedWindowId
            }
        }
    }

    Loader {
        id: pager
        active: Config.bar.workspaces.shown < Niri.getWorkspaceCount()
        y: layout.implicitHeight

        sourceComponent: ColumnLayout {
            id: pagerContent
            // Start hidden and below, animate in when loaded
            property bool entered: false

            // Animate both y and opacity for a smooth effect
            y: entered ? 0 : 40
            opacity: entered ? 1 : 0

            // Animate when 'entered' changes
            Behavior on y {
                NumberAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }

            // Trigger animation when loaded
            Component.onCompleted: entered = true

            StyledRect {
                id: rectt

                color: Colours.palette.m3surfaceContainer
                Layout.alignment: Qt.AlignHCenter

                radius: Appearance.rounding.large
                implicitHeight: 30
                implicitWidth: root.width

                StyledText {
                    // Layout.alignment : Qt.AlignHCenter
                    readonly property int pageNumber: Math.floor(root.groupOffset / Config.bar.workspaces.shown) + 1
                    readonly property int totalPages: Math.ceil(Niri.getWorkspaceCount() / Config.bar.workspaces.shown)
                    text: qsTr(`${pageNumber} / ${totalPages}`)
                    // font.pointSize : 10

                }
            }
        }
    }

    Loader {
        active: Config.bar.workspaces.occupiedBg
        asynchronous: true

        z: -1
        anchors.fill: parent

        sourceComponent: OccupiedBg {
            workspaces: root.workspaces
            occupied: root.occupied
            groupOffset: root.groupOffset
        }
    }

    Loader {
        active: Config.bar.workspaces.activeIndicator
        asynchronous: true

        z: -1

        sourceComponent: ActiveIndicator {
            workspaces: root.workspaces
            // mask: layout
            maskWidth: root.width
            maskHeight: root.height
            groupOffset: root.groupOffset
        }
    }

    MouseArea {
        anchors.fill: parent
        // propagateComposedEvents: true
        z: -1
        onPressed: event => {
            const ws = layout.childAt(event.x, event.y).index + root.groupOffset + 1;
            if (Niri.focusedWorkspaceId + 1 !== ws)
                Niri.switchToWorkspace(ws);
        }
    }
}
