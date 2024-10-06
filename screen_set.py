#!/usr/bin/env python3
import subprocess
import time
import sys

"""
This script is a fix for what is presumably a bug, causing the secundary screen
to appear on the left side instead of the right side of the "main" screen.
Run it in the background.
"""

#--- set your secundary (right) screen below
sec = sys.argv[1]
#---

scr_id = sec+" connected"

def get_xrandr():
    return subprocess.check_output("xrandr").decode("utf-8")

def get_setup():
    # returns output of xrandr if secundary monitor was connected (else None)
    get_xr = subprocess.check_output("xrandr").decode("utf-8")
    if scr_id in get_xr:
        return get_xr

def get_xshift(xr):
    # find connected screens (lines)
    mons = [l for l in xr.splitlines() if " connected" in l]
    # get name and x-size of main screen
    left = [l.split() for l in mons if not l.startswith(scr_id)][0]
    return [(left[0], s.split("x")[0]) for s in left if s.count("+") == 2][0]

check1 = []
while True:
    time.sleep(4)
    check2 = get_setup()
    if check1 != check2:
        # on change in monitor setup:
        if check2 != None:
            # if secundary monitor was just connected
            print("run setup")
            x_shiftdata = get_xshift(check2)
            cmd1 = ["xrandr",  "--output", x_shiftdata[0], "--pos", "0x0"]
            cmd2 = ["xrandr",  "--output", sec, "--pos", x_shiftdata[1]+"x0"]
            for cmd in [cmd1, cmd2]:
                subprocess.call(cmd)
    check1 = check2

