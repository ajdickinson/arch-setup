# install trizen package manager
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si

# instruction prevents prompts to edit PKGBUILD
echo in `~/.config/trizen/trizen.conf` set `no_edit => 1`


