pragma Singleton

import Quickshell

Singleton {
    property var screens: ({})

    function getForActive(): PersistentProperties {
        console.log("SCREENS JSON:", JSON.stringify(screens))
        var testScreens = Quickshell.screens;
        console.log("TEST SCREENS JSON:", JSON.stringify(testScreens))
        for (var [key, value] of Object.entries(screens)) {
            if (value.primary || value.active) {
                return value;
            }
        }

        var first = Object.entries(screens)[0];
        return first ? first[1] : null;
    }
}

