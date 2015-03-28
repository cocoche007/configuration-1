Dotfiles repository
===================

_One repository to configure all_

Each software configuration is located on a single folder.

* *vim*: Vim configuration with ExVim IDE installation
* *zsh*: Zsh configuration
* *i3*: i3 windows manager configuration

Vim
---

This folder contains Vim configuration files to set up
an ExVim environment to easely develop mainly C/C++
program on GNU/Linux with Dvorak Bépo keyboard (french
variant of Dvorak layout, see http://bepo.fr).

### Dependencies

* vim (obviously)
* ctags
* _probably some other software that I do not remember_

### Installation

To install, go in `vim` folder and run `./install.sh`
script.

Zsh
---

This folder contains Z-shell configuration files. It
enables my prompt theme with the following format:

    (history_id)[user@host:path|time]$

Additionnaly, more information are available in prompt
if you are in a Git repository (including current branch,
current remote, current commit hash, and current status…).

### Dependencies

* zsh (obviously)
* git

### Installation

To install, go in `zsh` folder and run `./install.sh`
script.

i3
--

This folder contains my configuration for i3 windows
manager, and necessary files to set a "decent" X server
configuration run with `startx` utility.

### Dependencies

* i3 (obviously)
* dunst (for notification manager)
* i3blocks (to replace i3status)
* python
* dzen
* imagemagick
* i3lock
* scrot
* [payap](https://redmine.yapbreak.fr/project/payap)
* feh (for desktop background handling)

### Installation

To install, go in `i3` folder and run `./install.sh`
script.

