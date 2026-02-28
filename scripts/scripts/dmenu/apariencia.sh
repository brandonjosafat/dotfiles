#!/bin/bash

# 1. Cargar el tema actual para que el menú se vea bien
source "$HOME/scripts/dmenu/themes/template"

# 2. El usuario elige el tema
opciones=$(ls "$HOME/themes/paletas/")
seleccion=$(echo -e "$opciones" | dmenu -i "${DMENU_THEME[@]}" -p "Seleccionar tema:")

# 3. Si no hay selección, salir
[ -z "$seleccion" ] && exit 0

# 4. Cargar la paleta elegida
source "$HOME/themes/paletas/$seleccion"

# 5. Lógica de colores para las carpetas (Ahora sí sabe qué elegiste)
case "$seleccion" in
    "sunset")     FOLDER_COLOR="38;5;208" ;; # Naranja
    "everforest") FOLDER_COLOR="38;5;108" ;; # Verde
    "nord")       FOLDER_COLOR="38;5;110" ;; # Azul Nord
    "mocha")      FOLDER_COLOR="38;5;147" ;; # Lavanda
    "gruvbox")    FOLDER_COLOR="38;5;214" ;; # Amarillo
    *)            FOLDER_COLOR="34"       ;; # Azul
esac

# Generar caché de colores para Bash y LF
echo "export LS_COLORS=\"di=$FOLDER_COLOR\"" > "$HOME/.cache/current_colors.sh"

# Dentro de apariencia.sh, antes del procesamiento de archivos
case "$seleccion" in
    "sunset")     NVIM_THEME="rose-pine" ;; 
    "everforest") NVIM_THEME="everforest" ;;
    "nord")       NVIM_THEME="nord" ;;
    "mocha")      NVIM_THEME="catppuccin-mocha" ;;
    "gruvbox")    NVIM_THEME="gruvbox" ;;
    *)            NVIM_THEME="catppuccin-mocha" ;;
esac

# En la parte donde ejecutas "procesar"

# 6. Función de procesamiento
procesar() {
    sed -e "s/COLOR_BG/$COLOR_BG/g" \
        -e "s/COLOR_FG/$COLOR_FG/g" \
        -e "s/COLOR_ACCENT/$COLOR_ACCENT/g" \
        -e "s/COLOR_SELECT/$COLOR_SELECT/g" \
        -e "s/COLOR_BORDER/$COLOR_BORDER/g" \
        "$1" > "$2"
}

# 7. Aplicar a todos los archivos
procesar "$HOME/.config/alacritty/alacritty.toml.template" "$HOME/.config/alacritty/alacritty.toml"
procesar "$HOME/.config/i3/config.template" "$HOME/.config/i3/config"
procesar "$HOME/.config/i3status/config.template" "$HOME/.config/i3status/config"
procesar "$HOME/.config/lf/lfrc.template" "$HOME/.config/lf/lfrc"
procesar "$HOME/.config/dunst/dunstrc.template" "$HOME/.config/dunst/dunstrc"
dunstctl reload
sed "s/COLOR_THEME/$NVIM_THEME/g" "$HOME/.config/nvim/lua/colores.lua.template" > "$HOME/.config/nvim/lua/colores.lua"
# 8. Sincronizar dmenu
echo "DMENU_THEME=( -nb '$COLOR_BG' -nf '$COLOR_FG' -sb '$COLOR_ACCENT' -sf '$COLOR_BG' -fn 'JetBrainsMono Nerd Font:pixelsize=14' )" > "$HOME/scripts/dmenu/themes/template"

# 9. Aplicar cambios visuales
feh --bg-fill "$HOME/Imágenes/wallpaper/$seleccion.png"
export LS_COLORS="di=$FOLDER_COLOR"
lf -remote "send set colors" 2>/dev/null
i3-msg -t get_version >/dev/null && i3-msg restart
echo "¡Sistema actualizado a $seleccion!"
