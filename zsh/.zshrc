# Enable Powerlevel10k instant prompt. Initialization that requires user input
# (password prompts, [y/n] etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git z)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR=code

# Prompt (run `p10k configure` or edit ~/.p10k.zsh)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Haskell (ghcup)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Conda, loaded lazily on first use to keep shell startup fast
conda() {
  unfunction conda
  local setup
  if setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"; then
    eval "$setup"
  elif [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/opt/anaconda3/bin:$PATH"
  fi
  conda "$@"
}

# Aliases
alias c="clear"
alias lg="lazygit"

# Syntax highlighting (must stay last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
