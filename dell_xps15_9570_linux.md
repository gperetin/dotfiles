## Firefox scrolling

To fix "tearing" in Firefox when scrolling, change the
layers.acceleration.force-enabled config setting in about:config to true.

## Touchpad config

Put the following in `/etc/X11/xorg.conf.d/30-touchpad.conf`:

```
Section "InputClass"
  Identifier "SYNA2393:00 06CB:7A13 Touchpad"
  MatchIsTouchpad "on"
  Driver "libinput"
  Option "Tapping" "on"
  Option "DisableWhileTyping" "on"
  Option "TappingDrag" "off"
  Option "AccelSpeed" "0.5"
EndSection
```

## Redshift config

Install Redshift via `apt`, then put the following in
`/etc/systemd/system/redshift.service`:

```
[Unit]
Description=Redshift display colour temperature adjustment
Documentation=http://jonls.dk/redshift/
After=display-manager.service

[Service]
ExecStart=/usr/bin/redshift
Restart=always

[Install]
WantedBy=default.target
```

Enable and start as:
```
systemctl --user enable redshift
systemctl --user start redshift
```
