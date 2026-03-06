#!/bin/bash

# Cargar el tema
#source "$HOME/scripts/dmenu/themes/colors"
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"
# Texto puro sin iconos para evitar los cuadros blancos
#opciones="Apagar\nReiniciar\nSuspender\nCerrar Sesion"
opciones=$(cat <<EOF
a) Suspender
s) Apagar
d) Reiniciar
f) Cerrar sesion
EOF
)
# El comando dmenu
seleccionado=$(echo -e "$opciones" | dmenu -i -l 15 "${DMENU_THEME[@]}" -p "Sistema:")

case "$seleccionado" in
	"a) Suspender") systemctl suspend ;;
	"s) Apagar") systemctl poweroff ;;
	"d) Reiniciar") systemctl reboot ;;
	"f) Cerrar Sesion") i3-msg exit ;;
esac
