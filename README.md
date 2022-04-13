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
* neovim
  * for LSP support, install desired language servers. For Rust, use
      rust-analyzer (make sure it's in $PATH). For Python, pyls_ms
  * for latter, don't forget to install dotnet-runtime https://wiki.archlinux.org/index.php/.NET_Core
* fzf
* fonts
  * nerd-fonts-complete from AUR has the entire nerd fonts collection, it's
      2GB though
  * [[ttf-font-awesome]]
  * tth-material-icons-git (from AUR)
  * Inconsolata and Hack from https://www.nerdfonts.com/
  * noto-fonts-emoji for terminal emojis
  * this is where the picker is https://www.nerdfonts.com/cheat-sheet, it can
      be pasted into terminal as well
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
* lsd
* git-delta
* otf-insonsolata-dz
* adobe-source-code-pro-font
* redshift
  * config file is in the dotfiles repo, that's where the location is specified as well
  * don't forget to `systemctl --user enable redshift.service` to have it run on startup
  * since I'm not running a display manager, I have to edit provided systemd
      service file, info here https://wiki.archlinux.org/index.php/Redshift#Redshift_works_fine_when_invoked_as_a_command_but_fails_when_run_as_a_systemd_service
* ranger (file manager)
* zathura (PDF viewer) + zathura-pdf-mupdf for PDF support
* pulseaudio
* syncthing
  * make sure to enable it in systemd with, `systemctl --user enable
      syncthing.service`
* nvidia-settings
  * this is a must, it's really easy to configure screen setups and it generates `/etc/X11/xorg.conf`
* nfancurve
  * this is for controling the fan speed on the graphics card. Without this,
      fan is jerky and keeps spinning up and making weird clicks.
  * don't forget to set Coolbits parameter in xorg.conf, it's in USAGE docs
      for nfancurve
* to tweak the mouse settings, use libinput https://wiki.archlinux.org/index.php/Mouse_acceleration#Mouse_acceleration_with_libinput

## Other

If dual booting with Windows, and there are issues with wifi being loaded during boot time, it's a [known issue](https://bugzilla.kernel.org/show_bug.cgi?id=201319) and solution is to turn off Fast Boot in Windows, instructions [here](https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi#about_dual-boot_with_windows_and_fast-boot_enabled)
