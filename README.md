# dockvimx
Development environment usable on windows (x windows) with vim on ubuntu through a Docker image and Vagrant.
Currently just experimental, it will probably change.
Based on [yavide](https://github.com/JBakamovic/yavide), this repository contains automated setup of a development environment in vim.

## Features
* Docker image/Dockerfile to set up development environment
* Vagrantfile usable to build and run docker image
* VIM based on [yavide](https://github.com/JBakamovic/yavide)
* Tmux and tmuxp with example setup "cpp"

## Installation
```bash
git clone https://github.com/gvatn/dockvimx.git
cd dockvimx
vagrant up
vagrant ssh
source /vagrant/startup.sh
```

This should open a terminal in Xming (if not see below about ssh_config).
To open a tmux session:
```bash
tmuxp cpp
```

## Tmux
Tmux prefix: C-a
Navigate panes with hjkl, resize with HJKL.

## Missing
Possibly X11_forwarding might need to be enabled in /etc/ssh/ssh_config