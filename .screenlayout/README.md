These are the `xrandr` scripts I use to configure the resolutions of my
monitor setup.

I have this folder in my home folder, and run this manually after I connect my monitors, for example:
`.screenlayout/triple.sh` and then refresh my window manager to get the
desktop background right.

Nice improvement would be to hook this into the monitor connect/disconnect
events so that I don't have to run it manually. Looks like
[autorandr](https://github.com/phillipberndt/autorandr) is the tool for that.
