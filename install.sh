#!/bin/bash

mkdir ./logs
logfile=$(touch ./logs/$(date "+%Y%m%d_%H%M%S").log)

echo "Configuring git..."
if command -v git; then
  git config --global user.name "Seyrn"
  git config --global user.email 147831357+IdyllicRelic@users.noreply.github.com
  git config --global init.defaultBranch main
  git config --global pull.rebase false
else
  echo "Please install git and try again"
  exit 1
fi

cp .zshrc /home/$USER &>> $logfile
echo "Installed ZSH config."
cp -r ./helix /home/$USER/.config &>> $logfile
echo "Installed helix config"

echo "Do you want to install Rose-Pine starship config?(yes/no)"
read ifRosepine
if [ $ifRosepine = 'yes' ]; then
  git clone https://github.com/rose-pine/starship.git &>> $logfile
  cp ./starship/rose-pine.toml /home/$USER/.config/starship.toml &>> $logfile
  echo "Installed starship config"
fi

echo "Do you want to install alacritty config?(yes/no)"
read ifAlacritty
if [ $ifAlacritty = 'yes' ]; then
  cp ./alacritty /home/$USER/.config &>> $logfile
fi

braveflags="--ignore-gpu-blocklist
--enable-zero-copy
--enable-features=AcceleratedVideoDecodeLinuxGL"
bravefdir="~/.var/app/com.brave.Browser/config"

echo "Do you want to setup hardware acceleration for Brave browser?(yes/no)"
read ifHW
if [ $ifHW = 'yes' ]; then
  if [ -d $bravefdir ]; then
    echo $braveflags > $bravefdir/brave-flags.conf
  else
    echo $braveflags > ~/.config/brave-flags.conf
  fi
fi

echo "Finished installing config files"
