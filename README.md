Some docs for myself for next time I have to install and configure Arch Linux.

The install setup is LVM on LUKS, https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS

Each item in the list is a package, with some notes if needed. It's best to
install vim and terminal emulator (alacritty in this case) during the install,
otherwise, when booted into i3, there's no way to launch a terminal
(i3-sensible-terminal doesn't evaluate to anything).

* alacritty
* zsh
  * base_atelier_dune is the theme I use
  * install instructions here https://github.com/chriskempson/base16-shell
* vim
  * to bootstrap, just install vim-plug and symlink .vimrc
  * vim-plug install instructions https://github.com/junegunn/vim-plug
* fzf
* fonts
  * [[ttf-font-awesome]]
  * tth-material-icons-git (from AUR)
  * Inconsolata and Hack from https://www.nerdfonts.com/
  * noto-fonts-emoji for terminal emojis
* git
* wpa_supplicant
* wifi-menu
* xrandr
* xorg-server
* xorg-xset
  * this is what I use to set the keyboard delay and repeat rate in i3 config
* xcape
  * this is used to implement the feature wher Caps Lock is Escape when pressed alone, or Control if pressed in combination with something else
* xorg-xmodmap
* i3
* polybar (from AUR)
* rofi
* otf-insonsolata-dz
* adobe-source-code-pro-font
* redshift
  * config file is in the dotfiles repo, that's where the location is specified as well
  * don't forget to `systemctl --user enable redshift.service` to have it run on startup
* pulseaudio
* syncthing
  * make sure to enable it in systemd with, `systemctl --user enable
      syncthing.service`
* nvidia-settings
  * this is a must, it's really easy to configure screen setups and it generates `/etc/X11/xorg.conf`

## Other

If dual booting with Windows, and there are issues with wifi being loaded during boot time, it's a [known issue](https://bugzilla.kernel.org/show_bug.cgi?id=201319) and solution is to turn off Fast Boot in Windows, instructions [here](https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi#about_dual-boot_with_windows_and_fast-boot_enabled)
