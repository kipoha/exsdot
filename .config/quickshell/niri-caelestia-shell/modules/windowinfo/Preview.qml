pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.config
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property ShellScreen screen
    // required property HyprlandToplevel client

    property var client: null // NEW LOGIC

    Connections {
        target: Niri // Listen to the Niri singleton

        function onFocusedWindowChanged(): void {
            root.client = Niri.focusedWindow || Niri.lastFocusedWindow || null;
        }
    }
    // Initial setup in Component.onCompleted
    Component.onCompleted: {
        root.client = Niri.focusedWindow || Niri.lastFocusedWindow;
    }

    Layout.preferredWidth: preview.implicitWidth + Appearance.padding.large * 2
    Layout.fillHeight: true

    StyledClippingRect {
        id: preview

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: label.top
        anchors.topMargin: Appearance.padding.large
        anchors.bottomMargin: Appearance.spacing.normal

        implicitWidth: view.implicitWidth

        color: Colours.tPalette.m3surfaceContainer
        radius: Appearance.rounding.small

        Loader {
            anchors.centerIn: parent
            active: !root.client
            asynchronous: true

            sourceComponent: ColumnLayout {
                spacing: 0

                MaterialIcon {
                    Layout.alignment: Qt.AlignHCenter
                    text: "web_asset_off"
                    color: Colours.palette.m3outline
                    font.pointSize: Appearance.font.size.extraLarge * 3
                }

                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("No active client")
                    color: Colours.palette.m3outline
                    font.pointSize: Appearance.font.size.extraLarge
                    font.weight: 500
                }

                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    text: qsTr("Try switching to a window")
                    color: Colours.palette.m3outline
                    font.pointSize: Appearance.font.size.large
                }
            }
        }

        ScreencopyView {
            id: view

            anchors.centerIn: parent

            // --- NIRI SPECIFIC CAPTURE SOURCE ---
            // Niri's 'Window' objects don't directly expose a `wayland` property for ScreencopyView.
            // You need to either:
            // 1. Extend Niri.qml's window objects with a 'waylandClient' property that resolves to a WaylandClient.
            // 2. Use Quickshell.Wayland.findClientByPid or findClientByAppId.
            // 3. (Best for Niri) Niri's IPC can provide direct surface IDs or handles that ScreencopyView might use.
            //    If your Niri.qml already enriches the window object with a direct WaylandClient object, use that.
            //    Otherwise, we'll try to find it.
            // Assuming your Niri.qml's 'Window' objects have a 'waylandClient' property (of type WaylandClient)
            // or we can lookup by pid/app_id.
            captureSource: {
                if (root.client) {
                    // Option 1: If you extended Niri.qml's window objects with a direct WaylandClient
                    // return root.client.waylandClient;

                    // Option 2: Look up by PID (more reliable than app_id for specific instances)
                    // This relies on Quickshell.Wayland.findClientByPid
                    return Quickshell.Wayland.findClientByPid(root.client.pid);

                    // Option 3: Look up by App ID (less precise if multiple windows of same app)
                    // return Quickshell.Wayland.findClientByAppId(root.client.app_id);
                }
                return null;
            }
            live: true

            constraintSize.width: parent.height
            constraintSize.height: parent.height
        }
    }

    StyledText {
        id: label

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Appearance.padding.large

        animate: true
        text: {
            const client = root.client;
            if (!client)
                return qsTr("No active client");

            const mon = client.monitor;
            return qsTr("%1 -> WORKSPACE: %2").arg(client.title).arg(client.workspace_id);
        }
    }
}
