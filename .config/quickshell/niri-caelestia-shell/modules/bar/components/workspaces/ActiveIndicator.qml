pragma ComponentBehavior: Bound
import qs.components
import qs.services
import qs.config
import QtQuick

StyledRect {
    id: root

    required property int activeWsId
    required property Repeater workspaces
    required property Item mask
    required property int groupOffset

    readonly property int currentWsIdx: {
        let i = activeWsId - 1;
        while (i < 0)
            i += Config.bar.workspaces.shown;
        return i % Config.bar.workspaces.shown;
    }
    onCurrentWsIdxChanged: {
        lastWs = cWs;
        cWs = currentWsIdx;
    }

    property int cWs
    property int lastWs

    // Geometry tracking
    property real leading: workspaces.itemAt(currentWsIdx)?.y ?? 0
    property real trailing: workspaces.itemAt(currentWsIdx)?.y ?? 0

    property real currentSize: workspaces.itemAt(currentWsIdx)?.size ?? 0
    property real offset: Math.min(leading, trailing)

    property real size: {
        const s = Math.abs(leading - trailing) + currentSize;
        if (Config.bar.workspaces.activeTrail && lastWs > currentWsIdx) {
            const ws = workspaces.itemAt(lastWs);
            return ws ? Math.min(ws.y + ws.size - offset, s) : 0;
        }
        return s;
    }

    property bool isContextActiveInWs: (Niri.wsContextType === "workspace" && Niri.wsContextAnchor?.index === root.currentWsIdx)
    property bool isWorkspacesContextActive: (Niri.wsContextType === "workspaces") && Niri.wsContextAnchor
    clip: false
    y: offset + mask.y
    implicitHeight: size
    radius: Appearance.rounding.small
    color: Qt.alpha(Colours.palette.m3primary, 0.95)

    anchors {
        left: parent.left
        right: parent.right
        leftMargin: Appearance.padding.small
        rightMargin: isWorkspacesContextActive ? -Config.bar.workspaces.windowContextWidth + Appearance.padding.small * 2 : Appearance.padding.small
        Behavior on rightMargin {
            EAnim {}
        }
    }

    Behavior on radius {
        EAnim {}
    }

    Loader {
        id: blob
        active: Config.bar.workspaces.focusedWindowBlob || root.isContextActiveInWs

        anchors {
            left: parent.left
            right: parent.right
            leftMargin: computeMargins().left
            rightMargin: computeMargins().right
            Behavior on leftMargin {
                Anim {}
            }
            Behavior on rightMargin {
                Anim {}
            }
        }

        function computeMargins() {
            if (!Niri.focusedWindowId)
                return {
                    left: Appearance.padding.small,
                    right: Appearance.padding.small
                };

            if (root.isContextActiveInWs && !root.isWorkspacesContextActive)
                return {
                    left: -Appearance.padding.small / 2,
                    right: -Config.bar.workspaces.windowContextWidth - Appearance.padding.small / 2
                };

            return {
                left: -Appearance.padding.small / 2,
                right: -Appearance.padding.small / 2
            };
        }

        sourceComponent: Rectangle {
            id: activeWindowIndicator
            height: Niri.focusedWindowId ? Config.bar.workspaces.windowIconSize + Appearance.padding.small + Config.bar.workspaces.windowIconGap * 2 : 0
            color: Colours.palette.m3primary
            radius: Niri.focusedWindowId ? Appearance.rounding.small / 2 : Appearance.rounding.large
            // bottomRightRadius: root.isContextActiveInWs ? Appearance.rounding.large : radius
            // topRightRadius: root.isContextActiveInWs ? Appearance.rounding.large : radius
            anchors.horizontalCenter: parent.horizontalCenter

            y: computeFocusedY()

            // staggered animations
            Behavior on y {
                Anim {}
            }
            Behavior on height {
                Anim {}
            }
            Behavior on radius {
                Anim {}
            }

            function computeFocusedY() {
                const focusedWindow = Niri.focusedWindow;
                if (!focusedWindow)
                    return Appearance.spacing.large / 2;

                // Get windows for the current workspace and sort them by layout position
                // This matches the sorting logic used in Workspace.qml
                const wsWindows = Niri.getActiveWorkspaceWindows().sort((a, b) => {
                    const aCol = a.layout?.pos_in_scrolling_layout[0] ?? 0;
                    const bCol = b.layout?.pos_in_scrolling_layout[0] ?? 0;
                    const aRow = a.layout?.pos_in_scrolling_layout[1] ?? 0;
                    const bRow = b.layout?.pos_in_scrolling_layout[1] ?? 0;

                    if (aCol !== bCol) {
                        return aCol - bCol;
                    }
                    return aRow - bRow;
                });

                let focusedIndex = -1;

                if (Config.bar.workspaces.groupIconsByApp) {
                    const grouped = Niri.groupWindowsByApp(wsWindows);
                    for (let i = 0; i < grouped.length; i++) {
                        // Use window ID comparison instead of object reference
                        if (grouped[i].windows.some(w => w.id === focusedWindow.id)) {
                            focusedIndex = i;
                            break;
                        }
                    }
                } else {
                    // Find the index of the focused window in the sorted array
                    focusedIndex = wsWindows.findIndex(w => w.id === focusedWindow.id);
                }

                // If window not found, default to first position
                if (focusedIndex === -1) {
                    focusedIndex = 0;
                }

                return (Config.bar.sizes.innerWidth - Appearance.padding.small * 2.5) + focusedIndex * (Config.bar.workspaces.windowIconSize + Config.bar.workspaces.windowIconGap);
            }
        }
    }

    // Trail animations
    Behavior on leading {
        enabled: Config.bar.workspaces.activeTrail
        Anim {}
    }
    Behavior on trailing {
        enabled: Config.bar.workspaces.activeTrail

        EAnim {
            duration: Appearance.anim.durations.normal * 2
        }
    }
    Behavior on currentSize {
        enabled: Config.bar.workspaces.activeTrail

        EAnim {}
    }
    Behavior on offset {
        enabled: !Config.bar.workspaces.activeTrail

        EAnim {}
    }
    Behavior on size {
        enabled: !Config.bar.workspaces.activeTrail

        EAnim {}
    }

    component EAnim: Anim {
        easing.bezierCurve: Appearance.anim.curves.emphasized
    }
}
