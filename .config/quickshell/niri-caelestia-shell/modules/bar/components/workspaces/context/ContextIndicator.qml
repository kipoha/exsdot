pragma ComponentBehavior: Bound

import qs.services
import qs.config
import QtQuick
import qs.components.effects
import qs.components
import QtQuick.Shapes

Item {
    id: root

    required property int groupOffset
    required property int wsOffset
    required property Item anchorWs

    readonly property int anchorWsCount: (Niri.wsContextType === "item") ? Niri.wsContextAnchor?.windowCount : 1
    readonly property real rounding: Appearance.rounding.small
    readonly property real padding: Appearance.padding.small
    readonly property color bgColor: (Niri.wsContextType === "workspaces" && Niri.wsContextAnchor ? Colours.palette.m3surfaceContainer : Colours.palette.m3surfaceContainerHigh)

    property real cornerPieceSize: Config.bar.workspaces.windowIconSize + padding
    property bool activated: false

    Component.onCompleted: root.activated = true

    // Highlight rectangle component
    component HighlightRect: Item {
        id: hrect

        property int zOrder: 0
        property color highlightColor: root.bgColor
        property real strokeWidth: root.padding
        property real rounding: root.rounding
        property real roundingEffective: root.activated && Niri.wsContextAnchor ? rounding : 0

        Behavior on roundingEffective {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }

        z: zOrder
        width: root.activated && Niri.wsContextAnchor ? Config.bar.sizes.innerWidth - root.padding / 2 : 0
        height: (root.anchorWs.height) + root.padding
        x: 0
        y: root.anchorWs?.mapToItem(root, 0, 0).y - root.padding / 2

        // onYChanged: {
        //     // cancel any existing countdown
        //     wsAnchorClearTimer.stop();

        //     root.activated = false;

        //     // only start timer if it’s null
        //     if (root.activated === false) {
        //         wsAnchorClearTimer.start();
        //     }
        // }

        // property Timer wsAnchorClearTimer: Timer {
        //     interval: 1 // ms, adjust as you like
        //     repeat: false
        //     onTriggered: {
        //         if (root.activated === false) {
        //             root.activated = true;
        //         }
        //     }
        // }

        // Two corners: top & bottom
        Repeater {
            model: [3, 1] // top, bottom

            anchors.fill: parent
            anchors.right: parent.right

            delegate: Corner {
                required property var modelData
                cornerType: modelData
            }
        }

        Shape {
            preferredRendererType: Shape.CurveRenderer

            anchors.fill: parent

            ShapePath {
                strokeColor: hrect.highlightColor
                strokeWidth: hrect.strokeWidth
                fillColor: "transparent"
                capStyle: ShapePath.FlatCap
                joinStyle: ShapePath.RoundJoin

                startX: 0
                startY: hrect.roundingEffective
                PathArc {
                    x: hrect.roundingEffective
                    y: 0
                    radiusX: hrect.roundingEffective
                    radiusY: hrect.roundingEffective
                    direction: PathArc.Clockwise
                }
                PathLine {
                    x: hrect.width
                    y: 0
                }
                PathMove {
                    x: hrect.width
                    y: hrect.height
                }
                PathLine {
                    x: hrect.roundingEffective
                    y: hrect.height
                }
                PathArc {
                    x: 0
                    y: hrect.height - hrect.roundingEffective
                    radiusX: hrect.roundingEffective
                    radiusY: hrect.roundingEffective
                    direction: PathArc.Clockwise
                }
                PathLine {
                    x: 0
                    y: hrect.roundingEffective
                }
            }
        }

        // Generic animation for geometry
        Behavior on width {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
        Behavior on height {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
        Behavior on x {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
        Behavior on y {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
    }

    // Corner sub-component
    component Corner: CornerPiece {
        property int cornerType: 0 // 1 = bottom, 3 = top
        width: root.activated && Niri.wsContextAnchor ? root.cornerPieceSize : 0
        height: root.activated && Niri.wsContextAnchor ? root.cornerPieceSize / 2 : 0
        radius: Appearance.padding.normal
        orientation: cornerType
        color: parent.highlightColor
        opacity: parent.opacity

        anchors.right: parent.right
        anchors.rightMargin: -1
        anchors.top: cornerType === 1 ? parent.bottom : undefined
        anchors.bottom: cornerType === 3 ? parent.top : undefined
        anchors.topMargin: cornerType === 1 ? root.padding / 2 - 1 : undefined
        anchors.bottomMargin: cornerType === 3 ? root.padding / 2 - 1 : undefined

        Behavior on height {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
        Behavior on width {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
        Behavior on radius {
            Anim {
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
    }

    // Instances
    HighlightRect {
        id: highlightLow
        opacity: (Niri.wsContextType === "workspaces") ? 0 : 1
        highlightColor: Colours.palette.m3surfaceContainer
        anchors.top: highlight.top
        anchors.bottom: highlight.bottom
        anchors.left: highlight.left
        anchors.leftMargin: -root.padding
        anchors.topMargin: -root.padding + 1
        anchors.bottomMargin: -root.padding + 1
        rounding: Appearance.rounding.normal
    }

    HighlightRect {
        id: highlight
        anchors.right: parent.right
        anchors.rightMargin: root.padding
        opacity: (Niri.wsContextType === "workspaces") ? 0 : 1
        highlightColor: Colours.palette.m3background
        strokeWidth: root.padding + 0.5
    }
}
