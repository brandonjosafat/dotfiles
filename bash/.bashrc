export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

export PATH="$PATH:$HOME/scripts/dmenu"
export PATH="$HOME/.local/bin:$PATH"
export MY_THEMES="$HOME/scripts/dmenu/themes"
export PATH="$HOME/.cargo/bin:$PATH"

