# 791E's winfiles (based on VSparl's dotfiles)

Since these configs kind of work like dotfiles (just for Windows), this repo is called winfiles. But since it is Windows, the configs are scattered all over the filesystem. To combat this, I have made this repository containing the necessary files and instructions to set up symlinks in such a way that all my "would-be dotfiles" are gathered in one spot.
Furthermore, this allows my configurations to stay updated and apply automatically, even if I make changes on only one device.

## Structure
This repo is broken down into directories for the different programs that store config files that I need accross multiple devices.
Each section also contains a `README.md`, outlining the usage and installation of the corresponding service.

## Tweaks.md
There is one additional file in the root directory ([`tweaks.md`](./tweaks.md)) in which I store smaller things like registry edits or scripts that I found useful but don't really have a spot in their own directory.

## Usage with Windows 10
On Windows 10, the sudo command doesn't exist, since it is only introduced in Windows 11 as an optional feature. In order for the commands to work, simply open a terminal with elevated privileges (execute it as Administrator) and use the commands without the `sudo` part at the start of the command
