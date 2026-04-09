#!/usr/bin/env bash

# Uso: ./notificar_sonido.sh "Título" "Mensaje" "Urgencia(low/normal/critical)"

TITULO=$1
MENSAJE=$2
URGENCIA=${3:-normal} # Si no se define, por defecto es normal

# 1. Notificación visual
/usr/bin/notify-send -u "$URGENCIA" "$TITULO" "$MENSAJE"

# 2. Lógica de Volumen
# Capturamos volumen actual
PREV_VOL=$(/usr/bin/pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -1)

# Ajuste temporal al 40%
/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ 40%

# Sonido (un tono doble elegante)
/usr/bin/play -n -c1 synth 1 sine 550 vol 1 > /dev/null 2>&1
/usr/bin/play -n -c1 synth 0.5 sine 440 vol 0.8 > /dev/null 2>&1

# Restauración
/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ "${PREV_VOL}%"
