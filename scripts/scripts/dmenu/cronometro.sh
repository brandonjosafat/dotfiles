
# Pedir minutos
#!/usr/bin/env bash
# Si existe la variable exportada por el padre, úsala. 
# Si no (por si corres el script solo), usa una ruta por defecto.
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"

# Pedir minutos
# MINUTES=$(echo -e "1\n5\n25" | dmenu "${DMENU_THEME[@]}" -p "Minutos:")

# opciones="a -> 1\ns -> 5\nd -> 10\nf -> 15\ng -> 25" #| dmenu "${DMENU_THEME[@]}" -p "Minutos:")
opciones="a)Flow\ns)Walk"
# opciones=$(cat <<EOF
# a Flow
# s Walk
# EOF
# )

seleccion=$(echo -e "$opciones" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Minutes:")

accion=$(echo "$seleccion" | cut -d' ' -f1)
 # [[ -z "$MINUTES" ]] && exit 0
 # [[ "$MINUTES" =~ ^[0-9]+$ ]] || exit 0
#Lógica de ejecución
case "$accion" in
	"a)Flow") MINUTES=25 ;;
	"s)Walk") MINUTES=5 ;;
	# d) MINUTES=10 ;;
	# f) MINUTES=15 ;;
	# g) MINUTES=25 ;;
	*) exit 1 ;;
esac

SECONDS=$((MINUTES * 60))
#sleep "$SECONDS"


# SECONDS=$((MINUTES * 60))

notify-send "Temporizador" "Iniciado por $MINUTES min"

(
    sleep "$SECONDS"
    
    # Reproducir un sonido suave de Debian
    # Si no te gusta el de 'Front_Center', prueba 'Side_Left.wav'
    play -n -c1 synth 3 sine 440 vol 1 > /dev/null 2>&1
    
    notify-send "TIEMPO AGOTADO" "¡Continua así!" #-u critical
) &

exit 0
