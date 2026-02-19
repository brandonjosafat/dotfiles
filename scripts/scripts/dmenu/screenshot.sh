#!/bin/bash

# Si existe la variable exportada por el padre, úsala. 
# Si no (por si corres el script solo), usa una ruta por defecto.
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/template}"

# 1. Definimos las opciones que verá el usuario
opciones="󰹑 Pantalla Completa\n󰒅 Seleccionar Área\n󱎫 Retraso (5s)"

# 2. Pasamos las opciones a dmenu y guardamos la elección
seleccion=$(echo -e "$opciones" | dmenu -i "${DMENU_THEME[@]}" -p "Captura:")

# 3. Lógica de ejecución
case "$seleccion" in
    "󰹑 Pantalla Completa")
        scrot '%Y-%m-%d-%T.png' -e 'mv $f ~/Imágenes/Capturas/' ;;
    "󰒅 Seleccionar Área")
        scrot -s '%Y-%m-%d-%T.png' -e 'mv $f ~/Imágenes/Capturas/' ;;
    "󱎫 Retraso (5s)")
        sleep 5 && scrot '%Y-%m-%d-%T.png' -e 'mv $f ~/Imágenes/Capturas/' ;;
esac
