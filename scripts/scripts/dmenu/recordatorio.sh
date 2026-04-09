# Name reminder
#!/usr/bin/env bash
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/catppuccin}"

#Pedir recordatorio
input=$(echo "" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "Reminder:")

#si no hay respuesta, salir
[ -z "$input" ] && exit 0

#Si hay respuesta solicitar tiempo de esperaj
tiempo=$(echo "" | dmenu -i -l 10 "${DMENU_THEME[@]}" -p "time:")

#si cancela salir
[ -z "$tiempo" ] && exit 0


#si escribiste un numero
if [[ "$tiempo" =~ ^[0-9]+$ ]]; then
	MINUTES=$tiempo
else
	nofify-send "Error" "Entrada no valida: escriba un numero"
	exit 1
fi

#ejecución
SECONDS=$((MINUTES * 60))
notify-send "Recordatorio" "iniciado"

(
    sleep "$SECONDS"
    play -n -c1 synth 3 sine 440 vol 1 > /dev/null 2>&1
    notify-send "Recuerda" "$input"
) &

exit 0

