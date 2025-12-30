#!/usr/bin/env python3

import gi
import subprocess
import sys
import json

if len(sys.argv) > 1:
    gi.require_version("Gtk", "3.0")
    from gi.repository import Gtk, Gdk

    def set_profile(profile):
        subprocess.run(["powerprofilesctl", "set", profile])
        Gtk.main_quit()

        subprocess.run(["pkill", "-RTMIN+1", "waybar"])


    class PowerPopup(Gtk.Window):
        def __init__(self):
            super().__init__(title="Power Profile")

            self.set_decorated(False)
            self.set_resizable(False)
            self.set_border_width(0)
            self.set_type_hint(Gdk.WindowTypeHint.POPUP_MENU)
            self.set_keep_above(True)
            self.activate_default()

            box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
            self.add(box)

            profiles = [
                ("Performance", "performance"),
                ("Balanced", "balanced"),
                ("Power Saver", "power-saver"),
            ]

            for label, profile in profiles:
                btn = Gtk.Button(label=label)
                btn.connect("clicked", lambda _, p=profile: set_profile(p))
                box.pack_start(btn, True, True, 0)

            # self.connect("focus-out-event", lambda *_: Gtk.main_quit())

            self.show_all()


    win = PowerPopup()
    Gtk.main()

output = subprocess.run(
    ["powerprofilesctl", "get"],
    capture_output=True,
    text=True
)

out = {}
out["class"] = output.stdout.strip()
out["alt"] = output.stdout.strip()
out["text"] = output.stdout.strip().capitalize() + " ⚡"

json_data = json.dumps(out)
print(json_data)

exit(0)
