#!/bin/bash
#Definir entorno del usuario
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export XDG_RUNTIME_DIR=/run/user/$(id -u)    

UMBRAL=15
BATERIA_INFO=$(acpi -b)
CAPACIDAD=$(echo "$BATERIA_INFO" | grep -P -o '[0-9]+(?=%)')
ESTADO=$(echo "$BATERIA_INFO" | grep -P -o 'Discharging|Charging|Full' | head -1)

# Si la batería está baja y no se está cargando
    # if [ "$NIVEL" -le "$UMBRAL" ] && [ "$ESTADO" != "Charging" ]; then
# # Si la capacidad es menor o igual al umbral
if [ "$CAPACIDAD" -le "$UMBRAL" ] && [ "$ESTADO" != "Charging" ]; then
        # Notificación visual (siempre sale mientras sea menor al umbral)
    /usr/bin/notify-send "Batería Crítica" "Nivel actual: $CAPACIDAD%"

    
    # Sonido (usando ALSA explícitamente por si acaso)
    /usr/bin/play -n -c1 synth 1 sine 440 vol 1 > /dev/null 2>&1

fi
