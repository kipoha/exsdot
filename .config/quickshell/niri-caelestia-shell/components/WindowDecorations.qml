import qs.services
import qs.config
import QtQuick

StyledRect {
    property color basecolor: Colours.palette.m3secondaryContainer
    color: disabled ? Colours.palette.m3surfaceContainerLow : basecolor
    property color onColor: Colours.palette.m3onSurface
    property alias disabled: stateLayer.disabled
    property alias icon: icon.text

    function onClicked(): void {
    }

    radius: Appearance.rounding.normal
    implicitHeight: 20
    implicitWidth: 20

    MaterialIcon {
        id: icon
        color: parent.onColor
        font.pointSize: Appearance.font.size.normal
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        opacity: icon.text ? stateLayer.containsMouse : true
        Behavior on opacity {
            PropertyAnimation {
                property: "opacity"
                duration: Appearance.anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.anim.curves.standard
            }
        }
    }

    StateLayer {
        id: stateLayer
        color: parent.onColor
        function onClicked(): void {
            parent.onClicked();
        }
    }
}
