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

cp ./.zshrc /home/$USER
echo "Installed ZSH config."

cp ./aria2 /home/$USER/.config/
echo "Installed aria2 config."

if [[ -d /home/$USER/.config/helix ]]; then
	cp -r ./helix/config.toml /home/$USER/.config/helix/config.toml
	echo "Installed helix config"
else
	mkdir /home/$USER/.config/helix
	cp ./helix/config.toml /home/$USER/.config/helix/config.toml
fi

echo "Install zellij config?(y/n)"
read ifZellij
if [[ $ifZellij = 'y' ]]; then
	cp -r ./zellij /home/$USER/.config/
	echo "Installed Zellij config"
fi

echo "Install Rose-Pine starship config?(y/n)"
read ifRosepine
if [[ $ifRosepine = 'y' ]]; then
	git clone https://github.com/rose-pine/starship.git /tmp/rosepine
	cp /tmp/rosepine/rose-pine.toml /home/$USER/.config/starship.toml
	echo "Installed starship config"
fi

echo "Install alacritty config?(y/n)"
read ifAlacritty
if [[ $ifAlacritty = 'y' ]]; then
	cp -r ./alacritty /home/$USER/.config/
fi

echo "Install fonts?(y/n)"
read ifFonts
if [[ $ifFonts = 'y' ]]; then
	mkdir -p ~/.local/share/fonts
	curl -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.tar.xz" | tar -xJf - -C ~/.local/share/fonts --wildcards "*.ttf"
	curl -L -o /tmp/suse.zip "https://github.com/SUSE/suse-font/releases/download/v2.001/suse-font-v2.001.zip"
	unzip /tmp/suse.zip -d /tmp/suse
	cp /tmp/suse/suse-font-v2.001/fonts/variable/* ~/.local/share/fonts
fi

echo "Finished installing config files"
