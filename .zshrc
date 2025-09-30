# Directory for zinit and its plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if not there yet, and comment it out after first time use
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Zsh plugins
zinit ice wait'!' lucid nocd \
	atload'!prompt_starship_precmd; _zsh_highlight_main__precmd_hook'
zinit light zsh-users/zsh-syntax-highlighting

zinit wait lucid light-mode for \
	zsh-users/zsh-completions \
	Aloxaf/fzf-tab

zinit wait lucid atload'_zsh_autosuggest_start' light-mode for \
	zsh-users/zsh-autosuggestions

zinit wait lucid for \
	OMZ::plugins/git/git.plugin.zsh \
	MichaelAquilina/zsh-you-should-use

zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
	atpull'%atclone' pick"direnv" src"zhook.zsh" for \
		direnv/direnv

# Load Completions
autoload -U compinit && compinit

zinit cdreplay -q

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
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias aria='aria2c'
alias ls='ls --color'
alias c='clear'
alias fastfetch='fastfetch --config examples/10.jsonc'
alias compile='g++ -ggdb -pedantic-errors -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -std=c++23'
alias cd='z'

# Keybindings
bindkey -e
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Pywal Support
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)

# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh
