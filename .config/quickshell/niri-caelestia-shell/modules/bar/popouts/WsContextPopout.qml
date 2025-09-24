pragma ComponentBehavior: Bound

import qs.services
import qs.config
import QtQuick

Item {
    id: root

    // Constants
    readonly property Item anchorWs: Niri.wsContextAnchor
    readonly property int anchorWsCount: Niri.wsContextType === "workspace" || Niri.wsContextType === "workspaces" ? 1 : Niri.wsContextAnchor?.windowCount
    readonly property real itemH: anchorWs.height + Config.bar.workspaces.windowIconGap * 2
    readonly property real expandedW: Config.bar.workspaces.windowContextWidth - Config.bar.workspaces.windowIconSize

    implicitHeight: anchorWs ? ((itemH + Appearance.padding.small) * anchorWsCount) : itemH - Appearance.padding.normal
    implicitWidth: root.expandedW
}
