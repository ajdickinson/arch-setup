This repository is a guide/documentation of my current linux set to streamline any future installations. This repo is public but in rough rough shape. This README will change once I have the shell scripts up and running.

Based off the following references:
- [Grant Mcdermott's arch tips repo](https://github.com/grantmcdermott/arch-tips)
- [Patrick Schratz Arch Linux setup guide for data science](https://pat-s.me/post/arch-install-guide-for-r/)
- [Anton Beloglazov's old arch cofig repo](https://github.com/beloglazov/arch-config)

Currently, instead of installing Arch Linux the traditional way, I am using the [EndeavourOS](https://endeavouros.com/) distrobution. EndeavourOS is an Arch-based linux distrobution that is much easier to install and was recommended to me by Grant McDermott in his Data Science for Economists class at the University of Oregon.

Currently I have installed EndeavourOS with two desktop environments: Gnome and i3wm. Gnome is more traditional and similar to MacOS but i3 is cool and I have enjoyed messing around with it. Currently I am mostly just using i3 but I wanted Gnome installed for more stability just in case.

# 00. Installation

## 001. Setting up partitions

Follow the guide on [Patrick Schratz guide](https://pat-s.me/post/arch-install-guide-for-r/#setting-up-the-partitions). I really don't understand a lot about these options yet so I blindly followed these instruction which have worked well so far. As I become more familiar and opinionated, this document will be updated.

# 01. Package manager

My favorite package manager is the `pacman` wrapper [`trizen`](https://github.com/trizen/trizen). To install trizen:

```
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
```

Alternatively run the bash script in this repository `install-01-trizen.sh`

To prevent PKGBUILD edit prompts when installing packages with `trizen` - in the config file `~/.config/trizen/trizen.conf` set `noedit => 1`

To enable parallel compiling to increase the speed at which packages compile set the `MAKEVARS` variable in `/etc/makepkg.conf` to `MAKEFLAGS="-j$(nproc)"`. All cores can now be used to compile new packages.

Finally, if your system only has 8 GB of RAM, Patrick Schratz recommends that you temporarily increase the size of your `/tmp` folder:

```
sudo mount -o remount, size = 20g,noatime /tmp
```

**CAUTION: Try to avoid installing python libraries using `pip` if the can be installed from AUR instead. This may mess up some dependcies and give you a hard time. If the package is not available on AUR then you should be good- for example: radian for R console in terminal is not available on AUR so I installed via `pip`.**

 

# 02. Shell

`bash` is standard in most linux distrobutions. However, I am currently enjoying [`fish`](https://fishshell.com/) which seems to be easier on beginners.

Still need to write up how I set fish to default shell in `.bashrc`

# 03. Apps

I am in the process of writing a shell script that will install all my standard apps, packages, and libraries with one command.

# 04. Git

I am writing a shell script that sets my git config and ssh for a quicker setup

# 05. Bluetooth

Setting up bluetooth is kinda a bitch. I have a markdown file with instructions that I need to add here.

# 06. Fonts

Writing a shell script that installs all my favorite fonts.

