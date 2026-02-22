#!/bin/bash

# Agregamos la carpeta donde viven los scripts al PATH de este proceso
export PATH="$PATH:$HOME/scripts/dmenu"
# 1. Cargar el tema:
source "$HOME/scripts/dmenu/themes/template"

# 1. Cargar la paleta
#source "$HOME/themes/paletas/mocha"
# 2. EXPORTAR para que los scripts hijos (como sistema.sh) lo vean
# Nota: Los arrays no se pueden exportar directamente de forma simple, 
# así que exportaremos la RUTA del tema para que el hijo haga su propio source.
export CURRENT_THEME="$HOME/scripts/dmenu/themes/template"

# Definimos las opciones con una letra al principio para elegir rápido
opciones="v -> Neovim\nf -> Firefox\na -> Archivos (Buscador)\nw -> WiFi\nt -> Temporizador\np -> Power Menu\ns -> screenshot\ni -> inkscape\nc -> apariencia\nn -> notes.sh\ne -> thunar\nk -> krita\nh -> chrome"

# Lanzamos dmenu
# -i (ignorar mayúsculas), -l 10 (lista vertical), -p (el título del menú)

#seleccionado=$(echo -e "$opciones" | dmenu -i -l 10 -p "Ejecutar:")
seleccion=$(echo -e "$opciones" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Ejecutar:")
# Extraemos solo la primera letra para el caso (case)
accion=$(echo "$seleccion" | cut -d' ' -f1)

case "$accion" in

    v) alacritty -e nvim ;;
    f) firefox ;;
	h) google-chrome-stable ;;
	i) inkscape ;;
	e) thunar ;;
    a) busqueda.sh ;; 
	k) krita ;;
    w) wifi.sh ;; 
	t) cronometro.sh ;; 
    p) sistema.sh ;;
	s) screenshot.sh ;; 
	#c) carpetas.sh ;; #pendiente
	n) notes.sh ;; #pendiente
	c) apariencia.sh ;;
	*) exit 1 ;;

esac


