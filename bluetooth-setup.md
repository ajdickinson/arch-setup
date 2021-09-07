List of steps to setup bluetooth on current EndeavourOS arch distro

# Install bluetooth packages
sudo pacman -S bluez bluez-utils blueberry 

# check to make sure btusb kernel module is loaded
lsmod | grep btusb

systemctl start bluetooth.service
systemctl enable bluetooth.service

# configure power-on after boot
# in /etc/bluetooth/main.conf change
# AutoEnable = true

# run blueberry to open the GUI
blueberry

