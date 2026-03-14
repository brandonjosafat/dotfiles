#!/bin/bash
#1. cargar tema
source "${CURRENT_THEME:-$HOME/scripts/dmenu/themes/template}"
# 2. Pedir operación.
input=$(echo "" | dmenu -i "${DMENU_THEME[@]}" -p "Cálculo:")

# Si no hay entrada (o se cancela), salir
[ -z "$input" ] && exit 0 

# Calcular usando bc
result=$(echo "scale=2; $input" | bc -l 2>/dev/null)

#Mostrar resultado
if [[ -n "$result" ]]; then
	#se usa el arrai de nuevo para el resultado con tema
	echo "$result" | dmenu -i "${DMENU_THEME[@]}" -p "Resultado (enter para salir):"
else
	echo "Error en la operación" | dmenu -i "${DMENU_THEME[@]}" -p "Aviso:"
fi
