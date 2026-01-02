#!/usr/bin/env python3

import gi
import subprocess
import sys
import json

output = subprocess.run(
    ["powerprofilesctl", "get"],
    capture_output=True,
    text=True
).stdout.strip()

profile_dic = {
    "previous": {
        "performance": "power-saver",
        "balanced": "performance",
        "power-saver": "balanced",
    },
    "next": {
        "performance": "balanced",
        "balanced": "power-saver",
        "power-saver": "performance",
    },
}

if len(sys.argv) > 1:
    action = sys.argv[1]

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

            self._format_css()

            box_layout = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
            self.add(box_layout)

            profiles = [
                ("󰊗 Performance", "performance"),
                (" Balanced", "balanced"),
                (" Power Saver", "power-saver"),
            ]

            for label, profile in profiles:
                btn = Gtk.Button(label=label)
                btn.connect("clicked", lambda _, p=profile: set_profile(p))
                box_layout.pack_start(btn, True, True, 0)

            self.show_all()


        def _format_css(self):
            screen = Gdk.Screen.get_default()
            style_provider = Gtk.CssProvider()
            style_context = Gtk.StyleContext()
            style_context.add_provider_for_screen(screen, style_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)

            style_provider.load_from_data(b"""
                * {
                    font-family: "BitstromWera Nerd Font Mono", monospace;
                    font-size: 18px;
                }
                .background {
                    margin: 0;
                    padding: 0;
                    box-shadow: 0 0 0 0;
                }
            """)


    if action == "menu":
        win = PowerPopup()
        Gtk.main()
    elif action == "previous" or action == "next":
        set_profile( profile_dic[action][output])


output = subprocess.run(
    ["powerprofilesctl", "get"],
    capture_output=True,
    text=True
).stdout.strip()

out = {}
out["class"] = output
out["alt"] = output
out["text"] = output.capitalize()

json_data = json.dumps(out)
print(json_data)

exit(0)
