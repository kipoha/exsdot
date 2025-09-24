pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import qs.services
import qs.components
import qs.config

Column {
    id: root
    property var contextMenu: null

    Component.onCompleted: {
        SysMonitorService.addRef();
    }

    Component.onDestruction: {
        SysMonitorService.removeRef();
    }

    Item {
        id: columnHeaders

        width: parent.width
        anchors.leftMargin: Appearance.padding.small
        height: 24 + Appearance.padding.large

        StyledRect {
            width: 80
            height: 20
            color: processHeaderArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08) : "transparent"
            radius: Appearance.rounding.small
            anchors.left: parent.left
            anchors.leftMargin: Appearance.padding.normal
            anchors.verticalCenter: parent.verticalCenter

            StyledText {
                text: "Process"
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                font.weight: SysMonitorService.sortBy === "name" ? Font.Bold : Font.Medium
                color: Colours.palette.m3onSurface
                opacity: SysMonitorService.sortBy === "name" ? 1.0 : 0.7
                anchors.centerIn: parent
            }

            MouseArea {
                id: processHeaderArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    processListView.captureAnchor();
                    SysMonitorService.setSortBy("name");
                    processListView.restoreAnchor();
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Appearance.anim.durations.small
                }
            }
        }

        StyledRect {
            width: 80
            height: 20
            color: cpuHeaderArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08) : "transparent"
            radius: Appearance.rounding.normal
            anchors.right: parent.right
            anchors.rightMargin: 200
            anchors.verticalCenter: parent.verticalCenter

            StyledText {
                text: "CPU"
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                font.weight: SysMonitorService.sortBy === "cpu" ? Font.Bold : Font.Medium
                color: Colours.palette.m3primary
                opacity: SysMonitorService.sortBy === "cpu" ? 1.0 : 0.7
                anchors.centerIn: parent
            }

            MouseArea {
                id: cpuHeaderArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    processListView.captureAnchor();
                    SysMonitorService.setSortBy("cpu");
                    processListView.restoreAnchor();
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Appearance.anim.durations.small
                }
            }
        }

        StyledRect {
            width: 80
            height: 20
            color: memoryHeaderArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08) : "transparent"
            radius: Appearance.rounding.normal
            anchors.right: parent.right
            anchors.rightMargin: 112
            anchors.verticalCenter: parent.verticalCenter

            StyledText {
                text: "RAM"
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                font.weight: SysMonitorService.sortBy === "memory" ? Font.Bold : Font.Medium
                color: Colours.palette.m3tertiary
                opacity: SysMonitorService.sortBy === "memory" ? 1.0 : 0.7
                anchors.centerIn: parent
            }

            MouseArea {
                id: memoryHeaderArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    processListView.captureAnchor();
                    SysMonitorService.setSortBy("memory");
                    processListView.restoreAnchor();
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Appearance.anim.durations.small
                }
            }
        }

        StyledRect {
            width: 50
            height: 20
            color: pidHeaderArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08) : "transparent"
            radius: Appearance.rounding.normal
            anchors.right: parent.right
            anchors.rightMargin: 48
            anchors.verticalCenter: parent.verticalCenter

            StyledText {
                text: "PID"
                font.pointSize: Appearance.font.size.small
                font.family: Appearance.font.family.mono
                font.weight: SysMonitorService.sortBy === "pid" ? Font.Bold : Font.Medium
                color: Colours.palette.m3onSurface
                opacity: SysMonitorService.sortBy === "pid" ? 1.0 : 0.7
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
            }

            MouseArea {
                id: pidHeaderArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    processListView.captureAnchor();
                    SysMonitorService.setSortBy("pid");
                    processListView.restoreAnchor();
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Appearance.anim.durations.small
                }
            }
        }

        StyledRect {
            width: 28
            height: 28
            radius: Appearance.rounding.normal
            color: sortOrderArea.containsMouse ? Qt.rgba(Colours.palette.m3onSurface.r, Colours.palette.m3onSurface.g, Colours.palette.m3onSurface.b, 0.08) : "transparent"
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            StyledText {
                text: SysMonitorService.sortDescending ? "↓" : "↑"
                font.pointSize: Appearance.font.size.large
                color: Colours.palette.m3onSurface
                anchors.centerIn: parent
            }

            MouseArea {
                id: sortOrderArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    processListView.captureAnchor();
                    SysMonitorService.toggleSortOrder();
                    processListView.restoreAnchor();
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Appearance.anim.durations.small
                }
            }
        }
    }

    ListView {
        id: processListView

        property real stableY: 0
        property bool isUserScrolling: false
        property bool isScrollBarDragging: false

        width: parent.width
        height: parent.height - columnHeaders.height
        clip: true
        spacing: 4
        model: SysMonitorService.processes
        boundsBehavior: Flickable.StopAtBounds
        flickDeceleration: 1500
        maximumFlickVelocity: 2000

        onMovementStarted: isUserScrolling = true
        onMovementEnded: {
            isUserScrolling = false;
            if (contentY > 40) {
                stableY = contentY;
            }
        }

        onContentYChanged: {
            if (!isUserScrolling && !isScrollBarDragging && visible && stableY > 40 && Math.abs(contentY - stableY) > 10) {
                contentY = stableY;
            }
        }

        delegate: ProcessListItem {
            required property var modelData
            process: modelData
            contextMenu: root.contextMenu
        }

        ScrollBar.vertical: ScrollBar {
            id: verticalScrollBar
            policy: ScrollBar.AsNeeded

            onPressedChanged: {
                processListView.isScrollBarDragging = pressed;
                if (!pressed && processListView.contentY > 40) {
                    processListView.stableY = processListView.contentY;
                }
            }
        }
        ScrollBar.horizontal: ScrollBar {
            policy: ScrollBar.AlwaysOff
        }

        property real wheelMultiplier: 1.8
        property int wheelBaseStep: 160

        WheelHandler {
            target: null
            onWheel: ev => {
                let dy = ev.pixelDelta.y !== 0 ? ev.pixelDelta.y : (ev.angleDelta.y / 120) * processListView.wheelBaseStep;
                if (ev.inverted)
                    dy = -dy;

                const maxY = Math.max(0, processListView.contentHeight - processListView.height);
                processListView.contentY = Math.max(0, Math.min(maxY, processListView.contentY - dy * processListView.wheelMultiplier));

                ev.accepted = true;
            }
        }

        property string keyRoleName: "pid"
        property var _anchorKey: undefined
        property real _anchorOffset: 0

        function captureAnchor() {
            const y = contentY + 1;
            const idx = indexAt(0, y);
            if (idx < 0 || !model || idx >= model.length)
                return;
            _anchorKey = model[idx][keyRoleName];
            const it = itemAtIndex(idx);
            _anchorOffset = it ? (y - it.y) : 0;
        }

        function restoreAnchor() {
            Qt.callLater(function () {
                if (_anchorKey === undefined || !model)
                    return;

                var i = -1;
                for (var j = 0; j < model.length; ++j) {
                    if (model[j][keyRoleName] === _anchorKey) {
                        i = j;
                        break;
                    }
                }
                if (i < 0)
                    return;

                positionViewAtIndex(i, ListView.Beginning);
                const maxY = Math.max(0, contentHeight - height);
                contentY = Math.max(0, Math.min(maxY, contentY + _anchorOffset - 1));
            });
        }

        onModelChanged: {
            if (model && model.length > 0 && !isUserScrolling && stableY > 40) {
                // Preserve scroll position when model updates
                Qt.callLater(function () {
                    contentY = stableY;
                });
            }
        }
    }
}
