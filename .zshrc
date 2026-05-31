# Directory for zinit and its plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if not there yet, and comment it out after first time use
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" --depth 1
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit wait lucid light-mode for \
	atinit'zicompinit; zicdreplay' \
		zsh-users/zsh-syntax-highlighting \
	zsh-users/zsh-completions \
	Aloxaf/fzf-tab \
	MichaelAquilina/zsh-you-should-use \
	atload'_zsh_autosuggest_start' \
		zsh-users/zsh-autosuggestions

zinit wait lucid for \
	OMZ::plugins/git/git.plugin.zsh \
	OMZ::plugins/eza/eza.plugin.zsh \
	OMZ::plugins/dirhistory/dirhistory.plugin.zsh

zinit from"gh-r" as"program" mv"direnv* -> direnv" \
	atclone'chmod +x direnv; ./direnv hook zsh > zhook.zsh' atpull'%atclone' \
	pick"direnv" src="zhook.zsh" for \
		direnv/direnv

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Environment variables
export YSU_MESSAGE_POSITION="after"
export EDITOR=hx

# Aliases
alias aria='aria2c'
alias c='clear'
alias fastfetch='fastfetch --config examples/10.jsonc'
alias compile='g++ -ggdb -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -std=c++23'

# Keybindings
bindkey -e
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
