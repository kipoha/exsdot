pragma ComponentBehavior: Bound

import qs.components.filedialog
import qs.config
import qs.utils
import qs.services
import Quickshell
import Quickshell.Hyprland
import QtQuick

Item {
    id: root

    property bool expanded: false
    property bool isvisible: false

    required property PersistentProperties visibilities
    readonly property PersistentProperties state: PersistentProperties {
        property int currentTab

        readonly property FileDialog facePicker: FileDialog {
            title: qsTr("Select a profile picture")
            filterLabel: qsTr("Image files")
            filters: Images.validImageExtensions
            onAccepted: path => {
                Paths.copy(path, `${Paths.home}/.face`);
                Quickshell.execDetached(["notify-send", "-a", "caelestia-shell", "-u", "low", "-h", `STRING:image-path:${path}`, "Profile picture changed", `Profile picture changed to ${Paths.shortenHome(path)}`]);
            }
        }
    }

    // TODO add a way to dismiss with keyboard.
    // Keys.onEscapePressed: function () {
    //     root.expanded = false;
    //     root.isvisible = false;
    // }

    // Timer to control temporary visibility
    Timer {
        id: flashTimer
        interval: 500 // 0.5 second
        running: false
        repeat: false
        onTriggered: {
            root.isvisible = false;
        }
    }

    Connections {
        target: Niri
        function onFocusedWindowIdChanged() {
            // Show dashboard for 1 second
            if ((!root.visibilities.dashboard && !root.expanded) && Niri.focusedWindowId) {
                root.isvisible = true;
                flashTimer.restart();
            }
        }
    }

    visible: height > 0
    implicitHeight: 0
    implicitWidth: content.implicitWidth

    states: [
        State {
            name: "visible"
            when: root.isvisible || ((root.visibilities.dashboard && Config.dashboard.enabled) && !root.expanded)
            PropertyChanges {
                target: root
                implicitHeight: 45
            }
        },
        State {
            name: "expanded"
            when: (Config.dashboard.enabled) && root.expanded
            PropertyChanges {
                target: root
                implicitHeight: content.implicitHeight
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "visible"

            NumberAnimation {
                target: root
                property: "implicitHeight"
                duration: Appearance.anim.durations.expressiveDefaultSpatial
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
            }
        },
        Transition {
            from: "visible"
            to: ""

            NumberAnimation {
                target: root
                property: "implicitHeight"
                duration: Appearance.anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        },
        Transition {
            from: "*"
            to: "*"

            NumberAnimation {
                target: root
                property: "implicitHeight"
                duration: Appearance.anim.durations.expressiveDefaultSpatial
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
    ]

    HyprlandFocusGrab {
        active: !Config.dashboard.showOnHover && root.visibilities.dashboard && Config.dashboard.enabled
        windows: [QsWindow.window]
        onCleared: root.visibilities.dashboard = false
    }

    Loader {
        id: content

        Component.onCompleted: active = Qt.binding(() => (root.visibilities.dashboard && Config.dashboard.enabled) || root.visible)

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        sourceComponent: Content {
            visibilities: root.visibilities
            state: root.state
            // --- MouseArea for hover/click detection ---
            MouseArea {
                id: hoverArea
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                height: 50
                // hoverEnabled: true
                preventStealing: true
                // z: 1000
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (!root.expanded) {
                        root.expanded = true;
                    } else if (root.expanded) {
                        root.expanded = false;
                    }
                }
            }
        }
    }
}
