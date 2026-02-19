#!/bin/bash

# 1. Cargar el tema actual para que ESTE dmenu se vea bien
source "$HOME/scripts/dmenu/themes/template"

# 2. Listar opciones y pedir al usuario que elija
opciones=$(ls "$HOME/themes/paletas/")
seleccion=$(echo -e "$opciones" | dmenu -i "${DMENU_THEME[@]}" -p "Seleccionar tema:")

# 3. Si el usuario no eligió nada (presionó ESC), salir
[ -z "$seleccion" ] && exit 0

# 4. CARGAR LA PALETA ELEGIDA (Aquí corregimos la ruta)
# Importante: Usamos la "/" entre paletas y la variable
source "$HOME/themes/paletas/$seleccion"

# 5. Función de procesamiento (Plano -> Realidad)
procesar() {
    # Verificamos que las variables no estén vacías antes de procesar
    if [ -z "$COLOR_BG" ]; then
        echo "Error: No se cargaron las variables de $seleccion"
        exit 1
    fi
    sed -e "s/COLOR_BG/$COLOR_BG/g" \
        -e "s/COLOR_FG/$COLOR_FG/g" \
        -e "s/COLOR_ACCENT/$COLOR_ACCENT/g" \
        -e "s/COLOR_SELECT/$COLOR_SELECT/g" \
        -e "s/COLOR_BORDER/$COLOR_BORDER/g" \
        "$1" > "$2"
}

# 6. Ejecutar los cambios
procesar "$HOME/.config/alacritty/alacritty.toml.template" "$HOME/.config/alacritty/alacritty.toml"
procesar "$HOME/.config/i3/config.template" "$HOME/.config/i3/config"
# Dentro de tu función o flujo de procesamiento
procesar "$HOME/.config/i3status/config.template" "$HOME/.config/i3status/config"
procesar "$HOME/.config/lf/lfrc.template" "$HOME/.config/lf/lfrc"
# Dentro de apariencia.sh, antes de terminar:
export LS_COLORS="di=01;35" # Esto pondrá las carpetas en color magenta/accent
# 7. Sincronizar dmenu (El archivo que lee el Script Maestro)
echo "DMENU_THEME=( -nb '$COLOR_BG' -nf '$COLOR_FG' -sb '$COLOR_ACCENT' -sf '$COLOR_BG' -fn 'JetBrainsMono Nerd Font:pixelsize=14' )" > "$HOME/scripts/dmenu/themes/template"

# 8. Reiniciar i3 para aplicar cambios
i3-msg -t get_version >/dev/null && i3-msg restart

echo "¡Sistema actualizado a $seleccion!"
