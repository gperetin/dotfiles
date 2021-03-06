# Notes for Arch Linux setup on Dell XPS 15 9570

## Dell XPS 15 9570 article on arch wiki

This one [here]https://wiki.archlinux.org/index.php/Dell_XPS_15_9570). I
didn't do everything as written there, mainly, seems like just blacklisting
nouveau worked for me to disable the nvidia stuff and fix problems.

I did do the undervolting as per that wiki and seems to be working.

## Blacklisting Nouveau

This is a must, it fixes the issue where laptop would get permanently frozen
when shutting down and would never power off. Also removes a bunch of errors
in dmesg. From what I understood, it comes with the kernel so it can't be
easily removed, but it can be blacklisted.

Create a file in `/etc/modprobe.d/blacklist-nouveau.conf` with contents
`blacklist nouveau`.

## AlgoVPN (ipsec)

(there are some instructions in [AlgoVPN
readme](https://github.com/trailofbits/algo#ubuntu-server-1804-example))

* strongswan needs to be installed
* to set up copy the following from the generated Algo VPN configs folder:
** contents of `ipsec_{user}.conf` into `/etc/ipsec.conf`
** add an entry into `/etc/ipsec.secrets`: `<ip_address> : ECDSA {user.key}`
** `cp cacert.pem /etc/ipsec.d/cacerts`
** `cp pki/certs/{user.crt} /etc/ipsec.d/certs`
** `cp pki/private/{user.key} /etc/ipsec.d/private`

Then restart ipsec and try connecting:

```
    sudo ipsec stop
    sudo ipsec up ikev2-{ip}
```

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

Enable and start as:
```
systemctl --user enable redshift
systemctl --user start redshift
```

## Time

Make sure time in BIOS is set to be UTC if dual booting. Otherwise, time will
shift between boots into Windows and Linux, and Linux will be off because it
understands the time set in BIOS as UTC.
