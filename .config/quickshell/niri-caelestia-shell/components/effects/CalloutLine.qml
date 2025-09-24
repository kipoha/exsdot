pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes

Item {
    id: root

    // Option A: raw coordinates
    property point fromPoint: Qt.point(0, 0)
    property point toPoint: Qt.point(width, height)

    // Option B: items to follow (auto-updates if they move/resize)
    property Item fromItem
    property Item toItem

    property color lineColor: "white"
    property real lineWidth: 2
    property bool useItems: fromItem && toItem

    // effective points → prefer item mapping if available
    readonly property point effectiveFrom: useItems ? mapFromItem(fromItem, fromItem.width / 2, fromItem.height / 2) : fromPoint

    readonly property point effectiveTo: useItems ? mapFromItem(toItem, 0, toItem.height / 2) : toPoint

    Shape {
        anchors.fill: parent

        ShapePath {
            strokeColor: root.lineColor
            strokeWidth: root.lineWidth
            fillColor: "transparent"

            startX: root.effectiveFrom.x
            startY: root.effectiveFrom.y

            PathLine {
                x: root.effectiveTo.x
                y: root.effectiveTo.y
            }
        }
    }
}
