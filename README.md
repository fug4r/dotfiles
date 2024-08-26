# Dotfiles

Dotfiles are the customization files that are used to personalize your Linux or other Unix-based system.  
This repository contains my personal dotfiles, designed to work with Arch Linux.  
They are stored here for convenience so that I may quickly access them on new machines or new installs.  
Also, others may find some of my configurations helpful in customizing their own dotfiles.

## Neovim

The neovim configuration folder works on top of NvChad: https://github.com/NvChad/NvChad

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/dreamsofautonomy/dotfiles.git mydotfiles/
$ cd mydotfiles
```

then use GNU stow to create symlinks

```
$ stow --no-folding .
```
