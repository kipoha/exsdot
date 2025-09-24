import qs.components
import qs.services
import qs.config
import QtQuick

StyledRect {
    id: root
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    required property int groupOffset

    Component.onCompleted: active = true
    property bool active: false
    property bool entered: Config.bar.workspaces.shown < Niri.getWorkspaceCount() && active

    color: Colours.palette.m3surfaceContainer
    radius: entered ? Appearance.rounding.small / 2 : Appearance.rounding.full

    // Animate both y and opacity for a smooth effect
    anchors.topMargin: entered ? -Appearance.padding.normal : -Config.bar.sizes.innerWidth

    width: Config.bar.sizes.innerWidth - Appearance.spacing.small
    height: (text.contentHeight + Appearance.spacing.normal)

    // Animate when 'entered' changes
    Behavior on anchors.topMargin {
        Anim {}
    }

    StyledText {
        id: text

        opacity: root.entered ? 1 : 0
        Behavior on opacity {
            Anim {}
        }

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Appearance.spacing.small / 2

        font.family: Appearance.font.family.mono
        font.pointSize: Appearance.font.size.extraSmall

        color: Colours.palette.m3surfaceContainerHighest

        readonly property int pageNumber: Math.floor(root.groupOffset / Config.bar.workspaces.shown) + 1
        readonly property int totalPages: Math.ceil(Niri.getWorkspaceCount() / Config.bar.workspaces.shown)
        text: qsTr(`${pageNumber}/${totalPages}`)
    }
}
