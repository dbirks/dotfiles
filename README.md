# dotfiles

I use GNU stow to manage the symlinks to my configs. From the base directory, you just run something like `stow vim alacritty bspwm sxhkd polybar` to link everything to the appropriate place in `$HOME`.

Special case for the `nixos/` folder:

```
sudo stow nixos --target /
```
