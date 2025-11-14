# trnr-wm

Lightweight window manager for linux. Uses modified versions of dwm and dmenu with global theming.
Under construction.

## Requirements
In order to build trnr-wm you need the Xlib header files.

For debian:
```
sudo apt install libx11-dev libxft-dev libxinerama-dev
```

## Installation
Edit config.mk to match your local setup (dwm and dmenu are installed into the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm (if
necessary as root):
```
    make clean install
```

## Running dwm
Add the following line to your .xinitrc to start dwm using startx:
```
    exec dwm
```

## Configuration
Global theming can be configured by editing the common/theme.h file and recompilation.

## Info
dwm has been modified with the following patches:
- bar and window gaps
- fibonacci/dwindle layouts
- fsignal to change layouts
- default layout per tag
- movestack
- restartsig
- others I have probably forgotten about

dmenu has been modified with the following patches:
- center
