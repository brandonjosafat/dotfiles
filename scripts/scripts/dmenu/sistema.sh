#!/bin/bash

# Cargar el tema
#source "$HOME/scripts/dmenu/themes/colors"
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"
# Texto puro sin iconos para evitar los cuadros blancos
opciones="Apagar\nReiniciar\nSuspender\nCerrar Sesion"

# El comando dmenu
seleccionado=$(echo -e "$opciones" | dmenu -i "${DMENU_THEME[@]}" -p "Sistema:")

case "$seleccionado" in
    "Apagar") systemctl poweroff ;;
    "Reiniciar") systemctl reboot ;;
    "Suspender") systemctl suspend ;;
    "Cerrar Sesion") i3-msg exit ;;
esac
