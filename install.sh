#!/usr/bin/env bash

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

cp .zshrc /home/$USER 
echo "Installed ZSH config."

if [[ -d /home/$USER/.config/helix ]]; then
  cp -r ./helix/config.toml /home/$USER/.config/helix/config.toml
  echo "Installed helix config"
else
  mkdir /home/$USER/.config/helix
  cp ./helix/config.toml /home/$USER/.config/helix/config.toml
fi

echo "Do you want to install zellij config?(y/n)"
read ifZellij
if [[ $ifZellij = 'y' ]]; then
  cp -r ./zellij /home/$USER/.config/
  echo "Installed Zellij config"
fi

echo "Do you want to install Rose-Pine starship config?(y/n)"
read ifRosepine
if [[ $ifRosepine = 'y' ]]; then
  git clone https://github.com/rose-pine/starship.git /tmp/rosepine
  cp /tmp/rosepine/rose-pine.toml /home/$USER/.config/starship.toml 
  echo "Installed starship config"
fi

echo "Do you want to install alacritty config?(y/n)"
read ifAlacritty
if [[ $ifAlacritty = 'y' ]]; then
  cp -r ./alacritty /home/$USER/.config/ 
fi

echo "Finished installing config files"
