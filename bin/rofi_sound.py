#! /usr/bin/env python

import subprocess
import sys

if len(sys.argv) == 1:
    out = subprocess.check_output(["pactl", "list", "short", "sinks"])
    sinks = out.decode("utf-8").strip().split("\n")

    fmt_sinks = []
    for s in sinks:
        fmt_sinks.append(s.split('\t')[1])
    sys.stdout.write("\n".join(fmt_sinks))
else:
    chosen = sys.argv[1].strip()
    try:
        subprocess.check_output(["pactl", "set-default-sink", chosen.strip()])
    except subprocess.CalledProcessError:
        pass
