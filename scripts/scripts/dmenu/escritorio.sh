#!/bin/bash

# Si existe la variable exportada por el padre, úsala. 
# Si no (por si corres el script solo), usa una ruta por defecto.
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/template}"

# 1. Escanear y obtener lista de SSIDs (limpiando el formato de nmcli)
# Mostramos: Intensidad, Seguridad y Nombre
opciones="a) Project\ns) Learn\nd) I&D" 

seleccion=$(echo -e "$opciones" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Set up:")

# Lógica de ejecución
case "$seleccion" in
	"a) Project")
	# --- Escritorio 1: Neovim con archivos específicos ---
	i3-msg "workspace 1" 
	# Abrimos nvim con los 3 archivos en pestañas o buffers
	alacritty -e nvim ~/Documentos/ideas/juiciness.md &
	#Esperar a que la terminal aparezca
	while [ -z "$(xdotool search --class Alacritty)" ]; do sleep 0.5; done
	sleep 0.5 #espera para que termine de cargar

	# --- Escritorio 2: Gemini ---
	i3-msg "workspace 2"
	google-chrome-stable --new-window "https://gemini.google.com" &
	while ! xdotool getwindowfocus getwindowname | grep -iq "google\|gemini"; do sleep 0.3 
	done
	sleep 0.3

	# --- Escritorio 3: YouTube ---
	i3-msg "workspace 3"
	google-chrome-stable --new-window "https://youtube.com" &
	while ! xdotool getwindowfocus getwindowname | grep -iq "youtube"; do sleep 0.3 
	done

	# Regresar al escritorio 1 para empezar
	# sleep 0.5
	i3-msg "workspace 1" 
	;;

	"s) Learn")
	# 2. Abrir curso.py en el Escritorio 1
	i3-msg "workspace 2"
	alacritty -e nvim ~/scripts/python/curso.py &

	# 3. Abrir la plataforma de Python al lado de nvim (i3 dividirá la pantalla)
	#Usamos --app para que se vea más como una herramienta y menos como navegador
	google-chrome-stable --app="https://www.learnpython.org/en/Welcome" &
	;;
# 4. (Opcional) Ajustar el layout para que nvim ocupe más espacio
# sleep 1
# i3-msg "resize set width 60 ppt"
#
	"d) I&D")
	# i3-msg "workspace 2"
	alacritty -e nvim &
	google-chrome-stable & #--new-window "https://gemini.google.com" &
	;; 
esac
