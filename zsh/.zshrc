# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Dotfiles - Zsh configuration with Oh My Zsh
# =============================================================================

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
# https://github.com/romkatv/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
    git
    docker
    kubectl
    history
    sudo
    aws
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load Powerlevel10k configuration if it exists
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =============================================================================
# User configuration
# =============================================================================

# Default editor
export EDITOR='vim'

# History
HISTSIZE=10000
SAVEHIST=10000

# =============================================================================
# Aliases
# =============================================================================

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# File listing
alias ll='ls -lah'
alias la='ls -la'

# Git
alias gs='git status'
alias gp='git pull'
alias gc='git commit'
alias gd='git diff'

# =============================================================================
# OS-specific configuration
# =============================================================================

case "$(uname -s)" in
    Darwin)
        # macOS specific
        export PATH="/opt/homebrew/bin:$PATH"
        ;;
    Linux)
        # Linux specific
        ;;
esac

# =============================================================================
# Local configuration (not versioned)
# =============================================================================

# Load local configuration if it exists
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
