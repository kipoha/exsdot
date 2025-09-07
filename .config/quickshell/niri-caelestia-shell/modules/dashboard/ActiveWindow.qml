pragma ComponentBehavior: Bound

import qs.components
import qs.services
import qs.utils
import qs.config
import QtQuick

Item {
    id: root

    property color classColour: Colours.palette.m3primary
    property color titleColour: Colours.palette.m3secondary
    readonly property Item child: child

    // The width available for text (excluding icon and spacing)
    // TODO: Fix change window when panel open, still overflows.

    property int textAvailableWidth: Math.max(0, width - icon.width - Appearance.spacing.small)

    implicitWidth: child.implicitWidth
    implicitHeight: child.implicitHeight

    function cleanWindowTitle(windowClass, windowTitle) {
        // Remove leading non-ASCII (icon) characters and whitespace Firefox Fix.
        if (windowClass && windowClass.toLowerCase() === "firefox" && windowTitle) {
            // Remove all leading non-printable or non-ASCII chars (favicons are often in the Unicode private use area or emoji)
            // This regex removes all leading chars that are not basic ASCII printable (32-126)
            return windowTitle.replace(/^[^\x20-\x7E]+/, "");
        }
        return windowTitle;
    }

    Item {
        id: child

        property Item current: textRow1

        anchors.left: parent.left

        clip: true
        implicitWidth: icon.implicitWidth + current.implicitWidth + current.anchors.leftMargin
        implicitHeight: Math.max(icon.implicitHeight, current.implicitHeight)

        MaterialIcon {
            id: icon

            animate: true
            text: Icons.getAppCategoryIcon(Niri.focusedWindowClass, "desktop_windows")
            color: root.classColour

            anchors.verticalCenter: parent.verticalCenter
        }

        // Row for two-part colored text
        TitleRow {
            id: textRow1
            availableWidth: root.textAvailableWidth
        }
        TitleRow {
            id: textRow2
            availableWidth: root.textAvailableWidth
        }

        // Elision logic for both parts
        TextMetrics {
            id: metrics

            property string classPart: Niri.focusedWindowClass || ""
            property string rawTitlePart: Niri.focusedWindowTitle || "Hi!"
            property string cleanedTitlePart: root.cleanWindowTitle(classPart, rawTitlePart)
            property string separator: " -> "

            text: classPart + separator + cleanedTitlePart
            font.pointSize: Appearance.font.size.smaller
            font.family: Appearance.font.family.mono
            elide: Qt.ElideRight
            elideWidth: root.textAvailableWidth

            // Helper to split elided text into two parts
            function splitElidedText() {
                // Try to split at the first occurrence of separator
                let elided = elidedText;
                let sepIdx = elided.indexOf(separator);
                if (sepIdx === -1) {
                    // Fallback: all in class, empty title
                    return {
                        classPart: elided,
                        titlePart: ""
                    };
                }
                return {
                    classPart: elided.substring(0, sepIdx + separator.length),
                    titlePart: elided.substring(sepIdx + separator.length)
                };
            }

            function updateRows() {
                const next = child.current === textRow1 ? textRow2 : textRow1;
                const parts = splitElidedText();
                next.classText = parts.classPart;
                next.titleText = parts.titlePart;
                Qt.callLater(() => {
                    child.current = next;
                });
            }

            onTextChanged: updateRows()
            onElideWidthChanged: updateRows()
        }

        Behavior on implicitWidth {
            NumberAnimation {
                duration: Appearance.anim.durations.large
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }

        Behavior on implicitHeight {
            NumberAnimation {
                duration: Appearance.anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.anim.curves.emphasized
            }
        }
    }

    // Row of two colored StyledText elements
    component TitleRow: Row {
        id: row

        property string classText: ""
        property string titleText: ""
        property int availableWidth: 200 // default, will be set by parent

        anchors.verticalCenter: icon.verticalCenter
        anchors.left: icon.right
        anchors.leftMargin: Appearance.spacing.small

        spacing: 0 // Remove extra spacing

        // Both StyledText elements use implicitWidth, since elision is already handled
        StyledText {
            id: classPart
            text: row.classText
            font.pointSize: metrics.font.pointSize
            font.family: metrics.font.family
            color: root.classColour
            opacity: child.current === row ? 1 : 0
        }

        StyledText {
            id: titlePart
            text: row.titleText
            font.pointSize: metrics.font.pointSize
            font.family: metrics.font.family
            color: root.titleColour
            opacity: child.current === row ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: Appearance.anim.durations.normal
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Appearance.anim.curves.standard
                }
            }
        }
    }
}
