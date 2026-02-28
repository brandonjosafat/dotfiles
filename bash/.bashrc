export LS_OPTIONS='--color=auto'
#eval "$(dircolors -b)"
#cargar colores dinámicos
[ -f "$HOME/.cache/current_colors.sh" ] && source "$HOME/.cache/current_colors.sh"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lh'
alias l='ls $LS_OPTIONS -lA'
alias lf='LS_COLORS="$LS_COLORS" lf'
alias src='source ~/.bashrc'
alias fwall='feh --bg-scale'
alias win='cd /mnt/windows/Users/Brandon'
export PATH="$PATH:$HOME/scripts/dmenu"
export PATH="$HOME/.local/bin:$PATH"
export MY_THEMES="$HOME/scripts/dmenu/themes"
export PATH="$HOME/.cargo/bin:$PATH"
export LS_COLORS=$LS_COLORS:'ow=01;34:tw=01;34:'
