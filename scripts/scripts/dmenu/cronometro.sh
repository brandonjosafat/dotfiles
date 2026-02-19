
# Pedir minutos
#!/usr/bin/env bash
# Si existe la variable exportada por el padre, úsala. 
# Si no (por si corres el script solo), usa una ruta por defecto.
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"

# Pedir minutos
MINUTES=$(echo -e "1\n5\n25" | dmenu "${DMENU_THEME[@]}" -p "Minutos:")

[[ -z "$MINUTES" ]] && exit 0
[[ "$MINUTES" =~ ^[0-9]+$ ]] || exit 0

SECONDS=$((MINUTES * 60))

notify-send "Temporizador" "Iniciado por $MINUTES min"

(
    sleep "$SECONDS"
    
    # Reproducir un sonido suave de Debian
    # Si no te gusta el de 'Front_Center', prueba 'Side_Left.wav'
    play -n -c1 synth 3 sine 440 vol 1 > /dev/null 2>&1
    
    notify-send "TIEMPO AGOTADO" "¡A descansar!" #-u critical
) &

exit 0
