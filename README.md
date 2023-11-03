<div align="center">

# policromia

awesomewm setup

</div>

## table of contents

- [details](#details)
- [screenshots](#screenshots)
- [setup](#setup)
  - [automatic](#automatic)
  - [manual](#manual)

## details

- os · [arch linux](https://archlinux.org/)
- shell · [zsh](https://www.zsh.org/)
- wm · [awesomewm](https://awesomewm.org/)
- terminal · [kitty](https://sw.kovidgoyal.net/kitty/)

## screenshots

<p align="center">
  <img src="assets/cyberpunk.png" width="700" />
  <img src="assets/dark.png" width="700" />
  <img src="assets/light.png" width="700" />
</p>

## keybindings

| Keys                                                      | Action                    |
| :-------------------------------------------------------- | :------------------------ |
| <kbd>Super</kbd> + <kbd>d</kbd>                           | Toggle dashboard          |
| <kbd>Super</kbd> + <kbd>e</kbd>                           | Open application launcher |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>s</kbd>        | Cropped screenshot        |
| <kbd>Super</kbd> + <kbd>t</kbd>                           | Toggle on top             |
| <kbd>Super</kbd> + <kbd>f</kbd>                           | Toggle fullscreen         |
| <kbd>Super</kbd> + <kbd>s</kbd>                           | Toggle floating           |
| <kbd>Super</kbd> + <kbd>Tab</kbd>                         | Focus next                |
| <kbd>Super</kbd> + <kbd>Control</kbd> + <kbd>+</kbd>      | Increase window opacity   |
| <kbd>Super</kbd> + <kbd>Control</kbd> + <kbd>-</kbd>      | Decrease window opacity   |
| <kbd>Super</kbd> + <kbd>Control</kbd> + <kbd>Return</kbd> | Reset window opacity      |

## setup

### automatic

```sh
sh -c "$(curl -fsSL https://github.com/mdmrk/policromia/install.sh)"
```

### manual

#### dependencies

Using [paru](https://github.com/Morganamilo/paru) as the AUR helper

```
paru -S awesome-git picom-git redshift kitty rofi xclip xorg-xwininfo scrot ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk networkmanager betterlockscreen playerctl brightnessctl pipewire pipewire-alsa pipewire-pulse alsa-utils acpi zsh gvfs thunar lsd zoxide bat fzf lxappearance materia-gtk-theme papirus-icon-theme
```

#### clone the repo

```
git clone --depth 1 --recurse-submodules https://github.com/mdmrk/policromia
cd policromia
```

#### install

```
mkdir -p ~/.config/awesome && cp -r config/awesome/* ~/.config/awesome
mkdir -p ~/.config/picom && cp -r config/picom/* ~/.config/picom
mkdir -p ~/.config/fontconfig/conf.d && cp -r config/fontconfig/* ~/.config/fontconfig/conf.d
mkdir -p ~/.config/kitty && cp -r config/kitty/* ~/.config/kitty
mkdir -p ~/.config/rofi && cp -r config/rofi/* ~/.config/rofi
mkdir -p ~/.local/share/fonts && cp -r fonts/* ~/.local/share/fonts
```
