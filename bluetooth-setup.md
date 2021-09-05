List of steps to setup bluetooth on current EndeavourOS arch distro

# Install bluetooth packages
sudo pacman -S bluez bluez-utils blueman blueberry 

# check to make sure btusb kernel module is loaded
lsmod | grep btusb

start bluetooth.service
# enable bluetooth.service

# run blueberry to open the GUI
blueberry

