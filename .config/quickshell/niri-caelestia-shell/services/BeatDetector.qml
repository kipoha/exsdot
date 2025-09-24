pragma Singleton

import qs.utils
import Quickshell

// import Quickshell.Io

Singleton {
    id: root

    property real bpm: 150

    // This is a simple beat detector service that runs an external process to analyze audio input and extract the BPM (beats per minute).
    // It is disabled by default, as it requires an external binary (beat_detector) to be present in the specified path.
    // To enable it, uncomment the Process block below and ensure that the beat_detector binary is available in the CAELESTIA_LIB_DIR/beat_detector directory.
    // The beat_detector binary should be compiled from the source available at the main repo.

    // Process {
    //     running: true
    //     command: [`${Paths.libdir}/beat_detector`, "--no-log", "--no-stats", "--no-visual"]
    //     stdout: SplitParser {
    //         onRead: data => {
    //             const match = data.match(/BPM: ([0-9]+\.[0-9])/);
    //             if (match)
    //                 root.bpm = parseFloat(match[1]);
    //         }
    //     }
    // }
}
