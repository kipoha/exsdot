import Quickshell.Io

JsonObject {
    property bool persistent: false
    property bool showOnHover: true
    property int dragThreshold: 20
    property Workspaces workspaces: Workspaces {}
    property Status status: Status {}
    property Sizes sizes: Sizes {}

    component Workspaces: JsonObject {
        property int shown: 4
        property bool rounded: true
        property bool activeIndicator: true
        property bool occupiedBg: true
        property bool showWindows: true
        property bool activeTrail: false
        property string label: "◦" // ""
        property string occupiedLabel: "⊙" // "󰮯"
        property string activeLabel: "󰮯" //Handled in workspace.qml
    }

    component Status: JsonObject {
        property bool showAudio: false
        property bool showKbLayout: false
        property bool showNetwork: true
        property bool showBluetooth: true
        property bool showBattery: true
    }

    component Sizes: JsonObject {
        property int innerHeight: 30
        property int windowPreviewSize: 400
        property int trayMenuWidth: 300
        property int batteryWidth: 250
        property int networkWidth: 320
    }
}
