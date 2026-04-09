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

	$HOME/scripts/utils/notificar_sonido.sh "TIEMPO AGOTADO" "!Continúa así!" "normal"
) &

exit 0



