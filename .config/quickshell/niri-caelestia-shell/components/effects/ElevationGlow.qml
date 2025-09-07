import qs.services
import qs.config
import QtQuick
import QtQuick.Effects

// RectangularShadow {
//     anchors.fill: myRectangle
//     offset.x: -10
//     offset.y: -5
//     radius: myRectangle.radius
//     blur: 30
//     spread: 10
//     color: Qt.darker(myRectangle.color, 1.6)
// }

RectangularShadow {
    property int level
    property real dp: [0, 1, 3, 6, 8, 12][level]

    color: Qt.alpha("white", 0.7)
    // blur: (dp * 5) ** 0.7
    spread: -dp * 0.3 + (dp * 0.1) ** 2
    // offset.y: dp / 2
    radius: Appearance.rounding.large

    Behavior on dp {
        NumberAnimation {
            duration: Appearance.anim.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.standard
        }
    }
}
