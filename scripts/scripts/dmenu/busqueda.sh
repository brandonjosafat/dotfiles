#!/bin/bash

# Si existe la variable exportada por el padre, úsala. 
# Si no (por si corres el script solo), usa una ruta por defecto.
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"

# Usamos rutas absolutas con $HOME para evitar problemas de expansión
# Agregamos comillas para manejar carpetas con espacios
archivo=$(find "$HOME" -type f | dmenu -i -l 20 "${DMENU_THEME[@]}" -p "Abrir:")

# Salir si el usuario cancela dmenu
[ -z "$archivo" ] && exit 0

# Convertir a minúsculas para una comparación más fácil
extension="${archivo##*.}"
extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]' )

# 2. Detectar el tipo real del archivo (útil para archivos sin extensión como 'config')
tipo_mime=$(file --mime-type -b "$archivo")

# Lógica de apertura
case "$extension" in
    jpg|jpeg|png|gif|svg|bmp)
        # --start-at ayuda a feh a entender la ruta exacta
        feh --geometry 800x600 --auto-zoom "$archivo" &i
		#feh --auto-zoom "$archivo" &
        ;;
    pdf)
        # Forzamos Firefox para PDFs
        firefox "$archivo" &
        ;;
    txt|sh|md|conf|lua|py|json)
        alacritty -e nvim "$archivo" &
        ;;
    *)
        # Si no tiene extensión conocida, ¿es texto plano? (Ej: i3/config)
        if [[ "$tipo_mime" == text/* ]]; then
            alacritty -e nvim "$archivo" &
		else

		# Para lo demás, dejamos que el sistema decida
        xdg-open "$archivo" > /dev/null 2>&1 &
		fi
        ;;
esac
