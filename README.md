# dotfiles

I use GNU stow to manage the symlinks to my configs. From the base directory, you just run something like `stow vim alacritty bspwm sxhkd polybar` to link everything to the appropriate place in `$HOME`. If you want to import some of your own configs, look into the `--adopt` flag.

### Favorite software
Category | Software name | Comments
--- | :---: | ---
Favorite Linux distros | Arch, Grml, Debian, CentOS, Antergos | the Arch User Repository is amazingly helpful
Window manager | bspwm | window manager that seems to flow well
Display manager | LightDM | I use `lightdm-devel` from the AUR
Shell | bash | the fish and zsh journey ends with me at plain ol' bash
Terminal | alacritty | written in Rust
Bar | polybar | 
Web browser | Firefox Beta | version 57+
Password manager | Bitwarden | hosted, open source components, Android app, and browser extensions
File browser | nautilus, ranger
Torrent client | rtorrent, Flood | start in a tmux session (keep them torrents legal plz folks), with Flood as a front-end
AUR helper | pacaur | nicer than yaourt, install with [install-pacaur.sh](https://github.com/dbirks/scripts/blob/master/bash/install-pacaur.sh)
Email client | Thunderbird | just werks
Lock screen | light-locker | to use with lightdm
Backups | duplicity | with deja-dup as the frontend

### old

```
### Screenshot
![Screenshot](./screenshot.png?raw=true)
Here's a screenshot of my current setup. Running on the screen is rtorrent within tmux, nload, dstat, and htop. Screenshot taken with scrot.
```
