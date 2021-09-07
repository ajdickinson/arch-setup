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

To prevent PKGBUILD edit prompts when installing packages with `trizen` - in the config file `~/.config/trizen/trizen.conf` set `noedit => 1`

To enable parallel compiling to increase the speed at which packages compile set the `MAKEVARS` variable in `/etc/makepkg.conf` to `MAKEFLAGS="-j$(nproc)"`. All cores can now be used to compile new packages.

Finally, if your system only has 8 GB of RAM, Patrick Schratz recommends that you temporarily increase the size of your `/tmp` folder:

```
sudo mount -o remount, size = 20g,noatime /tmp
```

**CAUTION: Try to avoid installing python libraries using `pip` if the can be installed from AUR instead. This may mess up some dependcies and give you a hard time. If the package is not available on AUR then you should be good- for example: radian for R console in terminal is not available on AUR so I installed via `pip`.**

 

# 02. Shell

`bash` is standard in most linux distrobutions. However, I am currently enjoying [`fish`](https://fishshell.com/) which seems to be easier on beginners.

To install the fish shell run the following command:

```
trizen -S fish
```

To set fish as default, simply add `fish` to the end of the `.bashrc` file. The `.bashrc` file runs every time terminal is opened.

# 03. Apps

I am in the process of writing a shell script that will install all my standard apps, packages, and libraries with one command.

# 04. Git

Git comes installed on EndeavourOS. First we have to configure it by adding our username and email

```
git config --global user.name "ajdickinson"
git config --global user.email "adickin3@uoregon.edu"
```

I like to setup SSH for git on all my machines. To generate a SSH key run the following command:

```
ssh-keygen -t ed25519 -C "adickin3@uoregon.edu"
```
This will prompt a few questions - follow in terminal. To add this SSSH key to the SSH agent use the following two commands:

```
eval "($ssh-agent -s)"
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
sudo pacman -S github-cli
```

One must autheticate following the install. Run the following command and follow the directions to setup your account:

```
gh auth login
```

Then to clone the `arch-setup` repo, use the following command

```
gh repo clone arch-setup
```

# 05. Bluetooth

Setting up bluetooth is kinda a bitch. I have a markdown file with instructions that I need to add here.

# 06. Fonts

Writing a shell script that installs all my favorite fonts.

