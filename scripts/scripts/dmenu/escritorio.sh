#!/bin/bash

# Si existe la variable exportada por el padre, úsala. 
# Si no (por si corres el script solo), usa una ruta por defecto.
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/template}"

# 1. Escanear y obtener lista de SSIDs (limpiando el formato de nmcli)
# Mostramos: Intensidad, Seguridad y Nombre
opciones="Flow\nLearn" 

seleccion=$(echo -e "$opciones" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Set up:")

# Lógica de ejecución
case "$seleccion" in
	"Flow")
	# --- Escritorio 1: Neovim con archivos específicos ---
	i3-msg "workspace 1" # Opcional si usas layouts
	# Abrimos nvim con los 3 archivos en pestañas o buffers
	alacritty -e nvim ~/Documentos/ideas/simulacion.txt ~/Documentos/ideas/contenido.txt &
	#Esperar a que la terminal aparezca
	while [ -z "$(xdotool search --class Alacritty)" ]; do sleep 0.5; done

	# --- Escritorio 2: Gemini ---
	i3-msg "workspace 2"
	google-chrome-stable --new-window "https://gemini.google.com" &
	while [ -z "$(xdotool search --onlyvisible --class "Google-chrome")" ]; do sleep 0.5; 
	done

	# --- Escritorio 3: YouTube ---
	i3-msg "workspace 3"
	google-chrome-stable --new-window "https://youtube.com" &
	while [ -z "$(xdotool search --class google-chrome-stable)" ]; do sleep 0.5; 
	done


	# Regresar al escritorio 1 para empezar
	sleep 0.5
	i3-msg "workspace 1" 
	;;

	"Learn")
	# 2. Abrir curso.py en el Escritorio 1
	i3-msg "workspace 2"
	alacritty -e nvim ~/scripts/python/curso.py &

	# 3. Abrir la plataforma de Python al lado de nvim (i3 dividirá la pantalla)
	#Usamos --app para que se vea más como una herramienta y menos como navegador
	google-chrome-stable --app="https://www.learnpython.org/en/Welcome" &
	;;
# # # 4. (Opcional) Ajustar el layout para que nvim ocupe más espacio
# # sleep 1
# # i3-msg "resize set width 60 ppt"
esac
