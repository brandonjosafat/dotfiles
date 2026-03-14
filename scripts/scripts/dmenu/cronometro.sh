#
# # Pedir minutos
# #!/usr/bin/env bash
# # Si existe la variable exportada por el padre, úsala. 
# # Si no (por si corres el script solo), usa una ruta por defecto.
# source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"
#
# # Pedir minutos
# # MINUTES=$(echo -e "1\n5\n25" | dmenu "${DMENU_THEME[@]}" -p "Minutos:")
#
# # opciones="a -> 1\ns -> 5\nd -> 10\nf -> 15\ng -> 25" #| dmenu "${DMENU_THEME[@]}" -p "Minutos:")
# opciones="a)Flow\ns)Walk"
# # opciones=$(cat <<EOF
# # a Flow
# # s Walk
# # EOF
# # )
#
# seleccion=$(echo -e "$opciones" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Minutes:")
#
# accion=$(echo "$seleccion" | cut -d' ' -f1)
#  # [[ -z "$MINUTES" ]] && exit 0
#  # [[ "$MINUTES" =~ ^[0-9]+$ ]] || exit 0
# #Lógica de ejecución
# case "$accion" in
# 	"a)Flow") MINUTES=25 ;;
# 	"s)Walk") MINUTES=5 ;;
# 	# d) MINUTES=10 ;;
# 	# f) MINUTES=15 ;;
# 	# g) MINUTES=25 ;;
# 	*) exit 1 ;;
# esac
#
# SECONDS=$((MINUTES * 60))
# #sleep "$SECONDS"
#
#
# # SECONDS=$((MINUTES * 60))
#
# notify-send "Temporizador" "Iniciado por $MINUTES min"
#
# (
#     sleep "$SECONDS"
#
#     # Reproducir un sonido suave de Debian
#     # Si no te gusta el de 'Front_Center', prueba 'Side_Left.wav'
#     play -n -c1 synth 3 sine 440 vol 1 > /dev/null 2>&1
#
#     notify-send "TIEMPO AGOTADO" "¡Continua así!" #-u critical
# ) &
#
# exit 0
#
#

#!/usr/bin/env bash
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"

# 1. Definimos las opciones visuales
opciones="a) Flow (25m)\ns) Walk (5m)"

# 2. Capturamos la selección (puede ser el texto de arriba o un número escrito por ti)
seleccion=$(echo -e "$opciones" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Minutos o acción:")

# 3. Lógica inteligente
case "$seleccion" in
    "a) Flow (25m)") MINUTES=25 ;;
    "s) Walk (5m)")  MINUTES=5 ;;
    *) 
        # Si no elegiste una opción de la lista, verificamos si escribiste un número
        if [[ "$seleccion" =~ ^[0-9]+$ ]]; then
            MINUTES=$seleccion
        else
            notify-send "Error" "Entrada no válida: escribe un número"
            exit 1
        fi
        ;;
esac

# 4. Ejecución
SECONDS=$((MINUTES * 60))
notify-send "Temporizador" "Iniciado por $MINUTES min"

(
    sleep "$SECONDS"
    play -n -c1 synth 3 sine 440 vol 1 > /dev/null 2>&1
    notify-send "TIEMPO AGOTADO" "¡Continúa así!"
) &

exit 0
