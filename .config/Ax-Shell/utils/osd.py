import gi
import sys
from modules.osdpopup import OSDPopup, get_volume, get_brightness

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

popup = OSDPopup()

if len(sys.argv) < 2:
    print("Usage: osd_run.py [volume|brightness]")
    sys.exit(1)

if sys.argv[1] == "volume":
    popup.show_level(get_volume(), "🔊")
elif sys.argv[1] == "brightness":
    popup.show_level(get_brightness(), "🔆")
else:
    sys.exit(1)

GLib.timeout_add(1000, Gtk.main_quit)
Gtk.main()
