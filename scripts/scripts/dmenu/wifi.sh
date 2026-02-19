#!/bin/bash

# Si existe la variable exportada por el padre, úsala. 
# Si no (por si corres el script solo), usa una ruta por defecto.
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"

# 1. Escanear y obtener lista de SSIDs (limpiando el formato de nmcli)
# Mostramos: Intensidad, Seguridad y Nombre
redes=$(nmcli -f "BARS,SECURITY,SSID" device wifi list | sed 1d)

# 2. Elegir red
seleccion=$(echo -e "$redes" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "WiFi:")
# Extraemos solo el SSID (la última columna)
ssid=$(echo "$seleccion" | awk '{print $NF}')

# Si no seleccionaste nada, salir
[ -z "$ssid" ] && exit

# 3. Pedir contraseña (usando dmenu en modo 'password' con -P si tu dmenu lo soporta)
pass=$(echo "" | dmenu -p "Contraseña para $ssid:")

# 4. Intentar conexión
if [ -n "$pass" ]; then
    # Usamos alacrity para ver el proceso por si falla el sudo o la pass
    alacritty -e bash -c "nmcli dev wifi connect '$ssid' password '$pass'; sleep 3"
fi
