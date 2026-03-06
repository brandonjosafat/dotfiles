#!/bin/bash

# 1. Cargar el tema actual para que el menú se vea bien
source "$HOME/scripts/dmenu/themes/template"

# 2. El usuario elige el tema
opciones=$(ls "$HOME/Imágenes/wallpaper/others")
seleccion=$(echo -e "$opciones" | dmenu -i -l 15 "${DMENU_THEME[@]}" -p "Wallpaper:")

# 3. Si no hay selección, salir
[ -z "$seleccion" ] && exit 0

# Dentro de apariencia.sh, antes del procesamiento de archivos
# case "$seleccion" in
#     "gruvbox")    NVIM_THEME="gruvbox" ;;
#     *)            NVIM_THEME="catppuccin-mocha" ;;
# feh --bg-fill "$HOME/Imágenes/wallpaper/others/$seleccion.jpg"

feh --bg-scale "$HOME/Imágenes/wallpaper/others/$seleccion"



