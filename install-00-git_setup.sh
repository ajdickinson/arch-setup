# configure git
git config --global user.name "ajdickinson"
git config --global user.email "adickin3@uoregon.edu"

# generate a new ssh key
ssh-keygen -t ed25519 -C "adickin3@uoregon.edu"

# follow instructions to set new ssh directory + passcode

# now add ssh key to ssh agent
eval "$(ssh-agent -s)"
ssh-add ~/.shh/id_ed25519

# install xclip to copy contents of ssh file
# sudo pacman -S xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# instructions for adding key to github account on browser
echo go to settings
echo click ssh and gpg keys
echo click new ssh key or add ssh key
echo paste key into key field
echo click add ssh key

# clone arch-setup repo
# install github command line interface
sudo pacman -S github-cli

# authenticate after install
gh auth login

# follow instruction to link to github account in browser

# clone arch-setup repo
gh repo clone arch-setup

