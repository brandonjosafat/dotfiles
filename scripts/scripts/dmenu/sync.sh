#!/bin/bash

#Crear ruta absoluta
dots_dir="$HOME/dotfiles"

#1. navegar a la carpeta de dotfiles
cd "$dots_dir" || exit

#Actualizar enlacces con stow
# usar -R para limpiar los rotos y crear nuevos
for dir in */; do
	package=${dir%/}
	if [ "$package" != ".git" ]; then
		stow -R "$package"
	fi
done

#3. git add, commit y push
git add -A
# al ser automático, usamos un mensaje generico con fecha
git commit  -m "Auto-sync: $(date +'%Y-%m-%d %H:%M')"
git push origin main

#4. Notificación final
if [ $? -eq 0 ]; then 
	notify-send "Dotfiles" "sincronización exitosa y pushrealizado" -i system-software-update
else notify-send "Dotfiles" "Error en la sincronización" -u critical
fi
