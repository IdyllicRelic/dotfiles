#!/bin/bash

logfile=./logs/$(date "+%Y%m%d_%H%M%S").log

mkdir ./logs
cp .zshrc /home/$USER &>> $logfile
echo "Installed ZSH config."
cp -r ./helix /home/$USER/.config &>> $logfile
echo "Installed helix config"

echo "Do you want to install Rose-Pine starship config?"
read ifRosepine
if [ $ifRosepine = 'yes']; then
  git clone https://github.com/rose-pine/starship.git &>> $logfile
  cp ./starship/rose-pine.toml /home/$USER/.config/starship.toml &>> $logfile
  echo "Installed starship config"
fi

echo "Do you want to install alacritty config?"
read ifAlacritty
if [ $ifAlacritty = 'yes']; then
  cp ./alacritty /home/$USER/.config &>> $logfile
fi

echo "Finished installing config files"
