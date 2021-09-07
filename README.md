This repository is a guide/documentation of my current linux set to streamline any future installations. If anything this repo is simple a record of how I set up my machines so I do not forget. So far this README is in rough rough shape but will change once I find more time to add to it. Hopefully in a few years as I add more and more edits this document will be useful for others as well. As of right now this page is mostly just setup instructions that I have borrowed from elsewhere that I liked and wanted to keep track of. It also includes things that were annoying to setup the first time (e.g. bluetooth) and are a record of how I set things up for future reference.

Based off the following references:
- [Grant Mcdermott's arch tips repo](https://github.com/grantmcdermott/arch-tips)
- [Patrick Schratz Arch Linux setup guide for data science](https://pat-s.me/post/arch-install-guide-for-r/)
- [Anton Beloglazov's old arch cofig repo](https://github.com/beloglazov/arch-config)

As opposed to a traditional Arch Linux installation I am using the [EndeavourOS](https://endeavouros.com/) distribution. EndeavourOS is an Arch-based linux distribution that is much easier to install and was recommended to me by Grant McDermott in his Data Science for Economists class at the University of Oregon.

Currently I have installed EndeavourOS with i3wm which is a simple window manager that I have enjoyed using. Before I used Gnome and recommend it. It is more traditional and similar to MacOS.

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

To prevent PKGBUILD edit prompts when installing packages with `trizen` - in the config file `~/.config/trizen/trizen.conf` set `noedit => 1`

To enable parallel compiling to increase the speed at which packages compile set the `MAKEVARS` variable in `/etc/makepkg.conf` to `MAKEFLAGS="-j$(nproc)"`. All cores can now be used to compile new packages.

Finally, if your system only has 8 GB of RAM, Patrick Schratz recommends that you temporarily increase the size of your `/tmp` folder:

```
sudo mount -o remount, size = 20g,noatime /tmp
```

**CAUTION: Try to avoid installing python libraries using `pip` if the can be installed from pacman instead. This may mess up some dependcies and give you a hard time. If the package is not available on AUR then you should be good- for example: radian for R console in terminal is not available on AUR so I installed via `pip`.** 

# 02. Git

Git comes installed on EndeavourOS and I like to configure it first so I can quickly access this repo to clone onto my fresh install. Most of these instructions were found on the GitHub documentation.

First we have to configure it by adding username and email

```
git config --global user.name "username"
git config --global user.email "email@mail.com"
```

I like to setup SSH for git on all my machines. To generate a SSH key run the following command:

```
ssh-keygen -t ed25519 -C "email@mail.com"
```
This will prompt a few questions - follow in terminal. To add this SSSH key to the SSH agent use the following two commands:

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Running the first command in `fish` has resulted in an error on my system. To get around it, change back to bash and rerun it using `sh`

Next we need to add our SSH key to GitHub so it is recognized. To do this I like to install `xclip` to easily copy the key right from the SSH key file.

```
trizen -S xclip
```

To copy the key to clipboard use the following command:

```
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

Once you have the key in your clipboard, go to [GitHub](www.github.com) click on Settings > SSH and GPG Keys > New SSH Key or Add SSH Key. Paste with the key in clipboard and name it and click Add SSH Key.

First thing I do is add the contents of this repo locally so I can use the scripts set up to install all my applications/packages. To do so I install the GitHub CLI (command line interface) so I can use my terminal. To install:

```
trizen -S github-cli
```

One must autheticate following the install. Run the following command and follow the directions to setup your account:

```
gh auth login
```

First make sure to change your directory to stay organized. I like to keep my `arch-setup` folder in `Documents`. To clone the `arch-setup` repo, use the following command

```
gh repo clone arch-setup
```

# 02 Desktop setup

I have some config files that setup my custom desktop. These are just personal preference.

The `config` folder contains the config files.

## 021 i3 Config

Move the `i3-config` file from the `config` folder to `~/.config/i3/` and rename as `config`

```
cp ./config/i3-config ~/.config/i3/config
```

This should replace the config file that is generated during installation.

## 022 Polybar Config

`Polybar` is a neat package that creates a customizable status bar that is aesthetically pleasing and works well with i3. To install `polybar` use the command:

```
trizen -S polybar
```

Then copy my config file from `config` to `~/.config/polybar/config`

```
cp arch-setup/config/polybar-config ~/.config/polybar/config
```

Now the example polybar config file which my config file is based off of  requires some additional font packages. Install them with the two commands:

```
sudo pacman -S xorg-fonts-misc
```

```
yay -S siji-git ttf-unifont
```

Now we must set up a launch script in the polybar config directory. Paste the following in a new shell script `~/.config/polybar/launch.sh`:

```
#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar example 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
```
Next we need to adjust permissions on the launch script using this command:

```
chmod +x $HOME/.config/polybar/launch.sh
```

Finally ensure the i3 configuration file has an `exec_always` command to start the polybar on sign in.
 


# 02. Shell

`bash` is standard in most linux distrobutions. However, I am currently enjoying [`fish`](https://fishshell.com/) which seems to be easier on beginners.

To install the fish shell run the following command:

```
trizen -S fish
```

To set fish as default, simply add `fish` to the end of the `.bashrc` file. The `.bashrc` file runs every time terminal is opened.

I need to add urxvt installation and configuration

#03. Apps

I am in the process of writing a shell script that will install all my standard apps, packages, and libraries with one or more commands.



# 05. Bluetooth

To setup bluetooth, we need a few packages: `bluez` (preinstalled), `bluez-utils` (preinstalled), and `blueberry`. If you have run the shell script titled `install-03-apps.sh` then you should have these packages already.

My linux workstation uses a usb bluetooth adaptor. To ensure the `btusb` kernel module is loaded, use the following command

```
lsmod | grep btusb
```

Next to ensure that bluetooth is started and enabled the following run the following:

```
systemctl start bluetooth.service
systemctl enable bluetooth.service
```

To configure bluetooth to power on following each boot, change the config file `/etc/bluetooth/main.conf` such that `AutoEnable=true`



# R

## CCache

## OpenBlas

## R packages

## Radian

# Python

```
trizen -S python-gdal python-yaml python-jinja python-psycopg2 python-owslib python-numpy python-pygments
```

# rsync

# SSH

# 06. Fonts

Writing a shell script that installs all my favorite fonts.

