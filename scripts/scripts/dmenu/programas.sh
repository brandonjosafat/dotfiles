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

# 2. DEFINICIÓN DE OPCIONES (Aquí es donde editas)
# Solo editas esta lista. El formato es: letra) comando
# Usamos un bloque de texto limpio para que dmenu lo lea.
menu_data=$(cat <<EOF
a) cronometro.sh
s) escritorio.sh
d) google-chrome-stable
f) alacritty -e nvim
j) apariencia.sh
k) captura.sh
l) sistema.sh
ñ) wifi.sh
q) wallpaper.sh
w) notes.sh
EOF
)
# e) Thunar            -> thunar
# i) Inkscape          -> inkscape
# n) Notes             -> notes.sh

# Lanzamos dmenu
# -i (ignorar mayúsculas), -l 10 (lista vertical), -p (el título del menú)

#seleccionado=$(echo -e "$opciones" | dmenu -i -l 10 -p "Ejecutar:")
# seleccion=$(echo -e "$opciones" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Ejecutar:")

# Extraemos solo la primera letra para el caso (case)
# accion=$(echo "$seleccion" | cut -d' ' -f1)
# Lanzamos dmenu (opciones ya tiene los saltos de línea internos)
# seleccion=$(echo "$opciones" | dmenu -i -l 15 "${DMENU_THEME[@]}" -p "Ejecutar:")
# 3. EJECUCIÓN DE DMENU
# Mostramos la lista y guardamos la línea elegida
seleccion=$(echo "$menu_data" | dmenu -i -l 15 "${DMENU_THEME[@]}" -p "Ejecutar:")

# Si el usuario presiona ESC o no elige nada, salimos
[ -z "$seleccion" ] && exit 0

# 4. EXTRACCIÓN DEL COMANDO
# Aquí ocurre la "magia": buscamos la línea elegida y cortamos después de "-> "
ejecutar=$(echo "$seleccion" | awk -F') ' '{print $2}' | xargs)

# 5. EJECUCIÓN FINAL
# Ejecutamos el comando recuperado
eval "$ejecutar" &
# Extraemos la letra

# accion=$(echo "$seleccion" | cut -d' ' -f1)


