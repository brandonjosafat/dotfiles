#!/bin/bash

#Cargar tema
source "$HOME/scripts/dmenu/themes/template"

Dir="/home/brandon/Documentos/ideas/"

# seleccion=$(echo -e ls "$Dir" | dmenu -i -l 15 "${DMENU_THEME[@]}" -p "Notes:")
seleccion=$(ls "$Dir" | dmenu -i -l 15 "${DMENU_THEME[@]}" -p "Notes:")
[ -z "$seleccion" ] && exit 0
# if [ -n "$seleccion" ]; then
# 	alacritty -e nvim "$seleccion"
# fi
alacritty -e nvim "$Dir$seleccion"

