import QtQuick
import QtQuick.Layouts
import qs.config

ColumnLayout {
    id: processesTab
    anchors.fill: parent
    spacing: Appearance.padding.normal

    property var contextMenu: null

    SystemOverview {
        Layout.fillWidth: true
    }

    ProcessListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        contextMenu: processesTab.contextMenu || localContextMenu
    }

    ProcessContextMenu {
        id: localContextMenu
    }
}
