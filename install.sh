#!/bin/bash

cp .zshrc /home/$USER
echo "Installed ZSH config."
cp -r ./helix /home/$USER/.config
echo "Installed helix config"

git clone https://github.com/rose-pine/starship.git
cp ./starship/rose-pine.toml /home/$USER/.config/starship.toml
echo "Installed starship config"

echo "Do you want to install alacritty config?"
read if-alacritty
if [ $if-alacritty = 'yes']; then
  cp ./alacritty /home/$USER/.config
fi

echo "Finished installing config files"
