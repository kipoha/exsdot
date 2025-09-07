//@ pragma UseQApplication

import QtQuick
import QuickShell
import "./modules/bar/"

ShellRoot {
  id: root

  Loader {
    active: true
    souceComponent: bar{}
  }
}
